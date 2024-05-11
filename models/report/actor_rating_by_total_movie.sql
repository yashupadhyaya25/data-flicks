with movies as 
(
    select * from {{ ref('stg_netflix__movies') }}
),

actors as (
    select * from {{ ref('stg_netflix__credits') }}
)

select actor_id,actor_name,cast(round(avg(imdb_score),2) as DECIMAL(3,2)) avg_imdb_rating,cast(round(avg(tmdb_score),2) as DECIMAL(3,2)) avg_tmdb_rating from 
(
select 
cast("person_id" as NUMBER(10,0)) actor_id,
cast("name" as VARCHAR(80)) actor_name,
cast(mov.id as NUMBER(15,0)) as movie_id,
mov.imdb_score imdb_score,
mov.tmdb_score tmdb_score 
from actors as act
left join
movies as mov
on
act."id" = mov.id
) group by actor_id,actor_name