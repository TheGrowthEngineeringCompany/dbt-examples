/*
dbt reconfigured macros before this is available as dbt package
*/
/* RCMACRO
normalize_email
 */
{% macro normalize_email(text) %}
  {{ return(adapter.dispatch('normalize_email') (text)) }}
{% endmacro %}
{% macro default__normalize_email() %}
  exceptions.raise_compiler_error("Unsupported target database")
{% endmacro %}
{% macro snowflake__normalize_email(text) %}
  CASE
    WHEN REGEXP_LIKE(
      TRIM({{ text }}),
      '^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9\\-.]+$'
    ) THEN REGEXP_REPLACE(LOWER(TRIM({{ text }})), '\\+[\\d\\D]*\\@', '@')
    ELSE NULL
  END
{% endmacro%}
{% macro bigquery__normalize_email(text) %}
  CASE
    WHEN REGEXP_CONTAINS(
      TRIM({{ text }}),
      r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$'
    ) THEN REGEXP_REPLACE(LOWER(TRIM({{ text }})), r'\+[\d\D]*\@', '@')
    ELSE NULL
  END
{% endmacro %}
/* END RCMACRO */
/* RCMACRO
integer_category_column
*/
{% macro integer_category_column(col, categories) %}
  CASE
{% for c in categories -%}
  WHEN {{ col }} = {{ string_literal(c) }} THEN {{ loop.index }}
{% endfor -%}
  END
{% endmacro %}
/* RCMACRO
aggregate
*/
{% macro aggregate(agg, col, order_by, order_by_direction) -%}
  {{ return(adapter.dispatch('aggregate')(agg, col, order_by, order_by_direction)) }}
{% endmacro %}
{% macro default__aggregate(agg, col, order_by, order_by_direction) -%}
{{ agg }}({{ col }}{% if order_by %} order by {{ order_by }}{% if order_by_direction %} {{ order_by_direction }}{%-endif -%}{%- endif -%})
{% endmacro %}
/* RCMACRO
most_recent
*/
{% macro most_recent(col, recency_col) -%}
{{ return(adapter.dispatch('most_recent')(col, recency_col)) }}
{%- endmacro %}
{% macro default__most_recent(col, recency_col) -%}
{{ array_get(array_agg(col, True, False, recency_col, 'DESC'), 0) }}
{%- endmacro %}
{% macro redshift__most_recent(col, recency_col) -%}
SPLIT_PART(LISTAGG({{ col }}::varchar, ', ') WITHIN GROUP (ORDER BY {{ recency_col }} DESC), ', ', 1)
{%- endmacro %}
/* RCMACRO
most_oldest
*/
{% macro most_oldest(col, recency_col) -%}
{{ return(adapter.dispatch('most_oldest')(col, recency_col)) }}
{%- endmacro %}
{% macro default__most_oldest(col, recency_col) -%}
{{ array_get(array_agg(col, True, False, recency_col, 'ASC'), 0) }}
{%- endmacro %}
{% macro redshift__most_oldest(col, recency_col) -%}
SPLIT_PART(LISTAGG({{ col }}::varchar, ', ') WITHIN GROUP (ORDER BY {{ recency_col }} ASC), ', ', 1)
{%- endmacro %}
/* END RCMACRO */
/* RCMACRO
array_agg
*/
{% macro array_agg(col, ignore_nulls, is_distinct, order_by, order_by_direction) -%}
array_agg({% if is_distinct %}distinct {% endif %}{{ col }}{% if ignore_nulls %} ignore nulls{% endif %}
{% if order_by %} order by {{ order_by }}{% if order_by_direction %} {{ order_by_direction }}{%-endif -%}{%- endif -%})
{%- endmacro %}
/* END RCMACRO */
/* RCMACRO
array_get
*/
{% macro array_get(val, i, t) -%}
  {{ return(adapter.dispatch('array_get')(val, i, t)) }}
{% endmacro %}
{% macro default__array_get(val, i, t) -%}
  exceptions.raise_compiler_error("Unsupported target database")
{% endmacro %}
{% macro snowflake__array_get(val, i, t) -%}
{%- if t %}cast({% endif -%}
get({{ val }}, {{ i }})
{%- if t %} as {{ t }}){% endif -%}
{% endmacro %}
{% macro bigquery__array_get(val, i, t) -%}
{%- if t %}cast({% endif -%}
{{ val }}[safe_offset({{ i }})]
{%- if t %} as {{ t }}){% endif -%}
{% endmacro %}
/* END RCMACRO */
/* RCMACRO
to_json
*/
{% macro to_json(d) %}
  {{ return(adapter.dispatch('to_json') (d)) }}
{% endmacro %}
{% macro default__to_json() %}
  exceptions.raise_compiler_error("Unsupported target database")
{% endmacro %}
{% macro snowflake__to_json(d) %}
TO_JSON({{ d }})
{% endmacro%}
{% macro bigquery__to_json(d) %}
TO_JSON({{ d }})
{% endmacro %}
/* END RCMACRO */
/* RCMACRO
to_json
*/
{% macro to_json_string(d) %}
  {{ return(adapter.dispatch('to_json_string') (d)) }}
{% endmacro %}
{% macro default__to_json_string() %}
  exceptions.raise_compiler_error("Unsupported target database")
{% endmacro %}
{% macro bigquery__to_json_string(d) %}
TO_JSON_STRING({{ d }})
{% endmacro %}
/* END RCMACRO */
/* RCMACRO
json_value
*/
{% macro json_value(val, json_path) %}
  {{ return(adapter.dispatch('json_value')(val, json_path)) }}
{% endmacro %}
{% macro default__json_value() %}
  exceptions.raise_compiler_error("Unsupported target database")
{% endmacro %}
{% macro bigquery__json_value(d, json_path) %}
JSON_VALUE({{ d }}, '{{ json_path }}')
{% endmacro %}
{% macro snowflake__json_value(d, json_path) %}
GET_PATH({{ d }}, '{{ json_path | replace('$.', '') }}')
{% endmacro %}
{% macro postgres__json_value(d, json_path) %}
{% set jpath = json_path.replace('$.', '').replace('[', '.').replace(']', '').split('.') %}
{{ d }}
{%- for p in jpath -%}
    {% if loop.last %}->>{% else %}->{% endif -%}
    {% if p.isnumeric() %}{{ p }}{% else %}'{{ p }}'{% endif %}
{%- endfor %}
{% endmacro %}
{% macro redshift__json_value(d, json_path) %}
{% set jpath = json_path.replace('$', '') %}
{{ d }}{{ jpath }}
{% endmacro %}
/* END RCMACRO */
/* RCMACRO
md5
*/
{% macro md5(d) %}
  {{ return(adapter.dispatch('md5') (d)) }}
{% endmacro %}
{% macro default__md5() %}
  exceptions.raise_compiler_error("Unsupported target database")
{% endmacro %}
{% macro snowflake__md5(d) %}
MD5({{ d }})
{% endmacro%}
{% macro bigquery__md5(d) %}
TO_HEX(MD5({{ d }}))
{% endmacro %}
/* END RCMACRO */
/* RCMACRO
count_distinct
*/
{% macro count_distinct(d) %}
  {{ return(adapter.dispatch('count_distinct') (d)) }}
{% endmacro %}
{% macro default__count_distinct(d) %}
COUNT(DISTINCT {{ d }})
{% endmacro %}
//* RCMACRO
distinct
*/
{% macro distinct(d) %}
  {{ return(adapter.dispatch('distinct') (d)) }}
{% endmacro %}
{% macro default__distinct(d) %}
DISTINCT {{ d }}
{% endmacro %}
/* END RCMACRO */* END RCMACRO */
/* RCMACRO
in
*/
{% macro in(v, arr) %}
  {{ return(adapter.dispatch('in')(v, arr)) }}
{% endmacro %}
{% macro default__in() %}
  exceptions.raise_compiler_error("Unsupported target database")
{% endmacro %}
{% macro snowflake__in(v, arr) %}
ARRAY_CONTAINS({{ v }}::variant, {{ arr }})
{% endmacro%}
{% macro bigquery__in(v, arr) %}
{{ v }} IN UNNEST({{ arr }})
{% endmacro %}
/* END RCMACRO */
/* RCMACRO
epoch_to_timestamp
*/
{% macro epoch_to_timestamp(d) %}
{{ return(adapter.dispatch('epoch_to_timestamp')(d)) }}
{% endmacro %}
{% macro default__epoch_to_timestamp(d) %}
exceptions.raise_compiler_error("Unsupported target database")
{% endmacro %}
{% macro redshift__epoch_to_timestamp(d) %}
TIMESTAMP 'epoch' + {{ d }} * INTERVAL '1 second'
{% endmacro %}
/* END RCMACRO */
