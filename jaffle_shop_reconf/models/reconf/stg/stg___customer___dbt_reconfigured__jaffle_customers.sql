/*
BEGIN OF reconfigured.io
DO NOT EDIT this section
RCSRC(af4b85425b84af140dda9c1da9169477)
*/
WITH base AS (
  SELECT
    -- Column: ___hash
    {{ md5("to_json_string(" +
         "rc130tsx9" +
       ")") +
       " AS " + api.Column("___hash", "").quoted }},
    -- Column: ___as_of
    {{ "rc130tsx9." + api.Column("___as_of", "").quoted +
       " AS " + api.Column("___as_of", "").quoted }},
    -- Column: ___source
    {{ "rc130tsx9." + api.Column("___source", "").quoted +
       " AS " + api.Column("___source", "").quoted }},
    -- Column: ___source_id
    {{ "rc130tsx9." + api.Column("___source_id", "").quoted +
       " AS " + api.Column("___source_id", "").quoted }},
    -- Column: ___created_at
    {{ "rc130tsx9." + api.Column("___created_at", "").quoted +
       " AS " + api.Column("___created_at", "").quoted }},
    -- Column: ___updated_at
    {{ "rc130tsx9." + api.Column("___updated_at", "").quoted +
       " AS " + api.Column("___updated_at", "").quoted }},
    -- Column: ___loaded_at
    {{ "rc130tsx9." + api.Column("___loaded_at", "").quoted +
       " AS " + api.Column("___loaded_at", "").quoted }},
    -- Column: ___deleted_at
    {{ "rc130tsx9." + api.Column("___deleted_at", "").quoted +
       " AS " + api.Column("___deleted_at", "").quoted }},
    -- Column: customer_id
    {{ "CAST(" +
         "rc130tsx9." + api.Column("customer_id", "").quoted +
         " AS " + api.Column.translate_type("string") +
       ")" +
       " AS " + api.Column("customer_id", "").quoted }},
    -- Column: full_name
    {{ "CAST(" +
         "rc130tsx9." + api.Column("full_name", "").quoted +
         " AS " + api.Column.translate_type("string") +
       ")" +
       " AS " + api.Column("full_name", "").quoted }}
  FROM {{ ref("stg___dbt_reconfigured__jaffle_customers") }} AS rc130tsx9
)
/*
feel free to edit what comes after this
END OF reconfigured.io
*/

SELECT *
FROM base

