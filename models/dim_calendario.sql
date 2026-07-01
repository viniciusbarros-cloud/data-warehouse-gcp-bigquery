with datas_emissao as (
    select distinct
        issue_period as safra_emissao
    from {{ ref('stg_loans') }}
    where issue_period is not null
)

select 
    safra_emissao,
    -- Extrai o ano do texto (útil caso o formato venha como 'jan-2015')
    right(safra_emissao, 4) as ano_emissao
from datas_emissao