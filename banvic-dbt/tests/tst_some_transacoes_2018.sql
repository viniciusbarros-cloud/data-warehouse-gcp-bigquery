/* Uma preocupação comum é se o valor auditado com diz
com aquele obtido do total de transações. Assim, este teste
verificará se as transações de 2018 batem com o valor auditado */

with
    soma_transacoes_2018 as
    (
        SELECT 
            extract(year from data_transacao) as ano
            , sum(valor_transacao) as total
            from {{ref("int_fact_transacoes")}}
            group by 1
    )

        SELECT * FROM soma_transacoes_2018
        WHERE ano = 2018 and total not between 822808.39 and 822808.49