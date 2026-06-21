WITH 
    date_spine AS 
    (
    {{ 
        dbt_utils.date_spine
    (
        datepart="day",
        start_date="cast('2020-01-01' as date)",
        end_date="cast('2030-01-01' as date)"
    )
    }} 

    )

    , criar_datas AS 
    (

      SELECT 
              ROW_NUMBER() OVER (ORDER BY date_day) as pk_data
              , CAST(date_day AS date) AS data_completa
              , EXTRACT(day FROM date_day) as dia
              , EXTRACT(month FROM date_day) as mes
              , EXTRACT(year FROM date_day) as ano
              , EXTRACT(quarter FROM date_day) as trimestre
              , EXTRACT(dow FROM date_day) as dia_da_semana
              ,  CASE 
                    WHEN EXTRACT(dow from date_day) IN (0,6) THEN TRUE
                    ELSE FALSE
                END AS is_final_de_semana


      FROM date_spine

    )

    SELECT * 
    FROM criar_datas