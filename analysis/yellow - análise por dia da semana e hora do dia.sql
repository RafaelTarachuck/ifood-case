-- Análise por dia da semana e hora do dia
WITH corridas_por_dia_hora AS (
  SELECT
    EXTRACT(DAYOFWEEK FROM tpep_pickup_datetime) AS dia_semana,
    EXTRACT(HOUR FROM tpep_pickup_datetime) AS hora,
    COUNT(*) AS quantidade_corridas,
    AVG(total_amount) AS media_valor
  FROM
    nyc_taxi_data.yellow_tripdata
  WHERE
    EXTRACT(MONTH FROM tpep_pickup_datetime) BETWEEN 1 AND 3
    AND EXTRACT(YEAR FROM tpep_pickup_datetime) = 2023
  GROUP BY
    dia_semana, hora
)

SELECT
  CASE
    WHEN dia_semana = 1 THEN 'Domingo'
    WHEN dia_semana = 2 THEN 'Segunda'
    WHEN dia_semana = 3 THEN 'Terça'
    WHEN dia_semana = 4 THEN 'Quarta'
    WHEN dia_semana = 5 THEN 'Quinta'
    WHEN dia_semana = 6 THEN 'Sexta'
    WHEN dia_semana = 7 THEN 'Sábado'
  END AS dia_semana,
  hora,
  quantidade_corridas,
  ROUND(media_valor, 2) AS media_valor
FROM
  corridas_por_dia_hora
ORDER BY
  dia_semana, hora;