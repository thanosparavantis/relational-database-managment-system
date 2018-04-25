SELECT finalResults.employeeId,MAX(results) maximumProfit
FROM(
	SELECT  buy_history.salesman_id AS employeeId,ROUND((sale_history.prices-buy_history.prices)::numeric,2) results
    FROM 
			(SELECT salesman_id ,SUM(price) prices FROM sales_history
			WHERE action='buy'
			GROUP BY salesman_id
			ORDER BY prices DESC)buy_history,
			
			(SELECT salesman_id,SUM(price) prices FROM sales_history
			WHERE action='sale'
			GROUP BY salesman_id
			ORDER BY prices DESC)sale_history
    WHERE buy_history.salesman_id=sale_history.salesman_id
    ORDER BY results DESC)finalResults
WHERE finalResults.results=(SELECT MAX(results) maximumProfit FROM(
										SELECT  buy_history.salesman_id AS employeeId,ROUND((sale_history.prices-buy_history.prices)::numeric,2) results
    									FROM 
											(SELECT salesman_id ,SUM(price) prices FROM sales_history
											WHERE action='buy'
											GROUP BY salesman_id
											ORDER BY prices DESC)buy_history,
			
											(SELECT salesman_id,SUM(price) prices FROM sales_history
											WHERE action='sale'
											GROUP BY salesman_id
											ORDER BY prices DESC)sale_history
    									WHERE buy_history.salesman_id=sale_history.salesman_id
										ORDER BY results DESC)finalResults)
GROUP BY finalResults.employeeId