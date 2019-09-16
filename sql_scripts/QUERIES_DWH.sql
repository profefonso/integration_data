-- ¿Cuál es el porcentaje de participación en las ventas de cada línea de producto para el año 2004? -- 
SELECT
       DIM_Products.productLine AS LINEA,
       COUNT(*) AS TOTAL_VENTAS,
       ((COUNT(*) / (SELECT COUNT(*) FROM FACT_Sales INNER JOIN DIM_time ON FACT_Sales.shippedDateKey = DIM_time.dateKey WHERE DIM_time.year = '2004')) * 100 ) AS PORCENTAJE FROM FACT_Sales
INNER JOIN DIM_Products ON FACT_Sales.productKey = DIM_Products.productKey
INNER JOIN DIM_time ON FACT_Sales.shippedDateKey = DIM_time.dateKey
WHERE DIM_time.year = '2004'
GROUP BY DIM_Products.productLine;

-- ¿Cuánto es la utilidad en cada uno de los trimestres? --
SELECT DIM_time.year, DIM_time.quarter, SUM(FACT_Sales.priceEach) AS TOTAL FROM FACT_Sales
INNER JOIN DIM_time ON FACT_Sales.shippedDateKey = DIM_time.dateKey
GROUP BY DIM_time.year, DIM_time.quarter;

-- ¿Por cada mes, cuántas unidades se vendieron por cada línea de productos? --
SELECT DIM_Products.productLine, DIM_time.year, DIM_time.month, COUNT(*) AS TOTAL_VENTAS FROM FACT_Sales
INNER JOIN DIM_Products ON FACT_Sales.productKey=DIM_Products.productKey
INNER JOIN DIM_time ON FACT_Sales.shippedDateKey = DIM_time.dateKey
GROUP BY DIM_Products.productLine, DIM_time.year, DIM_time.month;