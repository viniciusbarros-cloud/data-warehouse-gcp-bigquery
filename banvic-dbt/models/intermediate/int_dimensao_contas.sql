WITH 
    contas AS (
        SELECT * FROM {{ ref('stg_erp__contas') }}

    )
    ,  selecionar_colunas AS 
    (       SELECT
            pk_conta
            , numero_conta
            , tipo_conta
            , ts_abertura_conta
            FROM contas
    )
    

    SELECT * FROM contas