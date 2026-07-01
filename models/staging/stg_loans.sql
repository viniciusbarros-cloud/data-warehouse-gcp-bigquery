with source_data as (
    select * from {{ source('bronze_zone', 'raw_loans') }}
),

cleaned_data as (
    select
        cast(id as string) as loan_id,
        cast(member_id as string) as member_id,

        cast(loan_amnt as float64) as loan_amount,
        cast(funded_amnt as float64) as funded_amount,
        cast(installment as float64) as monthly_installment,
        cast(annual_inc as float64) as annual_income,
        
        -- CORREÇÃO: Como já é número (float64), fazemos apenas o cast direto!
        cast(int_rate as float64) as interest_rate,
        
        -- PREVENÇÃO: Forçamos para string antes do regex, caso o Pandas tenha convertido para número
        cast(regexp_extract(cast(term as string), r'\d+') as int64) as term_months,

        lower(trim(grade)) as credit_grade,
        lower(trim(sub_grade)) as credit_sub_grade,
        lower(trim(cast(emp_title as string))) as employment_title,
        lower(trim(home_ownership)) as home_ownership,
        lower(trim(verification_status)) as income_verification_status,
        lower(trim(purpose)) as loan_purpose,

        -- PREVENÇÃO: Forçamos para string antes do LIKE
        case 
            when cast(emp_length as string) like '%10+%' then 10
            when cast(emp_length as string) like '%< 1%' then 0
            else cast(regexp_extract(cast(emp_length as string), r'\d+') as int64)
        end as employment_length_years,

        lower(trim(issue_d)) as issue_period, 
        lower(trim(loan_status)) as loan_status,
        
        case 
            when lower(trim(loan_status)) in ('charged off', 'default', 'does not meet the credit policy. status:charged off') then 1
            else 0
        end as is_default

    from source_data
)

select * from cleaned_data