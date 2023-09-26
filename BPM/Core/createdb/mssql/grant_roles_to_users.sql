create user MAXDAT_REPORTS for login MAXDAT_REPORTS;
go

execute sp_addrolemember 'MAXDAT_READ_ONLY','maxdat_reports';
go
