Aprofundando 

/* Função */ 

/* IFNULL() - MySQL */

SELECT NOME,
	IFNULL(EMAIL,'Não possui') as 'EMAIL',
	ESTADO,
	NUMERO
FROM CLIENTE
INNER JOIN ENDEREÇO E
ON IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T 
ON IDCLIENTE = T.ID_CLIENTE;

		/*	Ficará assim: 
			+---------+-----------------------------+--------+------------+
			| NOME    | IFNULL(EMAIL,'Não possui')  | ESTADO | NUMERO     |
			+---------+-----------------------------+--------+------------+
			| GIOVANA | Não possui                  | RJ     | 33567765   |

	- IFNULL(COLUNA,'Mensagem').
	- Se não colocar o as 'EMAIL', ficará " IFNULL(EMAIL,'Não possui') " como o nome da coluna.
			+---------+-------------------+--------+------------+
			| NOME    | EMAIL             | ESTADO | NUMERO     |
			+---------+-------------------+--------+------------+
			| GIOVANA | Não possui        | RJ     | 33567765   | */


/* VIEW */

SELECT 	NOME,
		SEXO,
		IFNULL(EMAIL,'Não possui') as 'EMAIL',
		TIPO,
		NUMERO,
		BAIRRO,
		CIDADE,
		ESTADO
FROM CLIENTE
INNER JOIN TELEFONE T
ON IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDEREÇO E
ON IDCLIENTE = E.ID_CLIENTE;

/* CRIANDO UMA VIEW */

	CREATE VIEW RELATORIO AS 
	SELECT 	NOME,
			SEXO,
			IFNULL(EMAIL,'Não Possui') as 'EMAIL',
			TIPO,
			NUMERO,
			BAIRRO,
			CIDADE,
			ESTADO
	FROM CLIENTE
	INNER JOIN TELEFONE T
	ON IDCLIENTE = T.ID_CLIENTE
	INNER JOIN ENDEREÇO E
	ON IDCLIENTE = E.ID_CLIENTE;

	SELECT * FROM RELATORIO;
	 -- O Relatorio vai dar um ''CTRL V'' e fazer o select automaticamente do jeito que foi salvo. 

/* APAGANDO UMA VIEW */

	DROP VIEW RELATORIO

/* Inserindo um Prefixo */

	CREATE VIEW V_RELATORIO AS 
	SELECT 	NOME,
			SEXO,
			IFNULL(EMAIL,'Não Possui') as 'EMAIL',
			TIPO,
			NUMERO,
			BAIRRO,
			CIDADE,
			ESTADO
	FROM CLIENTE
	INNER JOIN TELEFONE T
	ON IDCLIENTE = T.ID_CLIENTE
	INNER JOIN ENDEREÇO E
	ON IDCLIENTE = E.ID_CLIENTE;


	CREATE VIEW V_RelatorioMasc AS 
	SELECT 	NOME,
			SEXO,
			IFNULL(EMAIL,'Não Possui') as 'EMAIL',
			TIPO,
			NUMERO,
			BAIRRO,
			CIDADE,
			ESTADO
	FROM CLIENTE
	INNER JOIN TELEFONE T
	ON IDCLIENTE = T.ID_CLIENTE
	INNER JOIN ENDEREÇO E
	ON IDCLIENTE = E.ID_CLIENTE
	WHERE SEXO = 'M';


	CREATE VIEW V_RelatorioFem AS 
	SELECT 	NOME,
			SEXO,
			IFNULL(EMAIL,'Não Possui') as 'EMAIL',
			TIPO,
			NUMERO,
			BAIRRO,
			CIDADE,
			ESTADO
	FROM CLIENTE
	INNER JOIN TELEFONE T
	ON IDCLIENTE = T.ID_CLIENTE
	INNER JOIN ENDEREÇO E
	ON IDCLIENTE = E.ID_CLIENTE
	WHERE SEXO = 'M';

SELECT NOME,NUMERO,ESTADO 
FROM V_RELATORIO;
-- FUNCIONA

/* UPDATE, INSERT E DELETE EM VIEW */

	UPDATE V_RELATORIO SET NOME = 'JOSE' WHERE NOME = 'JORGE';
	-- É permitido.


	INSERT INTO V_RELATORIO VALUES(
		'ANDREA','F','ANDREA@UOL.COM.BR','CEL','15648944','CENTRO','VITORIA','ES'
		);
	-- Can not insert into join view 'comercio.v_relatorio' without fields list
	INSERT INTO V_JOGADORES VALUES ('GUERRERO','RS');
	-- Permitido, pois não tem JOIN.
	-- Mas o ID estará NULO, pois só foi passado 2 elementos e o ID não foi passado como NOT NULL.



	CREATE VIEW V_JOGADORES AS 
	SELECT NOME,ESTADO
	FROM JOGADORES;

	DELETE FROM V_RELATORIO WHERE NOME = 'JORGE';
	-- Can not delete from join view 'comercio.v_relatorio'
	-- Não é permitido deletar de views com JOIN.

	DELETE FROM V_JOGADORES WHERE NOME ='GUERRERO';
	-- PERMITIDO, pois a view não tem JOIN.

/* ORDER BY 
 A única forma de ordenar uma tabela é com o comando ORDER BY, sem ele, o resultado é aleatório. */

-- TABELA UTILIZADA = ALUNOS

SELECT * FROM ALUNOS
ORDER BY NUMERO;

--OU

SELECT * FROM ALUNOS
ORDER BY 1;
-- Ordem crescente por número



SELECT * FROM ALUNOS
ORDER BY NOME;
--OU
SELECT * FROM ALUNOS
ORDER BY 2;
-- Ordem alfabética

/* ORDENANDO POR MAIS DE UMA COLUNA */
	SELECT * FROM ALUNOS
	ORDER BY NUMERO,NOME;
	-- Ordena os grupos que já estavam ordenados, porem fora de ordem dentro de si.
			 -- ANTES
			+--------+---------+
			| NUMERO | NOME    |
			+--------+---------+				
			|      1 | JOAO    |
			|      1 | MARIA   |
			|      1 | CLARA   |
			|      1 | JANAINA |
			-- DEPOIS
			+--------+---------+
			| NUMERO | NOME    |
			+--------+---------+
			|      1 | CLARA   |
			|      1 | JANAINA |
			|      1 | JOAO    |
			|      1 | MARIA   |

/* ORDER BY DESC/ASC */
	
	SELECT * FROM ALUNOS
	ORDER BY 1 ASC;
	-- ORDEM ASCENDENTE, mas é padrão. Mesmo sem o "ASC" ela ja fica ascendente.

	SELECT * FROM ALUNOS
	ORDER BY 1 DESC;
	-- ORDEM DESCENDENTE.

	SELECT * FROM ALUNOS
	ORDER BY 1,2 DESC;
	-- Dessa forma, a 1 coluna vai ficar ascendente e a 2 descendente.

	SELECT * FROM ALUNOS
	ORDER BY 1 DESC,2 DESC;
	-- Dessa forma, as 2 ficam descendentes.

	SELECT * FROM V_RELATORIO
	ORDER BY 1;
		+---------+------+-------------------+------+------------+------------+----------------+--------+
		| NOME    | SEXO | EMAIL             | TIPO | NUMERO     | BAIRRO     | CIDADE         | ESTADO |
		+---------+------+-------------------+------+------------+------------+----------------+--------+
		| ADRIANA | F    | ADRIANA@GMAIL.COM | RES  | 77755785   | CENTRO     | RIO DE JANEIRO | RJ     |
		| ADRIANA | F    | ADRIANA@GMAIL.COM | COM  | 44522578   | CENTRO     | RIO DE JANEIRO | RJ     |
		| ANA     | F    | ANA@IG.COM        | CEL  | 1567898789 | JARDINS    | SÃO PAULO      | SP     |
		| ANTONIO | M    | ANTONIO@UOL.COM   | CEL  | 99655768   | BOM RETIRO | CURITIBA       | PR     |
		| ANTONIO | M    | ANTONIO@IG.COM    | COM  | 88679978   | JARDINS    | SAO PAULO      | SP     |
		| CARLOS  | M    | CARLOS@IG.COM     | RES  | 5512132318 | ESTACIO    | RIO DE JANEIRO | RJ     |


/* DELIMITADOR */

/*
O ; é o delimitador padrão do SQL, sem ele, o comando não executa.
Para mudar o delimitador, deve-se colocar o comando:

DELIMITER @

*/

/* STORED PROCEDURES */

SELECT 'MAFRA';


 /* CRIANDO PROCEDURE */
	DELIMITER $ --Necessário alterar o delimiter SEMPRE que for criar uma procedure
	CREATE PROCEDURE NOME()
	BEGIN
		SELECT * FROM CLIENTE; -- QUALQUER COMANDO;
	END
	$
	-- Alterar o delimiter é necessário para que o banco não pare no meio da leitura de uma procedure.


	CREATE PROCEDURE NOME_EMPRESA()
	BEGIN
		
		SELECT 'UNIVERSIDADE DOS DADOS' AS EMPRESA;

	END 
	$
  /* CHAMAR PROCEDURE */
	CALL NOME_EMPRESA()$
	DELIMITER ;
	CALL NOME_EMPRESA();


  /* PROCEDURES COM PARÂMETROS */
  	CREATE PROCEDURE CONTA()
  	BEGIN
  		SELECT 10+10 AS CONTA;
  	END
  	$

  	CALL CONTA();


	CREATE PROCEDURE CONTA(NUMERO1 INT, NUMERO2 INT)
  	BEGIN
  		SELECT NUMERO1 + NUMERO2 AS CONTA;
  	END
  	$

  	CALL CONTA(100,50)$
		+-------+
		| CONTA |
		+-------+
		|   150 |
		+-------+

  /* APAGANDO PROCEDURE */
  	DROP PROCEDURE CONTA;

 /* Criando outro banco de dados */

 CREATE DATABASE PROJETO2;

 CREATE TABLE CURSOS(
 	IDCURSO INT PRIMARY KEY AUTO_INCREMENT,
 	NOME VARCHAR(30) NOT NULL,
 	HORAS INT(3) NOT NULL,
 	VALOR FLOAT(10,2) NOT NULL
 	);

INSERT INTO CURSOS VALUES (NULL,'Java',30,500.0);
INSERT INTO CURSOS VALUES (NULL,'Fundamentos de Banco de Dados',40,700.00);
INSERT INTO CURSOS VALUES (NULL,'Java',30,500.0);
INSERT INTO CURSOS VALUES (NULL,'Java',30,500.0);
INSERT INTO CURSOS VALUES (NULL,'Java',30,500.0);



DELIMITER #
CREATE PROCEDURE CADASTRO_CURSO(P_NOME VARCHAR(30),
								P_HORAS INT (3),
								P_PRECO FLOAT(10,2))
BEGIN
	INSERT INTO CURSOS VALUES (NULL,P_NOME,P_HORAS,P_PRECO);
END
#

CALL CADASTRO_CURSO ('BI SQL SERVER',35,3000.00);
CALL CADASTRO_CURSO ('POWER BI',20,1000.00);
CALL CADASTRO_CURSO ('TABLEAU',30,1200.00);

/* Criar uma procedure para consultar cursos */

	Delimiter $
	Create procedure Checar(p_id int)
	Begin
		Select idcurso,nome,horas,valor from cursos
		where idcurso = p_id;
	End
	$
	Delimiter ;


/*	Coisa minha - fora do curso */
			Create table Aluno(
			Idaluno int primary Key auto_increment,
			Nome varchar(30) not null,
			Sexo char(1) not null,
			Idade int (2),
			Curso varchar (30),
			Assinante ENUM ('SIM','NÃO') not null
			);

			Create table endereço(
			Idendereco int primary key auto_increment,
			Cidade varchar (30),
			Estado char(2) not null,
			id_aluno int UNIQUE,

			Foreign key (id_aluno)
			References aluno (idaluno)
			);

			Create table ctt(
			Idcontato int primary key auto_increment,
			cpf varchar (30),
			celular char(2) not null,
			id_aluno int UNIQUE,

			Foreign key (id_aluno)
			References aluno (idaluno)
			);

			Create table trabalho(
			Idtrab int primary key auto_increment,
			trab ENUM ('SIM','NÃO'),
			setor varchar(20) not null,
			id_aluno int,

			Foreign key (id_aluno)
			References aluno (idaluno)
			);
/*		insert into aluno values (NULL,'Joao','M',18,'SQL','SIM');
		insert into aluno values (NULL,'Maria','F',20,'Java','NÃO');
		insert into aluno values (NULL,'Tadeu','M',25,'Paito','Não');
		insert into aluno values (NULL,'Raile','F',21,'Musica','SIM');
		insert into endereço values (NULL,'Recife','PE',1);
		insert into endereço values (NULL,'São Luis','MA',2);
		insert into endereço values (NULL,'Salvador','BA',3);
		insert into endereço values (NULL,'Candeias','PE',3);
		insert into endereço values (NULL,'Rio Branco','AC',4);
		insert into ctt values (NULL,'123','81',1);
		insert into ctt values (NULL,'123','30',1);
		insert into ctt values (NULL,'435','47',2);
		insert into trabalho values(NULL,'SIM','Caixa',1);
		insert into trabalho values(NULL,'SIM','Gerente',1);
		insert into trabalho values(NULL,'NÃO','Cliente',2);*/



		Select e.id_aluno,nome,cidade,celular 
		from aluno
		inner join endereço e
		on idaluno = e.id_aluno
		inner join ctt c 
		on idaluno = c.id_aluno;

		SELECT e.id_aluno,nome,cidade,celular,trab,setor
		from aluno
		inner join endereço e
		on idaluno = e.id_aluno
		inner join ctt c 
		on idaluno = c.id_aluno
		inner join trabalho t 
		on idaluno = t.id_aluno; 


/* CURSO - AULA 70 */

CREATE TABLE VENDEDORES(
	IDVENDEDOR INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30),
	SEXO CHAR(1),
	JANEIRO FLOAT(10,2),
	FEVEREIRO FLOAT (10,2),
	MARÇO FLOAT (10,2)
);

/* MAX - Traz o valor máximo de uma coluna */

SELECT MAX(FEVEREIRO) AS 'MEAIOR_DE_FEVEREIRO'
FROM VENDEDORES;

/* MIN - Traz o valor mínimo de uma coluna */

SELECT MIN(FEVEREIRO) AS 'MENOR_DE_FEVEREIRO'
FROM VENDEDORES;

/* AVG - Traz o valor médio de uma coluna */

SELECT AVG(FEVEREIRO) AS 'MÉDIA_DE_FEVEREIRO'
FROM VENDEDORES;

/* Misturando */

SELECT MAX(JANEIRO) AS 'MAX_JAN',
	   MIN(JANEIRO) AS 'MIN_JAN',
	   AVG(JANEIRO) AS 'MEDIA_JAN'
	   From vendedores;
	/*  +-----------+---------+---------------+
		| MAX_JAN   | MIN_JAN | MEDIA_JAN     |
		+-----------+---------+---------------+
		| 676545.75 | 4785.78 | 124429.901794 |
		+-----------+---------+---------------+ */


/* TRUNCATE - Limita a vírgula */

SELECT TRUNCATE (MAX(JANEIRO),1) AS 'MAX_JAN',
	   TRUNCATE (MIN(JANEIRO),2) AS 'MIN_JAN',
	   TRUNCATE (AVG(JANEIRO),3) AS 'MEDIA_JAN'
	   From vendedores;

	/*  +----------+---------+------------+
		| MAX_JAN  | MIN_JAN | MEDIA_JAN  |
	    +----------+---------+------------+
		| 676545.7 | 4785.77 | 124429.901 |
		+----------+---------+------------+ */

/* SUM() - Soma os valores das colunas  */

SELECT SUM(JANEIRO) AS 'TOTAL_JAN'
FROM VENDEDORES;
-- Somou todos os valores da coluna de Janeiro.

SELECT SUM(JANEIRO) AS 'TOTAL_JAN',
	   SUM(FEVEREIRO) AS 'TOTAL_FEV',
	   SUM(MARÇO) AS 'TOTAL_MARÇO'
	   FROM VENDEDORES;
-- Soma todas as 3 colunas separadamente.


/* VENDAS POR SEXO */

SELECT SEXO, SUM(MARÇO) AS 'TOTAL_MARÇO' from vendedores
group by sexo;
	/*	+------+--------------+
		| SEXO | TOTAL_MARÇO  |
		+------+--------------+
		| F    |     87855.60 |
		| M    |    597975.57 |
		+------+--------------+ */



/* SUBQUERIES */
	/* Vendedor que vendeu menos em Março e seu nome */

		SELECT NOME,MARÇO
		FROM VENDEDORES
		WHERE MARÇO = MIN(MARÇO);
		--ERRADO

		SELECT NOME,MARÇO
		FROM VENDEDORES
		WHERE MARÇO = (SELECT MIN(MARÇO) FROM VENDEDORES);
			-- CORRETO
			-- Inner query
	/* Vendedor que vendeu mais no mes de Março */

		SELECT NOME,MARÇO
		FROM VENDEDORES
		WHERE MARÇO = (SELECT MAX(MARÇO) FROM VENDEDORES);

	/* Quem em Março vendeu mais que o valor medio de Fevereiro*/
		SELECT NOME, MARÇO FROM VENDEDORES
		WHERE MARÇO > (SELECT AVG(FEVEREIRO) FROM VENDEDORES);

	/* Quem em Março vendeu menos que o valor medio de Fevereiro*/
		SELECT NOME, MARÇO FROM VENDEDORES
		WHERE MARÇO < (SELECT AVG(FEVEREIRO) FROM VENDEDORES);


/* OPERAÇÕES NA LINHA */
	/* Total trimestral de cada vendedor */

		SELECT NOME,
			   JANEIRO,
			   FEVEREIRO,
			   MARÇO,
			   (JANEIRO+FEVEREIRO+MARÇO) AS 'TOTAL',
			   TRUNCATE ((JANEIRO+FEVEREIRO+MARÇO)/3,2) as 'MEDIA'
			   from vendedores;

	/* Aplicando Porcentagem */
		SELECT NOME,
			   JANEIRO,
			   FEVEREIRO,
			   MARÇO,
			   (JANEIRO+FEVEREIRO+MARÇO) AS 'TOTAL',
			   (JANEIRO+FEVEREIRO+MARÇO) * 0.25 AS 'DESCONTO',
			   TRUNCATE ((JANEIRO+FEVEREIRO+MARÇO)/3,2) as 'MEDIA'
			   from vendedores;



