WITH 
    fonte_contas AS (
        SELECT * 
        FROM {{ source('erp', 'contas') }}

    )

    , renomeado AS 
    (
        SELECT 
        CAST(num_conta AS INT) as pk_conta
         , cod_cliente as fk_cliente
         , cod_agencia as fk_agencia
         , cod_colaborador as fk_colaborador
         , CAST(num_conta AS INT) as numero_conta
         , tipo_conta
         , CAST(data_abertura as timestamp) as ts_abertura_conta
         , CAST(saldo_total as numeric(32,2)) as saldo_total
         , CAST(saldo_disponivel as numeric(32,2)) as saldo_disponivel
         , CAST(data_ultimo_lancamento as timestamp) as ts_ultimo_lancamento
        FROM fonte_contas

    )

   SELECT * FROM renomeado