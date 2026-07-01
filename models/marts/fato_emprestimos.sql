{{ config(materialized='table') }}

with staging_data as (
    select * from {{ ref('stg_loans') }}
)

select
    loan_id,
    member_id as sk_cliente,
    issue_period as safra_emissao,
    
    loan_amount,
    funded_amount,
    monthly_installment,
    annual_income,
    interest_rate,
    term_months,

    credit_grade,
    credit_sub_grade,
    loan_purpose,
    loan_status,
    is_default

from staging_data
where loan_id is not null