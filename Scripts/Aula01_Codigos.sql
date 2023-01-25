/*OBS - CLIENT USADO DBEAVER, CLAUSULA DE FECHAMENTO GO EXCLUSIVA NO SERVER MANAGEMENT STUDIO*/


/***************************************************************************/
/**TRABALHANDO COM TABELAS - CRIACAO, INSERCAO E CONSULTA**/

/*CRIACAO DE TABELA*/
CREATE TABLE ALUNO(
	IDALUNO INT PRIMARY KEY IDENTITY,
	NOME VARCHAR(30) NOT NULL,
	SEXO CHAR(1) NOT NULL,
	NASCIMENTO DATE NOT NULL,
	EMAIL VARCHAR(30) UNIQUE 
);


/*CRIANDO CONSTRAINTS - ENUM = "CHECK"*/
ALTER TABLE ALUNO 
ADD CONSTRAINT CK_SEXO CHECK(SEXO IN('M','F'));


/*RELACIONAMENTO 1X1 (UNIQUE-Unico)*/
CREATE TABLE ENDERECO(
	IDENDERECO INT PRIMARY KEY IDENTITY(100,10),
	BAIRRO VARCHAR(30),
	UF CHAR(2) NOT NULL
	CHECK (UF IN('RJ', 'SP', 'MG')),
	ID_ALUNO INT UNIQUE
);

/*CRIANDO CHAVE ESTRANGEIRA - FK*/
ALTER TABLE ENDERECO ADD CONSTRAINT FK_ENDERECO_ALUNO
FOREIGN KEY(ID_ALUNO) REFERENCES ALUNO(IDALUNO);

/*COMANDOS DE DESCRICAO*/
/*PROCEDURES - JA CRIADAS E ARMAZENADAS NO SISTEMA - SP (STORAGE PROCEDURE) */
SP_COLUMNS ALUNO;
SP_HELP ALUNO;

/*INSERINDO DADOS - TABELA ALUNO*/
INSERT INTO ALUNO VALUES('ANDRE', 'M', '1981/12/09','ANDRE@GMAIL.COM')
INSERT INTO ALUNO VALUES('ANA', 'F', '1978/03/09','ANA@GMAIL.COM')
INSERT INTO ALUNO VALUES('RUI', 'M', '1965/07/09','RUI@GMAIL.COM')
INSERT INTO ALUNO VALUES('JOAO', 'M', '2002/11/09','JOAO@GMAIL.COM');

/*CONSULTANDO DADOS*/
SELECT * FROM ALUNO;

/*INSERINDO DADOS - TABELA ENDERECO*/
INSERT INTO ENDERECO VALUES('FLAMENGO', 'RJ', 1)
INSERT INTO ENDERECO VALUES('MORUMBI', 'SP', 2)
INSERT INTO ENDERECO VALUES('CENTRO', 'MG', 3)
INSERT INTO ENDERECO VALUES('CENTRO', 'SP', 4);


/*CONSULTANDO DADOS*/
SELECT * FROM ENDERECO;

/*CRIACAO DE TABELA - RELACIONAMENTO 1XN SEM UNIQUE NO ID_ALUNO*/
CREATE TABLE TELEFONE(
	IDTELEFONE INT PRIMARY KEY IDENTITY,
	TIPO CHAR(3) NOT NULL,
	NUMERO VARCHAR(10) NOT NULL,
	ID_ALUNO INT,
	CHECK(TIPO IN('RES', 'COM', 'CEL'))
);

/*INSERINDO DADOS - TABELA TELEFONE*/
INSERT INTO TELEFONE VALUES('CEL', '7899889', 1)
INSERT INTO TELEFONE VALUES('RES', '4325444', 1)
INSERT INTO TELEFONE VALUES('COM', '4354354', 2)
INSERT INTO TELEFONE VALUES('CEL', '2344556', 2);


/*CONSULTANDO DADOS*/
SELECT * FROM TELEFONE;	

/*DATA ATUAL DO SISTEMA*/
SELECT GETDATE(); 

/***************************************************************************/
/**TRABALHANDO COM TABELAS - INNER JOINS**/

/*CLAUSULA AMBIGUA - COLUNAS IGUAIS EM MAIS DE UMA TABELA APOS FAZER JOIN*/
/*OBS - TRAZEM APENAS QUEM TEM NUMERO QUEM NAO TEM NAO APARECE*/
SELECT A.NOME, T.TIPO, T.NUMERO, E.BAIRRO, E.UF
FROM ALUNO A INNER JOIN TELEFONE T
ON A.IDALUNO = T.ID_ALUNO
INNER JOIN ENDERECO E
ON A.IDALUNO = E.ID_ALUNO;

/*CLAUSULA AMBIGUA - COLUNAS IGUAIS EM MAIS DE UMA TABELA APOS FAZER JOIN*/
/*OBS - TRAZEM APENAS NAO TEM NUMERO*/
SELECT A.NOME, T.TIPO, T.NUMERO, E.BAIRRO, E.UF
FROM ALUNO A LEFT JOIN TELEFONE T
ON A.IDALUNO = T.ID_ALUNO
INNER JOIN ENDERECO E
ON A.IDALUNO = E.ID_ALUNO;

/*EDICAO COM IFNULL*/
SELECT A.NOME, 
	   ISNULL (T.TIPO, 'SEM') AS "TIPO", 
	   ISNULL (T.NUMERO,'NUMERO') AS "TELEFONE", 
       E.BAIRRO, 
       E.UF
FROM ALUNO A LEFT JOIN TELEFONE T
ON A.IDALUNO = T.ID_ALUNO
INNER JOIN ENDERECO E
ON A.IDALUNO = E.ID_ALUNO;

/***************************************************************************/
/**TRABALHANDO COM DATAS**/

/*FUNCAO GETDATE TRAS DIA E HORA*/
SELECT NOME, GETDATE() AS DIA_HORA FROM ALUNO;  


/*DATEDIFF - CALCULA A DIFERENCA ENTRE 2 DATAS*/
/*PRIMEIRO PASSO*/
SELECT NOME, DATEDIFF(DAY, NASCIMENTO, GETDATE())
FROM ALUNO;



/*DATEDIFF - CALCULA A DIFERENCA ENTRE 2 DATAS*/
/*SEGUNDO PASSO*/
SELECT NOME, DATEDIFF(DAY, NASCIMENTO, GETDATE()) AS "IDADE"
FROM ALUNO;

/*MESMO FUNCIONAMETO - NAO RECOMENDADO O USO*/
SELECT NOME, DATEDIFF(DAY, NASCIMENTO, GETDATE()) IDADE
FROM ALUNO;


/*DATEDIFF - CALCULA A DIFERENCA ENTRE 2 DATAS*/
/*TERCEIRO PASSO - RETORNO INTEIRO + OPERACAO MATEMATICA = ANOS DE IDADE*/
SELECT NOME, (DATEDIFF(DAY, NASCIMENTO, GETDATE())/365) AS "IDADE"
FROM ALUNO;

/*RETORNO EM ANOS POR MEIO DE MESES*/
SELECT NOME, (DATEDIFF(MONTH, NASCIMENTO, GETDATE())/12) AS "IDADE"
FROM ALUNO;


/*RETORNO EM ANOS POR MEIO DE ANOS*/
SELECT NOME, DATEDIFF(YEAR , NASCIMENTO, GETDATE()) AS "IDADE"
FROM ALUNO;

/*DATENAME - TRAZ O NOME DA PARTE DA DATA EM QUESTAO - STRING*/
/*MES*/
SELECT NOME, DATENAME(MONTH, NASCIMENTO)
FROM ALUNO;

/*ANO*/
SELECT NOME, DATENAME(YEAR, NASCIMENTO)
FROM ALUNO;

/*DIA DA SEMANA*/
SELECT NOME, DATENAME(WEEKDAY , NASCIMENTO)
FROM ALUNO;

/*DATEPART - MESMO QUE DATENAME POREM RETORNO É UM INTEIRO PARA CALCULOS*/
SELECT NOME, DATEPART(MONTH, NASCIMENTO), DATENAME(MONTH, NASCIMENTO)
FROM ALUNO;

/*DATEADD - RETORNA UMA DATA SOMANDO A OUTRA DATA*/
SELECT DATEADD(DAY, 365, GETDATE())  

SELECT DATEADD(YEAR, 10, GETDATE()) 

/***************************************************************************/
/**CONVERSOES DE TIPOS DE DADOS**/

/*CONCATENACAO*/
SELECT '1' + '1'; 

/*FUNCOES DE CONVERSAO DE DADOS - CONVERSAO EXPLICITA*/
SELECT CAST('1' AS INT) + CAST('1'AS INT); 

/*CONVERSAO E CONCATENACAO*/
/*https://learn.microsoft.com/pt-br/sql/t-sql/data-types/data-type-conversion-database-engine?view=sql-server-ver16*/
SELECT NOME, 
NASCIMENTO
FROM ALUNO;

SELECT NOME,
DAY(NASCIMENTO)
FROM ALUNO;

SELECT NOME,
MONTH(NASCIMENTO)
FROM ALUNO;

SELECT NOME,
CAST (DAY(NASCIMENTO)AS VARCHAR)+'/'+
CAST (MONTH(NASCIMENTO)AS VARCHAR)+'/'+
CAST (YEAR(NASCIMENTO)AS VARCHAR) AS "NASCIMENTO"
FROM ALUNO;


/***************************************************************************/
/**A FUNCAO CHARINDEX**/

/*RETORNA UM INTEIRO BASEADO EM UMA PROCURAR FEITA EM UMA COLUNA*/
/*TERCEIRO PARAMETRO NAO OBRIGATORIO*/
/*CONTAGEM DEFAULT SEM O TERCEIRO PARAMETRO - INICIA EM 01*/
SELECT NOME, CHARINDEX('A', NOME) AS INDICE
FROM ALUNO;


/*PASSANDO O TERCEIRO PARAMETRO*/
SELECT NOME, CHARINDEX('A', NOME, 2) AS INDICE
FROM ALUNO;


/***************************************************************************/
/**A FUNCAO CHARINDEX**/

/*IMPORTACAO FEITA ATRAVES DA FUNCAO*/
/*BULK INSERT - IMPORTACAO DE ARQUIVOS*/
CREATE TABLE LANCAMENTO_CONTABIL(
	CONTA INT,
	VALOR INT,
	DEB_CRED CHAR(1)

);


/*IMPORTANDO O ARQUIVO DENTRO DA TABELA - OBS ARQUIVO FOI INCLUIDO NO CONTAINER DOCKER*/
BULK INSERT LANCAMENTO_CONTABIL
FROM '/home/CONTAS.txt'
WITH(
	FIRSTROW = 2,	
	DATAFILETYPE = 'char',
	FIELDTERMINATOR = '\t',
	ROWTERMINATOR = '\r\n'
);

/*CONSULTANDO DADOS IMPORTADOS*/
SELECT * FROM LANCAMENTO_CONTABIL; 


/*DESAFIO DO SALDO*/
/*QUERY QUE TRAGA O NUMERO DA CONTA SALDO - DEVEDOR OU CREDOR*/
SELECT CONTA, VALOR,
CHARINDEX('D', DEB_CRED) AS "DEBITO",
CHARINDEX('C', DEB_CRED) AS "CREDITO",
CHARINDEX('C', DEB_CRED) * 2 - 1 AS MULTIPLICADOR
FROM LANCAMENTO_CONTABIL;

SELECT CONTA,
SUM(VALOR * (CHARINDEX('C', DEB_CRED) * 2 - 1)) AS SALDO
FROM LANCAMENTO_CONTABIL
GROUP BY CONTA;






















 

