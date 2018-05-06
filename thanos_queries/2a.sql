SELECT
	car_models.title AS model,
	COUNT(car_models.title) as service_count
FROM
	service_history
	INNER JOIN car_warehouse ON service_history.car_id = car_warehouse.id
	INNER JOIN car_models ON car_warehouse.model_id = car_models.id
GROUP BY
	car_models.title
HAVING
	COUNT(car_models.title) = (
		SELECT
			MAX(count)
		FROM (
			SELECT
				COUNT(car_models.title)
			FROM
				service_history
				INNER JOIN car_warehouse ON service_history.car_id = car_warehouse.id
				INNER JOIN car_models ON car_warehouse.model_id = car_models.id
			GROUP BY
				car_models.title
			ORDER BY
				count DESC
		) AS service_count
	)