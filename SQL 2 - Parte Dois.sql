/* PRIMEIRA FORMA NORMAL */
	
/* 3 REGRAS DA FORMA NORMAL */

/*
1 - Todo campo vetorizado se tornará outra tabela
	[AMARELO,AZUL,LARANJA,VERDE] -> Vetor de cores
	[KA,FIESTA,UNO,CIVIC] -> Vetor de carros
	EX: Telefone
		22933110 - 97865434
		
	É um vetor pois são do mesmo campo (ambos telefones).
2 - Todo campo multivalorado se tornará outra tabela, ou quando o campo for divisível.
	EX: Endereço
		Maia Lacerda - Estácio - Rio de Janeiro - RJ
		   ^ Rua        ^Bairro    ^ Cidade 	   ^ Estado
	Não é um vetor pois não são do mesmo campo (um é rua, outro é bairro, por exemplo).
	
3 - Toda tabela necessita de pelo menos um campo que identifique todo o registro como sendo único.
Isso é o que chamamos de chave primária, ou primary key.

Colunas são campos.
Linhas são registros.

A chave primária identifica um registro inteiro (linha) como sendo único.
Chave Natural - pertence a alguém. Ex: CPF.
Chave Artifical - nós criamos. Ex: ID. 
	  Ela é melhor no crescimento do banco, pois se eventualmente os CPFs deixarem de 
	 existir, o banco de dados será perdido, por exemplo. Por isso, é melhor utilizar IDs.
	
  Importante:
	RUA A - BAIRRO B
	RUA A - BAIRRO B 
		São diferentes

*/

/* brModelo */
	
/*
Para este exemplo, o cliente vai fazer um registro que:
O ENDEREÇO é obrigatório e deve ser no máximo 1.
O Telefone é opcional. 

Passo a Passo:
	1 - Criar uma entidade que representará a tabela CLIENTE.
	
	2 - Colocar uma chave primária, que é o atributo identificador. 
		O nome será IDCLIENTE. Seria ''ID[NOMEDATABELA]''. É convenção.
		
	3 - O campo TELEFONE, por estar vetorizado, isto é, contendo ''22923110 - 97865434'' em um dos clientes,
deve ser criado como outra entidade, ou seja, outra tabela, pois, de acordo com a regra 1, todo campo
vetorizado se tornará outra tabela.

	4 - O campo ENDEREÇO, por conter rua,bairro,cidade e estado, é multivalorado, ou seja, já cria outra entidade.,
pois ele se torna outra tabela. 

	5 - Adiciona chave primária nas 2. ''IDTELEFONE'' e ''IDENDEREÇO''
	
	6 - Adicionar o atributo normal (branco) nas tabelas com seus elementos
		Cliente teria nome,sexo,cpf e email.
		Endereço teria rua,bairro,cidade e estado.
		Telefone teria número e tipo (celular ou residencial).
		
	7 - Clicar na entidade e depois CTRL + O para ajeitar.
	
	8 - Ligar objetos e renomea-los como ''POSSUI''.
	
	9 - Quem define a cardinalidade é a sua regra de negócios. Quem vai decidir quanto ficaria o 
	''0,n'' NÃO é você. Você deve deixar exatamente igual o texto vai pedir.
	
	10 - O par da esquerda (0 e 1) está relacionado a obrigatoriedade da entrada de um campo.
			A obrigatoriedade ela trata se vai acontecer ou não vai acontecer.
		 O par da direita (n e 1) está relacionado a cardinalidade. Ela define se é apenas 1 ou mais de 1(n).
			A cardinalidade vai tratar do máximo que vai acontecer.
		0,n
		0,1
		1,n
		1,1
	
	11 - Os passos 12 e 13 são referente aos (0,n) que ficam do lado dos campos "TELEFONE" e "ENDEREÇO".

	12 - Se o endereço é obrigatório, o primeiro par será 1.
		 Se o endereço é no máximo 1, o segundo par será 1.
		 Logo, escolhemos (1,1).
		 
	13 - Se o telefone não é obrigatório, o primeiro par será 0.
		 Se o telefone é ilimitado, o segundo par será n.
		 Logo, escolhemos (0,n).
		 
	14 - Os passos 15 e 16 são referentes aos (0,n) que ficam ao lado do campo "CLIENTE''.

	15 - Como eu preciso de um endereço obrigatoriamente, o primeiro par será 1.
		 Como 1 é o máximo de clientes que posso ter para um endereço, o segundo par também será 1.
		 O endereço é obrigatório e pertence a apenas uma pessoa.
		 Logo, escolhemos (1,1).
	
	16 - Mesma lógica do 15. Se o cliente inseriu telefone, o primeiro par será 1.
		 Como o telefone pertence a apenas 1 pessoa, o segundo par também será 1.
		 Logo, escolhemos (1,1).
	
	17 - Para ler cardinalidade, lê-se de acordo com o segundo número do par.
		CLIENTE(1,1) e ENDEREÇO(1,1) - (1x1) - 1 cliente só tem um endereço.
		CLIENTE(1,1) e TELEFONE(0,n) - (1xN) - 1 cliente pode ter vários telefones.
	*/
	
create database comercio;
use comercio;

CREATE TABLE CLIENTE(
	IDCLIENTE INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30) NOT NULL,
	SEXO ENUM('M','F') NOT NULL,
	EMAIL VARCHAR(50) UNIQUE,
	CPF VARCHAR(15) UNIQUE);
/*
	AUTO_INCREMENT - O próprio banco vai colocar os números na tabela.
	
	NOT NULL - Obriga o usuário a preencher. Significa que não pode ficar em branco.
	  '' * Preencha o nome ''.
	ENUM / Domínio - Quando o usuário tem que escolher opções fixas e pré-definidas
	  na tabela em questão, no sexo é somente 'M' ou 'F'. ENUM só existe no MySQL.
	
	UNIQUE - O email é único e não pode se repetir, mas pode ser deixado em branco e aceita NULL.
	
*/


/*
	Regras de Negócio
	
	Endereço - obrigatório, cadastro de somente um.
	Telefone - não obrigatório, cadastro de mais de um (opcional).

*/

/* FOREIGN KEY */
/*
	Foreign Key ou chave estrangeira é a chave primária de uma tabela que vai até a outra tabela para fazer referencia entre registros.
	
	Tudo depende das regras de negócios para definir quem vai ser a chave primaria ou estrangeira.

	Em relacionamentos 1 x 1 a chave estrangeira fica na tabela mais fraca.
		Para saber quem é a tabela mais fraca, depende da regra de negócio.
	
	Neste caso, o CLIENTE é a coluna mais forte.
		Endereço e Telefone são colunas fracas.
		
	Em relacionamentos 1 x n a chave estrangeira ficará sempre na cardinalidade 'n'.

*/


/* Continuação da Modelagem	*/

/*
	19 - Adicionar um atributo identificador.
	  existem empresas que colocam o nome da chave estrangeira como o mesmo nome da chave primaria.
	  ID_CLIENTE ajuda a diferenciar melhor.
	  Podem ter o mesmo nome em 2 tabelas diferentes.
	  
	









*/

DROP TABLE CLIENTE; -- Apaga a tabela.

CREATE TABLE ENDEREÇO(
	IDENDEREÇO INT PRIMARY KEY AUTO_INCREMENT,
	RUA VARCHAR(30) NOT NULL,
	BAIRRO VARCHAR(30) NOT NULL,
	CIDADE VARCHAR(30) NOT NULL,
	ESTADO CHAR(2) NOT NULL,
	ID_CLIENTE INT UNIQUE,

	FOREIGN KEY(ID_CLIENTE)
	REFERENCES CLIENTE(IDCLIENTE)
);

CREATE TABLE TELEFONE(
	IDTELEFONE INT PRIMARY KEY AUTO_INCREMENT,
	TIPO ENUM('RES','COM','CEL') NOT NULL,
	NUMERO VARCHAR(10) NOT NULL,
	ID_CLIENTE INT,

	FOREIGN KEY(ID_CLIENTE)
	REFERENCES CLIENTE(IDCLIENTE)
);
-- FOREIGN KEY (ID_CLIENTE) e REFERENCES CIENTE (IDCLIENTE) não é um elemento da tabela, e sim um comando-regra.
 /* Se o IDCLIENTE da tabela ''cliente'' é INT, então a chave estrangeira ID_CLIENTE deve ser INT também.,
	Relacionamentos 1x1 a chave estrangeira é UNIQUE.
	Relacionamentos 1xN a chave estrangeira não tem UNIQUE. 
	Em relacionamentos 1x1 a chave estrangeira não se repete. */

INSERT INTO CLIENTE VALUES (NULL,'JOAO','M','JOAO@IG.COM','76584789');
INSERT INTO CLIENTE VALUES (NULL,'CARLOS','M','CARLOS@IG.COM','4561516');
INSERT INTO CLIENTE VALUES (NULL,'ANA','F','ANA@IG.COM','2189489');
INSERT INTO CLIENTE VALUES (NULL,'CLARA','F',NULL,'189189');
INSERT INTO CLIENTE VALUES (NULL,'JORGE','M','JORGE@IG.COM','184894');
INSERT INTO CLIENTE VALUES (NULL,'CELIA','F','CELIA@IG.COM','1231234');

-- Coloca-se NULL na chave primaria que está com auto increment.



/*
+-----------+--------+------+---------------+----------+
| IDCLIENTE | NOME   | SEXO | EMAIL         | CPF      |
+-----------+--------+------+---------------+----------+
|         1 | JOAO   | M    | JOAO@IG.COM   | 76584789 |
|         2 | CARLOS | M    | CARLOS@IG.COM | 4561516  |
|         3 | ANA    | F    | ANA@IG.COM    | 2189489  |
|         4 | CLARA  | F    | NULL          | 189189   |
|         5 | JORGE  | M    | JORGE@IG.COM  | 184894   |
|         6 | CELIA  | F    | CELIA@IG.COM  | 1231234  |
+-----------+--------+------+---------------+----------+
*/

INSERT INTO ENDEREÇO VALUES (NULL,'RUA ANTONIO SA','CENTRO','B. HORIZONTE','MG',4);
INSERT INTO ENDEREÇO VALUES (NULL,'RUA CAPITAO HERMES','CENTRO','RIO DE JANEIRO','RJ',1);
INSERT INTO ENDEREÇO VALUES (NULL,'RUA PRES VARGAS','JARDINS','SÃO PAULO','SP',3);
INSERT INTO ENDEREÇO VALUES (NULL,'RUA ALFANDEGA','ESTACIO','RIO DE JANEIRO','RJ',2);
INSERT INTO ENDEREÇO VALUES (NULL,'RUA DO OUVIDOR','FLAMENGO','RIO DE JANEIRO','RJ',6);
INSERT INTO ENDEREÇO VALUES (NULL,'RUA URUGUAIANA','CENTRO','VITORIA','ES',5);
--
INSERT INTO ENDEREÇO VALUES (NULL,'RUA ALFANDEGA','CENTRO','SÃO PAULO','SP',5); -- Vai dar erro.
-- Duplicate entry '5' for key 'ID_CLIENTE'


/*
+-------------+--------------------+----------+----------------+--------+------------+
| IDENDEREÇO  | RUA                | BAIRRO   | CIDADE         | ESTADO | ID_CLIENTE |
+-------------+--------------------+----------+----------------+--------+------------+
|           1 | RUA ANTONIO SA     | CENTRO   | B. HORIZONTE   | MG     |          4 |
|           2 | RUA CAPITAO HERMES | CENTRO   | RIO DE JANEIRO | RJ     |          1 |
|           3 | RUA PRES VARGAS    | JARDINS  | SÃO PAULO      | SP     |          3 |
|           4 | RUA ALFANDEGA      | ESTACIO  | RIO DE JANEIRO | RJ     |          2 |
|           5 | RUA DO OUVIDOR     | FLAMENGO | RIO DE JANEIRO | RJ     |          6 |
|           6 | RUA URUGUAIANA     | CENTRO   | VITORIA        | ES     |          5 |
+-------------+--------------------+----------+----------------+--------+------------+ 
*/
-- Os números ID_CLIENTE não se repetem pois é um relacionamento 1x1, onde cada pessoa só pode ter 1 endereço.


INSERT INTO TELEFONE VALUES (NULL,'CEL','8198509111',5);
INSERT INTO TELEFONE VALUES (NULL,'RES','4199940114',5);
INSERT INTO TELEFONE VALUES (NULL,'CEL','5598412118',5);
INSERT INTO TELEFONE VALUES (NULL,'COM','4268421874',1);
INSERT INTO TELEFONE VALUES (NULL,'RES','5512132318',2);
INSERT INTO TELEFONE VALUES (NULL,'CEL','4121184477',1);
INSERT INTO TELEFONE VALUES (NULL,'CEL','1567898789',3);
INSERT INTO TELEFONE VALUES (NULL,'COM','5598412118',1);
INSERT INTO TELEFONE VALUES (NULL,'RES','8194848721',5);
INSERT INTO TELEFONE VALUES (NULL,'CEL','5581238745',2);

/*
+------------+------+------------+------------+
| IDTELEFONE | TIPO | NUMERO     | ID_CLIENTE |
+------------+------+------------+------------+
|          1 | CEL  | 8198509111 |          5 |
|          2 | RES  | 4199940114 |          5 |
|          3 | CEL  | 5598412118 |          5 |
|          4 | COM  | 4268421874 |          1 |
|          5 | RES  | 5512132318 |          2 |
|          6 | CEL  | 4121184477 |          1 |
|          7 | CEL  | 1567898789 |          3 |
|          8 | COM  | 5598412118 |          1 |
|          9 | RES  | 8194848721 |          5 |
|         10 | CEL  | 5581238745 |          2 |
+------------+------+------------+------------+*/

-- Os números em ID_CLIENTE se repetem pois é um relacionamento 1xN, onde uma pessoa pode ter vários números.


/* PROJEÇÃO,SELEÇÃO E JUNÇÃO */
   /* Entendendo os 3 conceitos, construir uma query fica mais fácil. */
/* PROJEÇÃO E SELEÇÃO
 
 Projeção - tudo que você quer ver na tela.
 	Ex: SELECT NOME,SEXO,TELEFONE,TIPO,BAIRRO -> Etapa da projeção
 
 Seleção - filtrar um subconjunto de um conjunto total.  Por exemplo, especificar apenas as pessoas
 do sexo feminino da tabela 'CLIENTE'. É um subconjunto do conjunto total de registros de uma tabela. 
 A clausula de seleção é o WHERE. Não é o ideal juntar duas tabelas com o WHERE.
 
 	Ex: SELECT NOME,SEXO,EMAIL FROM CLIENTE WHERE SEXO = 'F'; -> Etapa da Seleção. */

SELECT NOME,SEXO,EMAIL /* PROJEÇÃO */
FROM CLIENTE /* ORIGEM -> No Oracle, é sempre necessário ter ORIGEM */
WHERE TIPO = 'CEL'; /* SELEÇÃO */

/* JUNÇÃO */
/*

Juntar uma tabela com a outra. 
A cláusula de junção é o JOIN.

*/

-- FORMA ERRADA - COM WHERE
SELECT NOME,SEXO,BAIRRO,CIDADE FROM CLIENTE,ENDEREÇO WHERE IDCLIENTE = ID_CLIENTE;
--Funciona, mas não é pra usar.     ^Nome,sexo   ^ Bairro,cidade.


-- FORMA CORRETA - JOIN
SELECT NOME,SEXO,BAIRRO,CIDADE -- Projeção.
FROM CLIENTE -- Nome e sexo
INNER JOIN ENDEREÇO -- Ele compara e checa quem é igual 
ON IDCLIENTE = ID_CLIENTE; -- Seleção.


SELECT NOME,SEXO,BAIRRO,CIDADE
FROM CLIENTE 
INNER JOIN ENDEREÇO
ON IDCLIENTE = ID_CLIENTE;


-- Agora, se precisasse filtrar, por exemplo, as pessoas do sexo feminino, seria:

SELECT NOME,SEXO,BAIRRO,CIDADE -- Projeção.
FROM CLIENTE  -- Origem.
	INNER JOIN ENDEREÇO -- Junção.
	ON IDCLIENTE = ID_CLIENTE 
WHERE SEXO = 'F'; -- Seleção.
-- Recomendado escrever as querys por partes, dando ENTER e identando.
-- INNER e ON estao identados pois estão dentro do FROM.


SELECT NOME,SEXO,BAIRRO,CIDADE
FROM CLIENTE 
INNER JOIN ENDEREÇO
ON IDCLIENTE = ID_CLIENTE
WHERE SEXO = 'F';

-- Outro exemplo - nome,sexo,email,tipo e numero.

SELECT NOME,SEXO,EMAIL,TIPO,NUMERO
FROM CLIENTE
INNER JOIN TELEFONE
ON IDCLIENTE = ID_CLIENTE; 
-- IDCLIENTE = Chave Primária.
-- ID_CLIENTE = Chave Estrangeira.

-- Outro exemplo - nome,sexo,bairro,cidade,tipo,numero.

SELECT NOME,SEXO,BAIRRO,CIDADE,TIPO,NUMERO
FROM CLIENTE
INNER JOIN ENDEREÇO
ON IDCLIENTE = ID_CLIENTE
INNER JOIN TELEFONE
ON IDCLIENTE = ID_CLIENTE; -- Meu
--Não funciona, pois diz que ID_CLIENTE é ambíguo, pois são 2 colunas iguais de tabelas diferentes.

SELECT CLIENTE.NOME,CLIENTE.SEXO,ENDEREÇO.BAIRRO,ENDEREÇO.CIDADE,TELEFONE.TIPO,TELEFONE.NUMERO
FROM CLIENTE 
INNER JOIN ENDEREÇO 
ON CLIENTE.IDCLIENTE = ENDEREÇO.ID_CLIENTE
INNER JOIN TELEFONE
ON CLIENTE.IDCLIENTE = TELEFONE.ID_CLIENTE; 
-- Correto, pois é necessário colocar o nome da tabela antes do registro, para ele saber de onde buscar e não conflitar.

-- No entanto:
SELECT NOME,SEXO,BAIRRO,CIDADE,TIPO,NUMERO
FROM CLIENTE 
INNER JOIN ENDEREÇO 
ON IDCLIENTE = ENDEREÇO.ID_CLIENTE
INNER JOIN TELEFONE
ON IDCLIENTE = TELEFONE.ID_CLIENTE; 
-- Também funciona.



-- Ponteiramento - também é possivel dar ALIAS ou apelidos para as tabelas.
SELECT C.NOME,C.SEXO,E.BAIRRO,E.CIDADE,T.TIPO,T.NUMERO
FROM CLIENTE C 
INNER JOIN ENDEREÇO E
ON IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON IDCLIENTE = T.ID_CLIENTE; 




/*
	DML - Data Manipulation Language.
	DDL - Data Definition Language. 
	DCL - Data Control Language.
	TCL	- Transaction Control Language.
*/

/* DML */

	/* INSERT */
	INSERT INTO CLIENTE VALUES (NULL,'PAULA','M',NULL,7745781); -- Sexo propositalmente errado. 
	INSERT INTO ENDEREÇO VALUES (NULL,'RUA JOAQUIM SILVA','ALVORADA','NITERÓI','RJ',7); 

	/* FILTROS */
	SELECT * FROM CLIENTE
	WHERE SEXO = 'M';

	/* UPDATE */
	SELECT * FROM CLIENTE 
	WHERE IDCLIENTE = '7';

	UPDATE CLIENTE
	SET SEXO = 'F'
	WHERE IDCLIENTE = '7';

	/* DELETE */
		INSERT INTO CLIENTE VALUES (NULL,'XXX','M',NULL,'XXX');
		SELECT * FROM CLIENTE WHERE IDCLIENTE = 8;
		DELETE FROM CLIENTE WHERE IDCLIENTE = 8;




/* DDL */

	/* CREATE TABLE */
	CREATE TABLE PRODUTO(
		IDPRODUTO INT PRIMARY KEY AUTO_INCREMENT,
		NOME_PRODUTO VARCHAR(30) NOT NULL,
		PRECO INT,
		FRETE FLOAT(10,2) NOT NULL
		);
	/* ALTERANDO TABELAS - ALTER TABLE */
		/* CHANGE */
			ALTER TABLE PRODUTO
			CHANGE PRECO VALOR_UNITARIO INT NOT NULL;
			--     ^Nome Antigo ^Novo nome ^ ^ ^ Regras novas

			ALTER TABLE PRODUTO
			CHANGE VALOR_UNITARIO VALOR_UNITARIO INT;

			-- Mais seguro utilizar CHANGE para trocar nome.

		/* MODIFY - ALTERANDO O TIPO */
			ALTER TABLE PRODUTO
			MODIFY VALOR_UNITARIO VARCHAR(50) NOT NULL;

			-- Mais seguro utilizar MODIFY para trocar tipo.

		/* ADICIONANDO COLUNAS */
			/* ADD */
				ALTER TABLE PRODUTO
				ADD PESO FLOAT(10,2) NOT NULL; 

				-- É mais profissional apagar e começar tudo do zero, caso tenha esquecido alguma coluna.
		/* APAGANDO COLUNAS */
			/* DROP */
				ALTER TABLE PRODUTO 
				DROP COLUMN PESO;

		/* ADICIONANDO COLUNA EM ORDEM ESPECIFICA */
			/* FIRST */
				ALTER TABLE PRODUTO 
				ADD PESO FLOAT (10,2) NOT NULL 
				FIRST;
				--Vai ser adicionado como o primeiro item da tabela;
			/* AFTER */ 
				ALTER TABLE PRODUTO
				ADD PESO FLOAT (10,2) NOT NULL
				AFTER NOME_PRODUTO;
				--Vai ser adicionado abaixo de NOME_PRODUTO; 