UPDATE d_pl_current
SET sla_days = 15
WHERE sla_days = 2;

COMMIT;
      