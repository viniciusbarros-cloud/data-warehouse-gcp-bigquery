with clientes_unicos as (
    select distinct
        member_id as sk_cliente,
        employment_title as cargo,
        employment_length_years as tempo_emprego_anos,
        home_ownership as tipo_residencia,
        annual_income as renda_anual,
        income_verification_status as status_verificacao_renda
    from {{ ref('stg_loans') }}
    where member_id is not null
)

select * from clientes_unicos 