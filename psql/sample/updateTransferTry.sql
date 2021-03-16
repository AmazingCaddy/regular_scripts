UPDATE
  public.session
SET
  "transferTry" = (
    CASE WHEN ("agentId" IS NOT NULL) THEN
      TRUE
    WHEN ("agentId" IS NULL) THEN
      FALSE
    END)
