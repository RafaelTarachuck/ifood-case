-- Média do total_amount por mês para yellow táxis (Janeiro a Março de 2023)
SELECT
  EXTRACT(YEAR FROM tpep_pickup_datetime) AS ano,
  EXTRACT(MONTH FROM tpep_pickup_datetime) AS mes,
  FORMAT_DATE('%B', DATE(tpep_pickup_datetime)) AS nome_mes,
  ROUND(AVG(total_amount), 2) AS media_valor_total,
  COUNT(*) AS quantidade_corridas
FROM
  nyc_taxi_data.yellow_tripdata
WHERE
  EXTRACT(MONTH FROM tpep_pickup_datetime) BETWEEN 1 AND 3
  AND EXTRACT(YEAR FROM tpep_pickup_datetime) = 2023
GROUP BY
  ano, mes, nome_mes
ORDER BY
  mes;