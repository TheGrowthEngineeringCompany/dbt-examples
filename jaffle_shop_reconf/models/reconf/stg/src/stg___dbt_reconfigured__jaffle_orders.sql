/*
BEGIN OF reconfigured.io
DO NOT EDIT this section
RCSRC(1d1c0da3429c38560766a9c74bfee989)
*/
WITH base AS (
  SELECT
    -- Column: ___source
    {{ string_literal("dbt_reconfigured__jaffle_orders") +
       " AS " + api.Column("___source", "").quoted }},
    -- Column: ___source_id
    {{ "CAST(" +
         "rc1isaabk." + api.Column("id", "").quoted +
         " AS " + api.Column.translate_type("string") +
       ")" +
       " AS " + api.Column("___source_id", "").quoted }},
    -- Column: ___created_at
    {{ safe_cast(
         "rc1isaabk." + api.Column("_etl_loaded_at", "").quoted,
         api.Column.translate_type("timestamp")
       ) +
       " AS " + api.Column("___created_at", "").quoted }},
    -- Column: ___updated_at
    {{ safe_cast(
         "NULL",
         api.Column.translate_type("timestamp")
       ) +
       " AS " + api.Column("___updated_at", "").quoted }},
    -- Column: ___loaded_at
    {{ safe_cast(
         "NULL",
         api.Column.translate_type("timestamp")
       ) +
       " AS " + api.Column("___loaded_at", "").quoted }},
    -- Column: ___deleted_at
    {{ safe_cast(
         "NULL",
         api.Column.translate_type("timestamp")
       ) +
       " AS " + api.Column("___deleted_at", "").quoted }},
    -- Column: ___as_of
    {{ "COALESCE(" +
         safe_cast(
         "NULL",
         api.Column.translate_type("timestamp")
       ) + ", " +
         safe_cast(
         "rc1isaabk." + api.Column("_etl_loaded_at", "").quoted,
         api.Column.translate_type("timestamp")
       ) + ", " +
         safe_cast(
         "NULL",
         api.Column.translate_type("timestamp")
       ) +
       ")" +
       " AS " + api.Column("___as_of", "").quoted }},
    -- Column: customer_id
    {{ "rc1isaabk." + api.Column("user_id", "").quoted +
       " AS " + api.Column("customer_id", "").quoted }},
    -- Column: total_orders
    {{ "rc1isaabk." + api.Column("id", "").quoted +
       " AS " + api.Column("total_orders", "").quoted }}
  FROM {{ source("dbt_reconfigured", "jaffle_orders") }} AS rc1isaabk
)
/*
feel free to edit what comes after this
END OF reconfigured.io
*/

SELECT *
FROM base

