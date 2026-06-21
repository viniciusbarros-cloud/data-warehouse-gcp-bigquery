WITH    
    dim_colaboradores AS (
        SELECT * FROM {{ ref('int_dimensao_colaboradores')}}

    )

    SELECT * FROM dim_colaboradores