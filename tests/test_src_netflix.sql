/*
################################################################
# Test Sql Created On - 2024/05/09 by Yash Upadhyaya
# Added Test on 2024/05/09 by Yash Upadhyaya
# - Check in movie & show imbd and tmbd score is not less than 0
# - Check in credits that person_id and id is not null
# - Check in credits for dulpicates
################################################################
*/

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
