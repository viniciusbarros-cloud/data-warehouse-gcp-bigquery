WITH    
    dim_transacoes AS (
        SELECT * FROM {{ ref('int_fact_transacoes')}}

    )

    SELECT * FROM dim_transacoes