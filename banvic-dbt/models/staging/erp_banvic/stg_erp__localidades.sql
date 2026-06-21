WITH 
    fonte_localidades AS (
        SELECT * 
        FROM {{ source('erp', 'localidades') }}

    )

    , renomeado AS (
        SELECT 
                cod_localidade as pk_localidade 
              , cast(cidade as string) as cidade
              , cast(uf as string) as uf
        FROM fonte_localidades
    )


    SELECT * FROM renomeado