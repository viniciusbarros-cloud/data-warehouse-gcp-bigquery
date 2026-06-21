WITH 
    colaboradores AS (
        SELECT * FROM {{ ref('stg_erp__colaboradores') }}

    )
    ,  localidades AS (
        SELECT * FROM {{ ref('stg_erp__localidades') }} 
    )

, colaboradores_enriquecido AS (
        SELECT
            col.pk_colaborador
            ,col.fk_gerente
            ,col.fk_localidade
            ,col.nome_colaborador
            ,col.email_colaborador
            ,col.cpf_colaborador
            ,col.data_nascimento_colaborador
            ,col.endereco_colaborador
            ,col.cep_colaborador
            ,localidades.cidade AS cidade_colaborador 
            ,localidades.uf AS uf_colaborador
        FROM colaboradores AS col
        LEFT JOIN localidades ON col.fk_localidade = localidades.pk_localidade
    )

    SELECT * FROM colaboradores_enriquecido
