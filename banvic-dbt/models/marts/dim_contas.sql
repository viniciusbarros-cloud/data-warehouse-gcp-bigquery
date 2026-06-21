WITH    
    dim_contas AS (
        SELECT * FROM {{ ref('int_dimensao_contas')}}

    )

    SELECT * FROM dim_contas