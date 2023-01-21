#Agora que temos esta nova tabela com os dados que queremos, podemos consultá-la usando um subselect. 
#Usando Subselect Resolva os seguintes exercícios. Gere uma tabela para responder as perguntas:

#1. Qual o salário médio dos funcionários por status?
#2. Qual o número de funcionários por estado?
#3. Quais são os 7 estados com o revenue total mais alto
#4. O revenue indica o lucro que cada funcionário trouxe para empresa.
#Liste os funcionários em que o revenue é menor que o salário do funcionário e qual é esta diferença.

#os funcionários estão associados apenas uma receita e um sálario? 
#Caso a resposta seja não, para assegurar que esse erro não passe despercebido, 
#devemos utilizar a função SUM, pois assim asseguramos que não cometemos esse erro. 

#=======================================================================================================
#Exercício 1
SELECT
        status,
        ROUND(AVG(salary)) as avg_salary
FROM 
    (SELECT
        X1.employee_id,
        X1.client,
        X1.revenue,
        X1.revenue,
        X2.first_name,
        X4.status,
        X4.salary
    FROM employee_clients as X1
        JOIN employee_names as X2                  ON X1.employee_id = X2.employee_id 
        JOIN employee_state_manager AS X3          ON X1.employee_id = X3.employee_id 
        JOIN employee_status as X4                 ON X1.employee_id = X4.employee_id ) T1
GROUP BY status 
ORDER BY avg_salary DESC
#=======================================================================================================

#Exercício 2
SELECT
				state,
        count (state) as employee_per_state
FROM 
    (SELECT
        X1.employee_id,
        X1.client,
        X1.revenue,
        X1.revenue,
        X2.first_name,
        X3.state,
        X4.status,
        X4.salary
    FROM employee_clients as X1
        JOIN employee_names as X2                               ON X1.employee_id = X2.employee_id 
        JOIN employee_state_manager AS X3                       ON X1.employee_id = X3.employee_id 
        JOIN employee_status as X4                              ON X1.employee_id = X4.employee_id ) T1
GROUP BY state

#=======================================================================================================

#exercício 3
SELECT
        state,
        SUM(revenue)
FROM 
    (SELECT
        X1.employee_id,
        X1.client,
        X1.revenue,
        X2.first_name,
        X3.state,
        X4.status,
        X4.salary
    FROM employee_clients as X1
        JOIN employee_names as X2                 ON X1.employee_id = X2.employee_id 
        JOIN employee_state_manager AS X3         ON X1.employee_id = X3.employee_id 
        JOIN employee_status as X4                ON X1.employee_id = X4.employee_id ) T1
GROUP BY state, revenue
order by revenue DESC
LIMIT 7

#=======================================================================================================

#exercicio 4
SELECT
        employee_id,
        first_name,
        last_name,
        sum(revenue)-sum(salary) as revenue_profit # usar o nome diferença seria melhor 
FROM 
    (SELECT
        X1.employee_id,
        X1.client,
        X1.revenue,
        X2.first_name,
        X2.last_name,
        X3.state,
        X4.status,
        X4.salary
    FROM employee_clients as X1
        JOIN employee_names as X2               ON X1.employee_id = X2.employee_id 
        JOIN employee_state_manager AS X3       ON X1.employee_id = X3.employee_id 
        JOIN employee_status as X4              ON X1.employee_id = X4.employee_id ) T1
WHERE 
				revenue < salary
GROUP BY 
        employee_id,
        first_name
order by revenue_profit DESC
