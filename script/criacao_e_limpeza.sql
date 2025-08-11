CREATE DATABASE projetos;
USE projetos;

# Visão geral dos dados

SELECT * FROM human_resources;

# Normalizando o nome da coluna 

ALTER TABLE human_resources
CHANGE COLUMN ï»¿id id VARCHAR(10) NULL;

SET sql_safe_updates = 0;

# Tratamento das datas

UPDATE human_resources
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN
		DATE_FORMAT(STR_TO_DATE(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
	WHEN birthdate LIKE '%-%' THEN
		DATE_FORMAT(STR_TO_DATE(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
	ELSE NULL
END;

UPDATE human_resources
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN
		DATE_FORMAT(STR_TO_DATE(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
	WHEN hire_date LIKE '%-%' THEN
		DATE_FORMAT(STR_TO_DATE(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
	ELSE NULL
END;

UPDATE human_resources
SET termdate = IF(termdate IS NOT NULL AND termdate != '', date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')), '0000-00-00')
WHERE true;

SET sql_mode = 'ALLOW_INVALID_DATES';

# Alterando o tipo de dados das colunas

ALTER TABLE human_resources
MODIFY COLUMN birthdate DATE,
MODIFY COLUMN hire_date DATE,
MODIFY COLUMN termdate DATE;

DESCRIBE human_resources;

# Calculando uma nova coluna para idades

ALTER TABLE human_resources
ADD COLUMN age INT;

UPDATE human_resources
SET age = TIMESTAMPDIFF(YEAR, birthdate, CURDATE());

# Tratamento de idades negativas

SELECT COUNT(age)
FROM human_resources
WHERE age < 18;

UPDATE human_resources
SET birthdate = DATE_SUB(birthdate, INTERVAL 100 YEAR)
WHERE birthdate >= '2060-01-01' AND birthdate < '2070-01-01';

# Nomes incorretos

SELECT first_name FROM human_resources
WHERE first_name LIKE "%;%";

UPDATE human_resources
SET first_name = "Laurette"
WHERE first_name LIKE "%;%";

# Algumas datas de demissão estão no futuro, não usaremos esses registros (1195 registros).

SELECT COUNT(age) 
FROM human_resources
WHERE termdate > CURDATE();

DELETE FROM human_resources
WHERE age < 18 OR termdate > CURDATE();