with movies as (
    select * from {{ source('netflix', 'TITLES') }}
),

credits as (
    select * from {{ source('netflix', 'CREDITS') }}
)
select * from (
select IFF(sum(result) = 0,null,sum(result)) as result from (
select count(*) result from movies where "imdb_score" < 0.0 or "tmdb_score" < 0.0
union
select count(*) result from credits where "person_id" is null or "id" is null
union
select count(*) result from
(
select 
distinct(MD5(concat("person_id",'_',"id",'_',"name",'_',NVL("character",'UNKNOW'),'_',"role")))
from credits 
group by 
MD5(concat("person_id",'_',"id",'_',"name",'_',NVL("character",'UNKNOW'),'_',"role"))
having count(*) > 1 
)
)
)  where result is not null
