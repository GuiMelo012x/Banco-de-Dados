/* Modelagem Básica
ENTIDADE = TABELA 
CAMPOS = ATRIBUTOS */


CLIENTE

NOME - CARACTER(30)
CPF - NUMÉRICO(11)
EMAIL - CARACTER(30)
TELEFONE - CARACTER(30)
ENDEREÇO - CARACTER (100)
SEXO - CARACTER (1)

/* Processos de Modelagem */

/* FASE 01 e FASE 02 - Geralmente feito pelo Administrador de Dados (AD) */
Modelagem Conceitual - Rascunho
/* exatamente isto que foi feito acima */

Modelagem Lógica - Qualquer programa de modelagem
/* pegar o que foi feito acima e mandar para um programa de modelagem, como o brModelo*/



/* FASE 03 - Fica a critério do DBA, mas pode ser feita pelo AD*/
Modelagem Física - Scripts de Banco

/* INICIANDO A MODELAGEM FÍSICA */



/*Criar o banco de dados*/
CREATE DATABASE PROJETO;



/* Conectar ao banco de dados */
USE PROJETO;



/* Criando a Tabela de Clientes */

CREATE TABLE CLIENTE(
	NOME VARCHAR(30),
	SEXO CHAR(1),
	EMAIL VARCHAR(30),
	CPF INT(11),
	TELEFONE VARCHAR(30),
	ENDEREÇO VARCHAR(100)

);

 /* Verificar as Tabelas do Banco*/
 SHOW TABLES;
 
 /* Descobrindo como é a estrutura de uma tabela */
DESC CLIENTE;







/* Sintaxe Básica de Inserção - INSERT INTO [Tabela] */

/* Forma 1 - Omitindo as Colunas 
	Forma não muito segura.*/
INSERT INTO CLIENTE VALUES('JOAO','M','JOAO@GMAIL.COM',988638273,'22923110',
'MAIA LACERDA - ESTACIO - RIO DE JANEIRO -RJ');

INSERT INTO CLIENTE VALUES ('CELIA','F','CELIA@GMAIL.COM',541521456,'25078869',
'RECIFE');

INSERT INTO CLIENTE VALUES ('JORGE','M',NULL,885755896,'58748895','OLINDA');

/*Forma 2 - Colocando as Colunas
	Forma mais segura e clara. */

INSERT INTO CLIENTE (NOME,SEXO,ENDEREÇO,TELEFONE,CPF) VALUES ('LILIAN','F','CASA FORTE',
'947785696',887774856);

INSERT INTO CLIENTE (NOME,SEXO,ENDEREÇO,TELEFONE,CPF) VALUES ('CLARA','F','CASA FORTE',
'999409113',99999999999);-- Não vai funcionar pq 9999999999 é maior que 2147483647 que é o range maximo do INT no MySQL



/*Forma 3 - Insert Compacto - Somente MYSQL */

INSERT INTO CLIENTE VALUES ('ANA','F','ANA@GLOBO.COM',85548962,'548556985','CASA AMARELA'),
							('CARLA','F','CARLA@TERATI.COM.BR',7745828,'66587458','CANDEIAS');
							
							
/* COMANDO SELECT */

SELECT NOW();
	SELECT 'FELIPE MAFRA';
	SELECT 'BANCO DE DADOS';

/* ALIAS DE COLUNAS */

SELECT NOME, SEXO, EMAIL FROM CLIENTE;
SELECT NOME AS CLIENTE, SEXO, EMAIL, ENDERECO FROM CLIENTE;

/* Apenas para fins academicos */
SELECT * FROM CLIENTE;
	Utiliza muita memoria, scannea toda a tabela com todos os seus elementos.
	
/* Filtrando dados com WHERE e LIKE */
	SELECT NOME,TELEFONE FROM CLIENTE;
	/* FILTRANDO */
		SELECT NOME, SEXO FROM CLIENTE
		WHERE SEXO = 'M';
		
		SELECT NOME, ENDEREÇO FROM CLIENTE
		WHERE SEXO = 'F';
		
		SELECT NOME, SEXO FROM CLIENTE WHERE ENDEREÇO = 'RECIFE';
	/* LIKE */
		Utilizamos o % que pega o que tiver antes ou depois e detecta o semelhante .
		SELECT NOME, SEXO FROM CLIENTE WHERE ENDEREÇO LIKE '%FE';
		SELECT NOME, SEXO FROM CLIENTE WHERE ENDEREÇO LIKE 'RE%';
		SELECT NOME, SEXO FROM CLIENTE WHERE ENDEREÇO LIKE '%IF%';
		
/* COUNT (*), GROUP BY, Performance com Operadores Lógicos*/

	/* Contando os Registros de uma Tabela */
		SELECT COUNT(*) AS 'Quantidade de Registros da Tabela Cliente' FROM CLIENTE;
	
	/* OPERADOR GROUP BY */
		SELECT SEXO,COUNT(*) FROM CLIENTE GROUP BY SEXO;
			mostra quantos F e M tem na tabela.
		
		SELECT NOME,SEXO,ENDEREÇO FROM CLIENTE WHERE SEXO = 'F' OR ENDEREÇO = 'RECIFE'; - Mostrará todas as mulheres.
			/* Deve-se colocar primeiro o que tiver mais chance de dar verdadeiro, por exemplo, acima, existem 70% de mulheres e apenas 1 mora em Recife, logo,
			o comando ''WHERE SEXO = 'F' deve ser utilizado antes do ''OR ENDERECO = 'RECIFE', pois só 1 mora em Recife, e 70% sao mulheres.*/ 
		SELECT NOME,SEXO,ENDEREÇO FROM CLIENTE WHERE SEXO = 'F' AND ENDEREÇO = 'RECIFE'; - Mostrará apenas as mulheres que moram em Recife.
		

/* FILTRANDO VALORES NULL e NÃO-NULL */
	SELECT NOME,SEXO,EMAIL FROM CLIENTE WHERE EMAIL IS NULL;
	SELECT NOME,SEXO,EMAIL FROM CLIENTE WHERE EMAIL IS NOT NULL;
	
/* ATUALIZANDO VALORES */
/* 	Sempre bom utilizar o comando ''Select'' antes para ter certeza que está modificando corretamente */
	SELECT NOME,EMAIL FROM CLIENTE WHERE EMAIL IS NULL;
		UPDATE CLIENTE SET EMAIL = 'LILIAN@HOTMAIL.COM'; 
			/* Este comando fará com que todos os e-mails da tabela sejam ''LILIAN@HOTMAIL'' */
	/* Consertando a tabela com os e-mails errados - O WHERE é MUITO IMPORTANTE PARA SELECIONAR E ESPECIFICAR */
		/* Consertando o do João */
			SELECT NOME,EMAIL FROM CLIENTE WHERE NOME = 'JOÃO'; - Para se certificar.
				UPDATE CLIENTE SET EMAIL = 'JOAO@GMAIL.COM' WHERE NOME = 'JOAO'; - Para alterar.
		/*	Consertando o resto */
			SELECT NOME, EMAIL FROM CLIENTE;
				UPDATE CLIENTE SET EMAIL = 'CELIA@GMAIL.COM' WHERE NOME = 'CELIA';
				UPDATE CLIENTE SET EMAIL = 'ANA@GLOBO.COM' WHERE NOME = 'ANA';
				UPDATE CLIENTE SET EMAIL = 'CARLA@TERATI.COM.BR' WHERE NOME = 'CARLA';
				UPDATE CLIENTE SET EMAIL = 'JORGE@IG.COM.BR' WHERE NOME = 'JORGE';
				UPDATE CLIENTE SET EMAIL = 'LILIAN@HOTMAIL.COM' WHERE NOME = 'LILIAN';
	

	
/* DELETANDO REGISTROS COM DELETE - PERIGOSO - FAÇA SEMPRE UM SELECT PARA CONFERIR OS DADOS */
	/* DELETAR A TABELA INTEIRA*/
		DELETE FROM CLIENTE 	
	/* DELETAR CORRETAMENTE - Vamos deletar a ANA */
		SELECT * FROM CLIENTE WHERE NOME = 'ANA';
		DELETE FROM CLIENTE WHERE NOME = 'ANA';
		   /* Caso eu queira deletar uma pessoa chamada ANA e possuem várias com o mesmo nome no banco,
			deve-se utilizar especificamente as condições que levem à exclusão da ANA correta. Por exemplo,
			no banco de dados dos FUNCIONARIOS, devo fazer um comando especifico, como: */
				DELETE FROM FUNCIONARIOS WHERE NOME = 'ANA' AND DEPARTAMENTO = 'JARDIM' AND EMAIL = 'ANA3412@GMAIL.COM';
				   /* Assim, garante-se que só existe uma ANA que trabalha no JARDIM e possui o EMAIL de ANA3412@GMAIL.COM.
					No entanto, para o banco de dados em questão, bastaria colocar o ID do funcionário, que é único, que
					já iria excluir exatamente a ANA que você quer excluir.*/
	
		
	/* OPERADORES LÓGICOS */
	  /* O AND irá trazer todo mundo que satisfaz as duas condições.
	   O OR irá trazer todo mundo que satisfaz ao menos uma das condições.
			Por isso, é importante fazer o SELECT antes do DELETE, para saber exatamente quem irá ser deletado. */
	
	
	/* DICAS */
		/* Utilizar o comando COUNT para saber quantos tem no banco no total */
			SELECT COUNT(*) FROM CLIENTE; -- TOTAL = 6
			SELECT COUNT(*) FROM CLIENTE WHERE NOME = 'ANA'; -- ANA = 1
			DELETE FROM CLIENTE WHERE NOME = 'ANA'; -- DELETANDO A ANA;
			
		/* Para certificar-se que a exclusão deu certo, o COUNT TOTAL deve ser 5, e o da ANA deve ser 0.*/
			SELECT COUNT(*) FROM CLIENTE; -- TOTAL = 5
			SELECT COUNT(*) FROM CLIENTE WHERE NOME = 'ANA'; -- ANA = 0
			-- Logo, percebe-se que o DELETE deu certo.
			
			
	/* DELETANDO 2 PESSOAS COM O MESMO NOME */
		-- No banco atual, temos 2 CARLAS. Uma mora em CANDEIAS e a outra em RIO DOCE, devo apagar a Carla que mora em RIO DOCE.
			SELECT COUNT(*) FROM CLIENTE WHERE NOME ='CARLA'; -- 2
		--Se fizesse o comando
			DELETE FROM CLIENTE WHERE NOME = 'CARLA'; -- Apagaria as duas, até a que eu não quero apagar.
		/* FORMA CORRETA */
			SELECT COUNT(*) FROM CLIENTE WHERE NOME = 'CARLA' AND ENDEREÇO = 'RIO DOCE'; -- 1, agora tenho certeza que, ao realizar o delete, só apagará uma, que é a que eu quero.
			DELETE FROM CLIENTE WHERE NOME = 'CARLA' AND ENDEREÇO = 'RIO DOCE'; -- Deletada.
			SELECT COUNT(*) FROM CLIENTE WHERE NOME = 'CARLA' -- Agora só tem uma.
			SELECT * FROM CLIENTE WHERE NOME = 'CARLA'; -- Certificando-se que a única que resta é a correta.
