WITH 
    contas AS (
        SELECT * FROM {{ ref('stg_erp__contas') }}

    )
    ,  selecionar_colunas AS 
    (       SELECT
            pk_conta
            , fk_cliente
            , fk_agencia
            , fk_colaborador
            , saldo_total
            , saldo_disponivel
            , ts_ultimo_lancamento
            FROM contas
    )
    

    SELECT * FROM contas