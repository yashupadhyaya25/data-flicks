{{
    config(
        schema='DBT_RAW',
        database='DATA_FLICKS'
    )
}}
select * from {{ source('netflix', 'TITLES') }} where type = 'SHOW'