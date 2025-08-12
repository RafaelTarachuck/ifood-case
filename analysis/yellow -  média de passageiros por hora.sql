-- Análise da média de passageiros por hora do dia no mês de maio para yellow táxis
SELECT
  EXTRACT(HOUR FROM tpep_pickup_datetime) AS hora_do_dia,
  ROUND(AVG(passenger_count), 2) AS media_passageiros,
  COUNT(*) AS total_corridas
FROM
  nyc_taxi_data.yellow_tripdata
WHERE
  EXTRACT(MONTH FROM tpep_pickup_datetime) = 5
  AND EXTRACT(YEAR FROM tpep_pickup_datetime) = 2023
  AND passenger_count > 0  -- Exclui valores inválidos/zerados
GROUP BY
  hora_do_dia
ORDER BY
  hora_do_dia;