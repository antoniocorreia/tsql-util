
CREATE UNIQUE INDEX ui_ukEstabelecimentoNome ON dbo.Estabelecimento(Id); 
CREATE FULLTEXT INDEX ON dbo.Estabelecimento(Nome LANGUAGE 'PORTUGUESE') KEY INDEX ui_ukEstabelecimentoNome  ON ftCatalog 
ALTER FULLTEXT INDEX ON dbo.Estabelecimento ENABLE; 


CREATE UNIQUE INDEX ui_ukTipoNome ON dbo.Tipo(Id); 
CREATE FULLTEXT INDEX ON dbo.Tipo(Nome LANGUAGE 'PORTUGUESE') KEY INDEX ui_ukTipoNome  ON ftCatalog 
ALTER FULLTEXT INDEX ON dbo.Tipo ENABLE; 


CREATE UNIQUE INDEX ui_ukPalavraChaveNome ON dbo.PalavraChaveEstabelecimento(Id); 
CREATE FULLTEXT INDEX ON dbo.PalavraChaveEstabelecimento(Nome LANGUAGE 'PORTUGUESE') KEY INDEX ui_ukPalavraChaveNome  ON ftCatalog 
ALTER FULLTEXT INDEX ON dbo.PalavraChaveEstabelecimento ENABLE; 



SELECT e.Id, MAX(ISNULL(k.[RANK],0) + ISNULL(kt.[RANK],0)) as ranking--,e.Nome, t.Nome, k.[RANK], kt.[RANK]
FROM Estabelecimento e
JOIN TipoEstabelecimento te ON te.IdEstabelecimento = e.Id
JOIN Tipo t ON t.Id = te.IdTipo
LEFT join FREETEXTTABLE(dbo.Estabelecimento, Nome,'bares pizzaria') as k on e.Id = k.[key]
LEFT join FREETEXTTABLE(dbo.Tipo, Nome, 'bares pizzaria') as kt on kt.[key] = t.Id
--WHERE FREETEXT (e.Nome, 'bares pizzaria') OR FREETEXT (t.Nome, 'bares pizzaria');
WHERE k.[RANK] IS NOT NULL OR kt.[RANK] IS NOT NULL
--ORDER BY k.[RANK] DESC, kt.[RANK] DESC
GROUP BY e.Id
order by ranking desc





select * from sys.fulltext_languages

  