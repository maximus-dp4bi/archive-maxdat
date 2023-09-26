options (skip=1)
load data
append
into table CLEAR2WORK_SITE
fields terminated by ','
optionally enclosed by '"'
trailing nullcols
(SITE_NAME, CLEAR_SITE, BRIVO_SITE, SITE_GROUP, DIVISION)