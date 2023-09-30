SELECT DATEADD(DAY, rn, '2010-01-01') as D_Date,
case when Dateadd(dd, rn, '2010-01-01') 
IN('2010-01-01','2010-04-02','2010-04-05','2010-05-03','2010-05-31','2010-08-30','2010-12-27','2010-12-28'
,'2011-01-01','2011-04-22','2011-04-25','2011-05-02','2011-05-30','2011-08-29','2011-12-26','2011-12-27'
,'2012-01-02','2012-04-06','2012-04-09','2012-05-07','2012-06-04','2012-06-05','2012-08-27','2012-12-25','2012-12-26'
,'2013-01-01','2013-03-29','2013-04-01','2013-05-06','2013-05-27','2013-08-26','2013-12-25','2013-12-26'
,'2014-01-01','2014-04-18','2014-04-21','2014-05-05','2014-05-26','2014-08-25','2014-12-25','2014-12-26'
,'2015-01-01','2015-04-03','2015-04-06','2015-05-04','2015-05-25','2015-08-31','2015-12-25','2015-12-28'
,'2016-01-01','2016-03-25','2016-03-28','2016-05-02','2016-05-30','2016-08-29','2016-12-26','2016-12-27'
,'2017-01-02','2017-04-14','2017-04-17','2017-05-01','2017-05-29','2017-08-28','2017-12-25','2017-12-26'
,'2018-01-01','2018-03-30','2018-04-02','2018-05-07','2018-05-28','2018-08-27','2018-12-25','2018-12-26')
then 'Y' else 'N' end as HOLIDAY_FLAG,
case when datename(dw,Dateadd(dd, rn, '2010-01-01')) IN('Saturday','Sunday') then 'Y' else 'N' end as WEEKEND_FLAG
FROM 
(
SELECT TOP (DATEDIFF(DAY, '2010-01-01', '2020-12-31') + 1) 
rn = ROW_NUMBER() OVER (ORDER BY [object_id])-1
FROM sys.all_objects
) AS daterange