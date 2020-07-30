
-- Relatório Vendas

-- Explorando dados para o relatório da area de vendas que precisa visualizar a vendas por região e pelo flag online ou offline
-- Na tabelas SalesOrderHeader já temos a informação se é online ou não e a data da venda ( informação diaria)
-- A tabela salesOrderDetail conseguimos o valor e linkar com a tabela de território
-- A tabela de SalesTerritory é a tabela reponsável pela região 
Select sum(sd.LineTotal), s.OnlineOrderFlag, st.CountryRegionCode, s.OrderDate
from AdventureWorks2014.SalesOrderHeader s
INNER JOIN AdventureWorks2014.SalesOrderDetail sd
on s.SalesOrderID = sd.SalesOrderID
INNER JOIN AdventureWorks2014.SalesTerritory st -- SALes Terrytory
on  st.TerritoryID = s.TerritoryID
GROUP BY  s.OnlineOrderFlag, st.CountryRegionCode, s.OrderDate

-- Incluir informações sobre vendedores com melhor e pior desempenho no relatório existente. 
-- vendedor com maior valor de  vendas
select  s.SalesYTD, pe.FirstName
from AdventureWorks2014.SalesPerson s
inner join AdventureWorks2014.Employee e
on s.BusinessEntityID = e.BusinessEntityID
inner join AdventureWorks2014.Person pe 
on pe.BusinessEntityID = e.BusinessEntityID
where e.CurrentFlag = 1 
order by s.SalesYTD DESC
LIMIT 1


-- vendedor com menor valor de  vendas
select  s.SalesYTD, pe.FirstName
from AdventureWorks2014.SalesPerson s
inner join AdventureWorks2014.Employee e
on s.BusinessEntityID = e.BusinessEntityID
inner join AdventureWorks2014.Person pe 
on pe.BusinessEntityID = e.BusinessEntityID
where e.CurrentFlag = 1 
order by s.SalesYTD asc
LIMIT 1;


-- desenvolver um relatório novo com dados mensais, da distrubuição de produtos por região com métricas de quantidade de venda e valor
Select SUM(sd.OrderQty), AVG(sd.UnitPrice), sum(sd.LineTotal), s.OnlineOrderFlag, st.CountryRegionCode, MONTH(s.OrderDate) , YEAR(s.OrderDate), prod.Name
from AdventureWorks2014.SalesOrderHeader s
INNER JOIN AdventureWorks2014.SalesOrderDetail sd
on s.SalesOrderID = sd.SalesOrderID 
INNER JOIN AdventureWorks2014.Product prod
on sd.ProductID = prod.ProductID
INNER JOIN AdventureWorks2014.SalesTerritory st -- SALes Terrytory
on  st.TerritoryID = s.TerritoryID
GROUP BY  s.OnlineOrderFlag, st.CountryRegionCode, MONTH(s.OrderDate) , YEAR(s.OrderDate), prod.Name


-- Também foi solicitado um arquivo contendo informações de produtos vendidos, vendedor que realizou, distribuido por região e data este
-- arquivo foi solicitado semanalmente para que o time de possa realizer analyses manuais.
-- semanal?

Select SUM(sd.OrderQty), AVG(sd.UnitPrice), sum(sd.LineTotal), s.OnlineOrderFlag, st.CountryRegionCode, s.OrderDate, prod.Name, spe.BusinessEntityID, pe.FirstName, pe.LastName
from AdventureWorks2014.SalesOrderHeader s
INNER JOIN AdventureWorks2014.SalesOrderDetail sd
on s.SalesOrderID = sd.SalesOrderID 
INNER JOIN AdventureWorks2014.Product prod
on sd.ProductID = prod.ProductID
INNER JOIN AdventureWorks2014.SalesTerritory st -- SALes Terrytory
on  st.TerritoryID = s.TerritoryID
INNER JOIN AdventureWorks2014.SalesPerson spe
on s.SalesPersonID = spe.BUSINESSENTITYID
INNER JOIN AdventureWorks2014.Person pe
on spe.BusinessEntityID = pe.BusinessEntityID
GROUP BY  s.OnlineOrderFlag, st.CountryRegionCode, s.OrderDate, prod.Name,  spe.BusinessEntityID, pe.FirstName, pe.LastName






-- Ciencia de Dados

-- Explorando dados para ciencia de dados, ele precisam de dados de vendas,  vendedores, clientes e produtos
-- acessando os dados e verificando os campos disponiveis 
select * from AdventureWorks2014.SalesOrderHeader so
INNER JOIN AdventureWorks2014.SalesOrderDetail sd
on so.SalesOrderID = so.SalesOrderID
INNER JOIN AdventureWorks2014.Product p
on sd.ProductID = p.ProductID
inner join AdventureWorks2014.Customer c
on so.CustomerID = c.CustomerID
inner join AdventureWorks2014.SalesPerson spe
on so.SalesPersonID = spe.BUSINESSENTITYID
inner join AdventureWorks2014.Person pe
on c.PersonID = pe.BusinessEntityID

-- A solicitação é de uma nova amostra de dados com informações da entidades de Cliente, Produtos, Vendas e Vendedores, removendo a
-- entidade de cliente e incluindo as informações existentes sobre as lojas das vendas.
select p.*, pe.*, so.*, sd.*
from AdventureWorks2014.SalesOrderHeader so
INNER JOIN AdventureWorks2014.SalesOrderDetail sd
on so.SalesOrderID = so.SalesOrderID
INNER JOIN AdventureWorks2014.Product p
on sd.ProductID = p.ProductID
inner join AdventureWorks2014.Customer c
on so.CustomerID = c.CustomerID
inner join AdventureWorks2014.SalesPerson spe
on so.SalesPersonID = spe.BUSINESSENTITYID
inner join AdventureWorks2014.Person pe
on c.PersonID = pe.BusinessEntityID


-- Tabela com os vendores, ele não vem com nome e detalhes, preciso mais uma tabela com detalhes a Person
describe AdventureWorks2014.SalesPerson sp
select * from AdventureWorks2014.SalesPerson sp

-- Tabela responsavel por informações pessoais como nome dos vendedores e clientes.
describe AdventureWorks2014.Person

-- Tabela com os Produtos 
describe AdventureWorks2014.Product

-- Tabela com os Clientes
describe AdventureWorks2014.Customer




