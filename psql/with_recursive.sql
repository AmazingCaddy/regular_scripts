WITH RECURSIVE tr("parentId", id, path, level) AS (
  SELECT
    t."parentId",
    t.id,
    t.name::varchar(255),
    1 as level
    FROM "uaFaqCategory" AS t
  UNION ALL
  SELECT
    t."parentId",
    tr.id,
    (t.name || '->' || tr.path)::varchar(255),
    tr.level + 1
  FROM
    "uaFaqCategory" as t
  JOIN tr
  ON
    t.id = tr."parentId"
)
SELECT
  *
FROM
  tr
WHERE
  tr."parentId" IS null
ORDER BY
  id ASC