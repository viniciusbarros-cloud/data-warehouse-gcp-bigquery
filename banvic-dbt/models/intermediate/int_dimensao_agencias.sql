WITH 
    agencias AS (
        SELECT * FROM {{ ref('stg_erp__agencias') }}

    )
    ,  localidades AS (
        SELECT * FROM {{ ref('stg_erp__localidades') }} 
    )

    , agencias_enriquecido AS (
        SELECT
            ag.pk_agencia
        ,   ag.fk_localidade
        ,   ag.nome_agencia
        ,   ag.endereco_agencia
        ,   ag.data_abertura_agencia
        ,   ag.tipo_agencia
        ,   localidades.cidade AS cidade_cliente  
        ,   localidades.uf AS uf_cliente 
        FROM agencias as ag
        LEFT JOIN localidades ON ag.fk_localidade = localidades.pk_localidade
    )

    SELECT * FROM agencias_enriquecido