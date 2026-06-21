WITH 
    fonte_clientes AS (
        SELECT * 
        FROM {{ source('erp', 'clientes') }}

    )

    , renomeado AS (
        SELECT 
            CAST(cod_cliente AS INT) AS pk_cliente
            ,CAST(cod_localidade AS INT) AS fk_localidade
            ,primeiro_nome || ' ' || ultimo_nome AS nome_cliente
            ,email AS email_cliente
            ,tipo_cliente
            ,CAST(data_inclusao AS timestamp) AS ts_inclusao
            ,regexp_replace(cpfcnpj, '[^a-zA-Z0-9]','') AS cpfcnpj_cliente
            ,CAST(data_nascimento AS DATE) AS data_nascimento_cliente
            ,endereco AS endereco_cliente
            ,regexp_replace(cep, '[^a-zA-Z0-9]','') AS cep_cliente
        FROM fonte_clientes
    )


    SELECT * FROM renomeado