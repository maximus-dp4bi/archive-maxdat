ALTER TABLE Report.sc_current_eligibles
Add reporting_date As convert(date, (reporting_month + '-01-' + reporting_year),110)
GO 

CREATE INDEX IX_sc_current_eligibles_reporting_date ON Report.sc_current_eligibles(reporting_date)
GO

ALTER TABLE Report.sc_enrollment_activity
Add reporting_date As convert(date, (reporting_month + '-01-' + reporting_year),110)
GO 

CREATE INDEX IX_sc_enrollment_activity_reporting_date ON Report.sc_enrollment_activity(reporting_date)
GO