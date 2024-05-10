{%- macro group_generate_md5() -%}
    {%- set column_to_md5 = [] -%}
    {%- for key, value in kwargs.items() -%}
        {%-do column_to_md5.append("NVL(CAST("~value~" as VARCHAR),'UNKNOW')") -%}      
    {%- endfor -%}
    {{'MD5(CONCAT(' ~ column_to_md5|join(",'_',") ~ '))'}}
{%- endmacro -%}