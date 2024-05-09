{{
    config(
        schema='REPORT',
        database='DATA_FLICKS',
        materialized='table'
    )
}}

with movies as (
select "id" movie_id,"release_year" as release_year,"title" as movie_name  from {{ ref('stg_netflix__movies') }}
),

credits as (
select "person_id" as actor_id,"id" as movie_id,"name" as actor_name from {{ ref('stg_netflix__credits') }}
)

select CAST(release_year as NUMBER(4,0)) release_year,actor_name,count(*) no_of_movie from (
select mv.release_year,mv.movie_id,mv.movie_name,crd.actor_id,crd.actor_name from movies as mv
inner join
credits as crd
on
mv.movie_id = crd.movie_id
) group by release_year,actor_name
order by count(*) desc