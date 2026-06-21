WITH    
    dim_agencias AS (
        SELECT * FROM {{ ref('int_dimensao_agencias')}}

    )

    SELECT * FROM dim_agencias