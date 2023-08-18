/*
BEGIN OF reconfigured.io
DO NOT EDIT this section
RCSRC(e4223c3ce6c9f8c3962adf445551a976)
*/
WITH base AS (
  SELECT
    -- Column: ___source
    {{ string_literal("dbt_reconfigured__jaffle_customers") +
       " AS " + api.Column("___source", "").quoted }},
    -- Column: ___source_id
    {{ "CAST(" +
         "rc18zsb2g." + api.Column("id", "").quoted +
         " AS " + api.Column.translate_type("string") +
       ")" +
       " AS " + api.Column("___source_id", "").quoted }},
    -- Column: ___created_at
    {{ safe_cast(
         "NULL",
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
         "NULL",
         api.Column.translate_type("timestamp")
       ) + ", " +
         safe_cast(
         "NULL",
         api.Column.translate_type("timestamp")
       ) +
       ")" +
       " AS " + api.Column("___as_of", "").quoted }},
    -- Column: customer_id
    {{ "rc18zsb2g." + api.Column("id", "").quoted +
       " AS " + api.Column("customer_id", "").quoted }},
    -- Column: full_name
    {{ "concat(" +
         "rc18zsb2g." + api.Column("first_name", "").quoted + ", " +
         "CAST(" +
           string_literal(" ") +
           " AS " + api.Column.translate_type("string") +
         ")" + ", " +
         "rc18zsb2g." + api.Column("last_name", "").quoted +
       ")" +
       " AS " + api.Column("full_name", "").quoted }}
  FROM {{ source("dbt_reconfigured", "jaffle_customers") }} AS rc18zsb2g
)
/*
feel free to edit what comes after this
END OF reconfigured.io
*/

SELECT *
FROM base

