with movies as (
    select * from {{ ref('stg_netflix__movies') }}
)

select * from movies where "imdb_score" < 0.0 or "tmdb_score" < 0.0