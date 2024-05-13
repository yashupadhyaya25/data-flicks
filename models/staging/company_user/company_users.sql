with users as (
    select * from {{ ref('company_user') }}
)
select *,
regexp_like(
            login_email, '^[A-Za-z0-9._%+-]+@example.com$'
        ) as valid_email,
 from users