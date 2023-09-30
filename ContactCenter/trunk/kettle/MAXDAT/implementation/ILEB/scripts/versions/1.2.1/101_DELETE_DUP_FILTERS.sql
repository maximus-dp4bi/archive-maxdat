delete from cc_c_filter where filter_Id in (67,68,69,70,71,72);

ALTER TABLE CC_C_FILTER ADD CONSTRAINT CC_C_FILTER__UN UNIQUE
(
  FILTER_TYPE , VALUE
)
;
commit;