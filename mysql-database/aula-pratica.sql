-- 1. CONFIGURAÇÃO INICIAL
create database aulapratica;
use aulapratica;
set SQL_SAFE_UPDATES = 0;

-- 2. CRIAÇÃO DAS TABELAS (DDL)
create table estado (
	id int primary key auto_increment,
    nome varchar(70),
    sigla char(1)
);

create table cidade (
	id int primary key auto_increment,
    nome varchar(70),
    estadoid int,
    constraint idestado foreign key (estadoid) references estado(id)
);

create table inventario(
	id int primary key auto_increment,
    item_nome varchar(100) not null,
    quantidade int,
    preco_unitario decimal(10,2)
);

-- Corrigindo a sigla para 2 caracteres
alter table estado modify sigla char(2);

-- 3. INSERÇÃO DE DADOS (DML)
insert into estado(nome, sigla) values
('Parana','PR'),('Santa Catarina','SC'),('Rio Grande Do sul','RS');

insert into cidade(nome,estadoid) values
('São Jose dos pinhais', 1),('Curitiba', 1);

insert into cidade(nome, estadoid) values
('Lages',2),('Blumenal',2);

insert into cidade(nome, estadoid) values
('Porto Alegre',3),('Gramado',3);

insert into inventario(item_nome, quantidade, preco_unitario) values
('Porca Sextavada', 100, 0.80),
('Parafuso Sextavado', 100, 1.20), 
('inserto tnmg', 10, 34.00), 
('inserto knux', 10, 45.00), 
('fresa topo',20 ,50.00), 
('fresa esferica', 20, 50.00); 

-- 4. MANUTENÇÃO DE DADOS
-- Aumento de 10% no preço de todos os itens
update inventario 
set preco_unitario = preco_unitario *1.10;

-- Corrigindo nome de cidade específica (Ex: Gramado vira Cidade Teste)
update cidade
set  nome = 'Cidade Teste'
where nome = 'Gramado';

-- Deletando um item específico
delete from inventario where item_nome = 'Porca Sextavada';

-- Relatório com INNER JOIN (Cidades e seus Estados)
select 
	cidade.nome as nome_cidade,
    estado.nome as nome_estado
from cidade 
inner join estado
on cidade.estadoid = estado.id;

-- Busca com LIKE (Itens que começam com F)
select * from inventario where item_nome like 'F%';

-- Relatório de Status com CASE (Logística de Estoque)
SELECT 
    item_nome, 
    quantidade,
    CASE 
        WHEN quantidade > 20 THEN 'Estoque OK'
        WHEN quantidade BETWEEN 11 AND 20 THEN 'Alerta: Baixo'
        ELSE 'Repor Urgente!'
    END AS status_estoque
FROM inventario;