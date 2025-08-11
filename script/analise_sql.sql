USE projetos;

SELECT * FROM human_resources;
SET sql_mode = 'ALLOW_INVALID_DATES';
#ANÁLISE DEMOGRÁFICA 

#Total de funcionários

SELECT COUNT(id) AS "Número de Funcionários"
FROM human_resources
WHERE termdate = '0000-00-00';

#Média da idade dos funcionários

SELECT ROUND(AVG(age)) AS "Média de idade dos funcionários"
FROM human_resources
WHERE termdate = '0000-00-00';


#Qual é a distribuição de funcionários por gênero?

SELECT gender,
	COUNT(gender) AS "Funcionários",
    ROUND(COUNT(*) *100.0 / (SELECT COUNT(*) FROM human_resources), 2) AS "%"
FROM human_resources
WHERE termdate = '0000-00-00'
GROUP BY gender;

#Qual é a distribuição por raça/etnia?

SELECT race,
	COUNT(race) AS "Funcionários",
    ROUND(COUNT(*) *100.0 / (SELECT COUNT(*) FROM human_resources), 2) AS "%"
FROM human_resources
WHERE termdate = '0000-00-00'
GROUP BY race;

#Faixa Etária 

WITH faixa_etaria AS (
  SELECT 
    CASE
      WHEN age >= 18 AND age <= 25 THEN '18-25'
      WHEN age > 25 AND age <= 35 THEN '26-35'
      WHEN age > 35 AND age <= 45 THEN '36-45'
      WHEN age > 45 AND age <= 55 THEN '46-55'
      ELSE '55+'
    END AS faixa,
    id
  FROM human_resources
  WHERE termdate = '0000-00-00'
)
SELECT 
  faixa AS "Faixa Etária",
  COUNT(id) AS "Funcionários",
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM human_resources), 2) AS "%"
FROM faixa_etaria
GROUP BY faixa
ORDER BY faixa;




#ESTRUTURA ORGANIZACIONAL

#Tipo de trabalho (remoto x presencial)

SELECT location,
	COUNT(id) AS "Funcionários",
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM human_resources), 2) AS "%"
FROM human_resources
WHERE termdate = '0000-00-00'
GROUP BY location;

#Funcionários por departamento

SELECT department,
	COUNT(id) AS "Funcionários",
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM human_resources), 2) AS "%"
FROM human_resources
WHERE termdate = '0000-00-00'
GROUP BY department
ORDER BY COUNT(id) DESC;

#Top 10 cargos

SELECT jobtitle,
	COUNT(id) AS "Funcionários",
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM human_resources), 2) AS "%"
FROM human_resources
WHERE termdate = '0000-00-00'
GROUP BY jobtitle
ORDER BY COUNT(id) DESC
LIMIT 10;

#Funcionários por localidade (estado)

SELECT location_state,
	COUNT(id) AS "Funcionários",
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM human_resources), 2) AS "%"
FROM human_resources
WHERE termdate = '0000-00-00'
GROUP BY location_state
ORDER BY COUNT(id) DESC;

#Gênero por departamento

SELECT department,
	gender,
	COUNT(id) AS "Funcionários",
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM human_resources), 2) AS "%"
FROM human_resources
WHERE termdate = '0000-00-00'
GROUP BY department, gender
ORDER BY 
    SUM(COUNT(*)) OVER (PARTITION BY department) DESC, -- total do departamento
    department,
    gender;    

#Taxa de turnover
SELECT 
	ROUND((demitidos/total)*100,1) AS "Taxa de Turnover(%)"
FROM (
	SELECT
		COUNT(id) AS total,
		SUM(CASE WHEN termdate != '0000-00-00' AND termdate <=CURDATE() THEN 1 ELSE 0 END) AS demitidos
        FROM human_resources
        WHERE age >= 18) AS sub;

# Variação no número de funcionários ao longo do tempo

SELECT 
	ano,
    contratados - demitidos AS net_change,
    ROUND((contratados - demitidos)/contratados*100, 1) AS "%"
FROM (
	SELECT 
		EXTRACT(YEAR FROM hire_date) AS ano,
        COUNT(id) AS contratados,
        SUM(CASE WHEN termdate != '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS demitidos
	FROM human_resources
    WHERE age >= 18
    GROUP BY EXTRACT(YEAR FROM hire_date)
    ) AS sub
ORDER BY ano;

#Tempo médio de empresa

SELECT ROUND(AVG(DATEDIFF(termdate, hire_date))/365) AS "Tempo médio de emprego "
FROM human_resources
WHERE termdate != '0000-00-00' AND termdate <= CURDATE();

#Tempo médio de empresa por departamento

SELECT department,
	ROUND(AVG(DATEDIFF(termdate, hire_date))/365) AS "Tempo médio de emprego "
FROM human_resources
WHERE termdate != '0000-00-00' AND termdate <= CURDATE()
GROUP BY department;
    

