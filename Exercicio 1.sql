create database LIVRARIA
create table EDITORIAL
STATUS para verificar qual banco você está.

CREATE TABLE EDITORIAL(
	Titulo VARCHAR(100),
	Autor VARCHAR(30),
	Sexo VARCHAR(10),
	Paginas VARCHAR(3),
	Editora VARCHAR(15),
	Valor float(10),
	UF CHAR(2),
	Ano_de_Publicacao CHAR (4)
	);
	
	
INSERT INTO EDITORIAL (Titulo,Autor,Sexo,Paginas,Editora,Valor,UF,Ano_de_publicacao) VALUES 
('Cavaleiro Real', 'Ana Claudia', 'Feminino','465','Atlas',49.9,'RJ','2009');

INSERT INTO EDITORIAL (Titulo,Autor,Sexo,Paginas,Editora,Valor,UF,Ano_de_Publicacao) VALUES
('SQL para leigos','João Nunes', 'Masculiono','450','Addison',98,'SP','2018');
		UPDATE editorial SET sexo = 'Masculino' WHERE sexo = 'masculiono';
		
		
INSERT INTO EDITORIAL (Titulo,Autor,Sexo,Paginas,Editora,Valor,UF,Ano_de_Publicacao) VALUES
('Receitas Caseiras','Celia Tavares','Feminino','210','Atlas',45,'RJ','2008');

INSERT INTO EDITORIAL(Titulo,Autor,Sexo,Paginas,Editora,Valor,UF,Ano_de_Publicacao) VALUES
('Pessoas Efetivas','Eduardo Santos','Masculino','390','Beta',78.99,'RJ','2018');

INSERT INTO EDITORIAL(Titulo,Autor,Sexo,Paginas,Editora,Valor,UF,Ano_de_Publicacao) VALUES
('Hábitos Saudáveis','Eduardo Santos','Masculino','630','Beta',150.98,'RJ','2019');

INSERT INTO EDITORIAL (Titulo,Autor,Sexo,Paginas,Editora,Valor,UF,Ano_de_Publicacao) VALUES
('A Casa Marrom','Hermes Macedo','Masculino','250','Bubba',60,'MG','2016');

INSERT INTO EDITORIAL (Titulo,Autor,Sexo,Paginas,Editora,Valor,UF,Ano_de_Publicacao) VALUES
('Estacio Querido','Geraldo Francisco','Masculino','310','Insignia',100,'ES','2015');

INSERT INTO EDITORIAL (Titulo,Autor,Sexo,Paginas,Editora,Valor,UF,Ano_de_Publicacao) VALUES
('Pra Sempre Amigas','Leda Silva','Feminino','510','Insignia',78.98,'ES','2011');

INSERT INTO EDITORIAL (Titulo,Autor,Sexo,Paginas,Editora,Valor,UF,Ano_de_Publicacao) VALUES
('Copas Inesqueciveis','Marco Alcântara','Masculino','200','Larson',130.98,'RS','2018');

INSERT INTO EDITORIAL (Titulo,Autor,Sexo,Paginas,Editora,Valor,UF,Ano_de_Publicacao) VALUES
('O Poder da Mente','Clara Mafra','Feminino','120','Continental',56.58,'SP','2017');


/*1- Trazer todos os dados. */
	SELECT * from editorial;
/*2- Trazer o nome do livro e o nome da editora. */
	SELECT titulo,editora from editorial;
/*3- Trazer o nome do livro e a UF dos livros publicados por autor do sexo Masculino. */
	SELECT titulo,UF,autor from editorial where sexo = 'masculino';
/*4- Trazer o nome do livro e as páginas dos livros publicados por autores do sexo feminino.*/
	SELECT titulo,paginas,sexo from editorial where sexo = 'feminino';
/*5- Trazer os valores dos livros das editoras de São Paulo*/
	SELECT titulo,valor from editorial where uf = 'SP';
		projeção é diferente de seleção. Não é porque um campo está na seleção(UF) ele tem que estar na projeção
/*6- Trazer os dados dos autores do sexo masculino que tiveram livros publicados por SP ou RJ*/
	SELECT titulo,autor,paginas,editora,valor,uf,ano_de_publicacao from editorial where sexo = 'masculino' and uf = 'RJ' or uf = 'SP'; - ERRADO
	SELECT titulo,autor,paginas,editora,valor,uf,ano_de_publicacao from editorial where sexo = 'masculino' and uf = 'RJ' or sexo = 'masculino' and  uf = 'SP'; - CORRETO
																															^^ FALTOU ADICIONAR 