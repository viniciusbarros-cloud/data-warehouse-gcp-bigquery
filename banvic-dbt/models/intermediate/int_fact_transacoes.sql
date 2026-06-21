WITH 
    transacoes AS 
    (
        SELECT 
             pk_transacao
          , fk_conta
          , numero_transacao
          , data_transacao
          , ts_transacao
          , nome_transacao
          , tipo_transacao
          , valor_transacao
    
    FROM {{ ref('stg_erp__transacoes') }} 
    
    )

    , contas as 
    
    (

        SELECT 
        pk_conta
       , fk_cliente
       , fk_agencia
       , fk_colaborador 
        FROM {{ref('int_fact_contas')}}
    )
    ,   datas as 
    (
        SELECT
            pk_data
          , data_completa


        FROM {{ref('int_dimensao_data')}}
    )
    ,   joined AS (
        SELECT
           t.pk_transacao
          , t.fk_conta
          ,  c.fk_cliente
          ,  c.fk_agencia
          ,  c.fk_colaborador
          , d.pk_data as fk_data
          , t.numero_transacao
          , t.data_transacao
          , t.ts_transacao
          , t.nome_transacao
          , t.tipo_transacao
          , t.valor_transacao
    
        FROM transacoes as t
        LEFT JOIN contas  as c
        ON (t.fk_conta = c.pk_conta)
        LEFT JOIN datas as d
        ON (t.data_transacao = d.data_completa)
    )

SELECT * FROM joined
        