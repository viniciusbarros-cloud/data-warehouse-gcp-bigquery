WITH    
    dim_datas AS (
        SELECT * FROM {{ ref('int_dimensao_data')}}

    )

    SELECT * FROM dim_datas