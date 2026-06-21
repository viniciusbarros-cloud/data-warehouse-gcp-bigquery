WITH 
    clientes AS (
        SELECT * FROM {{ ref('stg_erp__clientes') }}

    )
    ,  localidades AS (
        SELECT * FROM {{ ref('stg_erp__localidades') }} 
    )

    , clientes_enriquecido AS (
        SELECT
            clientes.pk_cliente
        ,   clientes.nome_cliente
        ,   clientes.email_cliente
        ,   clientes.tipo_cliente
        ,   clientes.cpfcnpj_cliente
        ,   clientes.ts_inclusao
        ,   clientes.data_nascimento_cliente
        ,   clientes.endereco_cliente
        ,   clientes.cep_cliente
        ,   localidades.cidade AS cidade_cliente  
        ,    localidades.uf AS uf_cliente 
        FROM clientes
        LEFT JOIN localidades ON clientes.fk_localidade = localidades.pk_localidade
    )

    SELECT * FROM clientes_enriquecido