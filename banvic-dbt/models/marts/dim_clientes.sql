WITH    
    clientes AS (
        SELECT * FROM {{ ref('int_dimensao_clientes')}}

    )

    SELECT * FROM clientes