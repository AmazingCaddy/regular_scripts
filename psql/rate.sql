WITH t (
  "monthKey",
  "faqIntentId",
  "count"
) AS (
  SELECT DISTINCT
    CAST(TO_CHAR(("quarterUtc" AT TIME ZONE 'Asia/Shanghai'), 'YYYY-MM') AS varchar) AS "monthKey",
    "factNormalFaqQuestionQuarterly"."faqIntentId",
    CAST(SUM("count") OVER (PARTITION BY TO_CHAR(("quarterUtc" AT TIME ZONE 'Asia/Shanghai'), 'YYYY-MM'), "factNormalFaqQuestionQuarterly"."faqIntentId") AS bigint) AS "count"
  FROM
    "factNormalFaqQuestionQuarterly"
  WHERE
    "botId" = 6
    --   AND "quarterUtc" >= '2020-12-01 00:00:00+0800'
    --   AND "quarterUtc" < '2021-01-01 00:00:00+0800'
    --   ORDER BY "botId" ASC, "count" DESC
),
tt (
  "monthKey", "faqIntentId", "count", "previousMonthKey"
) AS (
  SELECT
    "monthKey",
    "faqIntentId",
    "count",
    CAST(TO_CHAR(DATE_TRUNC('month', CONCAT("monthKey", '-01')::date - interval '1 month'), 'YYYY-MM') AS varchar) AS "previousMonthKey"
  FROM
    t
),
ttt (
  "faqIntentId", "monthKey", "previousMonthKey", "count", "previousCount"
) AS (
  SELECT
    "current"."faqIntentId" AS "faqIntentId",
    "current"."monthKey" AS "monthKey",
    previous."monthKey" AS "previousMonthKey",
    "current"."count" AS "count",
    previous."count" AS "previousCount"
  FROM
    tt AS "current"
    LEFT JOIN tt AS previous ON "current"."previousMonthKey" = previous."monthKey"
      AND "current"."faqIntentId" = previous."faqIntentId"
  WHERE
    previous."monthKey" IS NOT NULL
)
SELECT
  *
FROM
  ttt
ORDER BY
  ttt."faqIntentId",
  ttt."monthKey"
