/*
BEGIN OF reconfigured.io
DO NOT EDIT this section
RCSRC(2a5d23f72b8b6927c79704c173d4ebc5)
*/
WITH base AS (
  WITH ___collector AS (
    {{ dbt_utils.union_relations(
      relations=[
        ref("stg___customer___dbt_reconfigured__jaffle_customers"),
        ref("stg___customer___dbt_reconfigured__jaffle_orders")
      ]
    ) }}
  )
  SELECT
    -- Column: customer_id
    {{ api.Column("customer_id", "").quoted +
       " AS " + api.Column("customer_id", "").quoted }},
    -- Column: full_name
    {{ any_value(api.Column("full_name", "").quoted) +
       " AS " + api.Column("full_name", "").quoted }},
    -- Column: total_orders
    {{ "count(" +
         api.Column("total_orders", "").quoted +
       ")" +
       " AS " + api.Column("total_orders", "").quoted }}
  FROM ___collector
  GROUP BY {{
    api.Column("customer_id", "").quoted
  }}
  HAVING {{
    api.Column("customer_id", "").quoted + " IS NOT NULL"
  }}
)
/*
feel free to edit what comes after this
END OF reconfigured.io
*/

SELECT *
FROM base

