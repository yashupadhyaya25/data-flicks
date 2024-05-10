{% macro group_generate_md5() -%}
    {% set column_to_md5 = ''%}
    {%- for key, value in kwargs.items() %}
        {% set column_to_md5 = [column_to_md5]|{value} %}
    {% endfor %}
    select {{column_to_md5}} from {{ ref('stg_netflix__shows') }}
{%- endmacro %}