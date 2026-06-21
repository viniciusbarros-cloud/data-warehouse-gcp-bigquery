WITH 
    fonte_colaboradores AS (
        SELECT * 
        FROM {{ source('erp', 'colaboradores') }}

    )

    , renomeado_transformacao AS (
        SELECT 
             CAST(cod_colaborador AS INT) AS pk_colaborador
            ,CAST(cod_gerente AS INT) AS fk_gerente
            ,CAST(cod_localidade AS INT) AS fk_localidade
            ,primeiro_nome || ' ' || ultimo_nome AS nome_colaborador
            ,email AS email_colaborador
            ,regexp_replace(cpf, '[^a-zA-Z0-9]','') AS cpf_colaborador
            ,CAST(data_nascimento AS DATE) AS data_nascimento_colaborador
            ,endereco AS endereco_colaborador
            ,regexp_replace(cep, '[^a-zA-Z0-9]','') AS cep_colaborador

            FROM fonte_colaboradores
        
    )


   SELECT * FROM renomeado_transformacao