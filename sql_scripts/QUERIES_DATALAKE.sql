-- Los empleados que más recibieron llamadas -- 
SELECT employees.firstName, COUNT(*) AS TOTAL FROM customer_calls
INNER JOIN employees
    ON customer_calls.employeeNumber = employees.employeeNumber
GROUP BY employees.firstName
ORDER BY TOTAL DESC

-- Las líneas de productos sobre las que más llamadas recibieron --
SELECT products.productLine, COUNT(*) AS TOTAL FROM customer_calls
INNER JOIN products
    ON customer_calls.productCode = products.productCode
GROUP BY products.productLine
ORDER BY TOTAL DESC