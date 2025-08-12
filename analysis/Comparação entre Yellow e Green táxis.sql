-- Comparação entre Yellow e Green táxis
WITH yellow_stats AS (
  SELECT
    EXTRACT(MONTH FROM tpep_pickup_datetime) AS mes,
    COUNT(*) AS total_corridas,
    ROUND(AVG(total_amount), 2) AS media_valor,
    ROUND(AVG(passenger_count), 2) AS media_passageiros
  FROM
    nyc_taxi_data.yellow_tripdata
  WHERE
    EXTRACT(MONTH FROM tpep_pickup_datetime) BETWEEN 1 AND 5
    AND EXTRACT(YEAR FROM tpep_pickup_datetime) = 2023
  GROUP BY
    mes
),
green_stats AS (
  SELECT
    EXTRACT(MONTH FROM tpep_pickup_datetime) AS mes,
    COUNT(*) AS total_corridas,
    ROUND(AVG(total_amount), 2) AS media_valor,
    ROUND(AVG(passenger_count), 2) AS media_passageiros
  FROM
    nyc_taxi_data.green_tripdata
  WHERE
    EXTRACT(MONTH FROM tpep_pickup_datetime) BETWEEN 1 AND 5
    AND EXTRACT(YEAR FROM tpep_pickup_datetime) = 2023
  GROUP BY
    mes
)

SELECT
  y.mes,
  FORMAT_DATE('%B', DATE(CONCAT('2023-', CAST(y.mes AS STRING), '-01'))) AS nome_mes,
  y.total_corridas AS yellow_corridas,
  g.total_corridas AS green_corridas,
  y.media_valor AS yellow_media_valor,
  g.media_valor AS green_media_valor,
  y.media_passageiros AS yellow_media_passageiros,
  g.media_passageiros AS green_media_passageiros
FROM
  yellow_stats y
JOIN
  green_stats g
ON
  y.mes = g.mes
ORDER BY
  y.mes;