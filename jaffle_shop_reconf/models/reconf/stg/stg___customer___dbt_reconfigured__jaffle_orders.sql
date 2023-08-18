/*
BEGIN OF reconfigured.io
DO NOT EDIT this section
RCSRC(c20737a743403716870401ef33983381)
*/
WITH base AS (
  SELECT
    -- Column: ___hash
    {{ md5("to_json_string(" +
         "rc37r29n" +
       ")") +
       " AS " + api.Column("___hash", "").quoted }},
    -- Column: ___as_of
    {{ "rc37r29n." + api.Column("___as_of", "").quoted +
       " AS " + api.Column("___as_of", "").quoted }},
    -- Column: ___source
    {{ "rc37r29n." + api.Column("___source", "").quoted +
       " AS " + api.Column("___source", "").quoted }},
    -- Column: ___source_id
    {{ "rc37r29n." + api.Column("___source_id", "").quoted +
       " AS " + api.Column("___source_id", "").quoted }},
    -- Column: ___created_at
    {{ "rc37r29n." + api.Column("___created_at", "").quoted +
       " AS " + api.Column("___created_at", "").quoted }},
    -- Column: ___updated_at
    {{ "rc37r29n." + api.Column("___updated_at", "").quoted +
       " AS " + api.Column("___updated_at", "").quoted }},
    -- Column: ___loaded_at
    {{ "rc37r29n." + api.Column("___loaded_at", "").quoted +
       " AS " + api.Column("___loaded_at", "").quoted }},
    -- Column: ___deleted_at
    {{ "rc37r29n." + api.Column("___deleted_at", "").quoted +
       " AS " + api.Column("___deleted_at", "").quoted }},
    -- Column: customer_id
    {{ "CAST(" +
         "rc37r29n." + api.Column("customer_id", "").quoted +
         " AS " + api.Column.translate_type("string") +
       ")" +
       " AS " + api.Column("customer_id", "").quoted }},
    -- Column: total_orders
    {{ safe_cast(
         "rc37r29n." + api.Column("total_orders", "").quoted,
         api.Column.translate_type("integer")
       ) +
       " AS " + api.Column("total_orders", "").quoted }}
  FROM {{ ref("stg___dbt_reconfigured__jaffle_orders") }} AS rc37r29n
)
/*
feel free to edit what comes after this
END OF reconfigured.io
*/

SELECT *
FROM base

