WITH "inputFaqIntent"(id) AS (
  SELECT UNNEST(ARRAY[2816]::BIGINT[])
), "deleteFaqIntent"(id) AS (
  SELECT "normalFaqIntent".id 
  FROM "normalFaqIntent"
  INNER JOIN "inputFaqIntent"
  ON "normalFaqIntent".id = "inputFaqIntent".id
  WHERE "normalFaqIntent"."botId" = 6
)
UPDATE "labelNormalFaq" SET "faqIntentId" = NULL, status = 'unlabeled'
FROM "deleteFaqIntent"
WHERE "labelNormalFaq"."faqIntentId" = "deleteFaqIntent".id


WITH RECURSIVE "recursiveCategory"("parentId", id) AS (
  SELECT category."parentId", category.id
  FROM "normalFaqCategory" AS category
  WHERE "botId" = 6
  UNION ALL
  SELECT category."parentId", "recursiveCategory".id
  FROM "normalFaqCategory" AS category
  INNER JOIN "recursiveCategory"
  ON category.id = "recursiveCategory"."parentId"
), "finalCategory"(id) AS (
  SELECT id
  FROM "normalFaqCategory" AS category
  WHERE id = 4050
  AND "botId" = 6
  UNION
  SELECT id
  FROM "recursiveCategory" AS category
  WHERE category."parentId" = 4050
), "deleteFaqIntent"(id) AS (
  SELECT "normalFaqIntent".id
  FROM "normalFaqIntent"
  INNER JOIN "finalCategory"
  ON "normalFaqIntent"."categoryId" = "finalCategory".id
)
-- SELECT * FROM "deleteFaqIntent"

-- SELECT "labelNormalFaq".*, "deleteFaqIntent".id
-- FROM "labelNormalFaq"
-- INNER JOIN "deleteFaqIntent"
-- ON "labelNormalFaq"."faqIntentId" = "deleteFaqIntent".id
-- ORDER BY ID ASC

UPDATE "labelNormalFaq" SET "faqIntentId" = NULL, status = 'unlabeled'
FROM "deleteFaqIntent"
WHERE "labelNormalFaq"."faqIntentId" = "deleteFaqIntent".id;


-- with category
-- select 
--   * 
-- from 
--   "labelNormalFaq"
--   where "labelPointId" in (24212, 21598)
-- inner join 
--   "deleteFaqIntent" 
-- on "labelNormalFaq"."faqIntentId" = "deleteFaqIntent".id