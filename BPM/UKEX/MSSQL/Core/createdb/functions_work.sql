/*
ALTER function ETL_COMMON_BUS_DAYS_BETWEEN
    (@p_start_date date,
     @p_end_date date)
    returns integer
  as
  begin

  declare
    @v_num_days integer = 0,
    @v_from_date date = null,
    @v_to_date date = null; 
  
    select @v_from_date = convert(date,@p_start_date,101),
    @v_to_date = convert(date,@p_end_date,101);

    with date_tab(business_date) as
      (
	  
	  select @v_from_date
	  union all
      SELECT DateAdd(day,1,date_tab.business_date) FROM date_tab WHERE date_tab.business_date < @v_to_date
	   )
    select  @v_num_days=count(business_date) - 1 
    from date_tab
    where
      datename(dw,business_date) not in ('Saturday','Sunday')
      and business_date not in 
        (select HOLIDAY_DATE 
         from HOLIDAYS 
         where HOLIDAY_DATE between @v_from_date and @v_to_date);
  
    if @v_num_days < 0 
		begin
			select @v_num_days = 0;
		end;

	return @v_num_days;
end;

 function GET_WEEKDAY
    (p_start_date in date, 
     p_days2add in number) 
    return date 
  as
    v_counter      natural := 0;
    v_curdate      date := p_start_date;
    v_daynum       positive;
    v_skipcntr     natural := 0;
    v_direction    integer := 1; -- days after start_date
    v_businessdays number := p_days2add;
  begin

    if p_days2add < 0 then
      v_direction    := -1; -- days before start_date
      v_businessdays := (-1) * v_businessdays;
    end if;

    while v_counter < v_businessdays
    loop
      v_curdate := v_curdate + v_direction;
      v_daynum  := to_char(v_curdate,'D');
      if v_daynum between 2 and 6 then
        v_counter := v_counter + 1;
      else
        v_skipcntr := v_skipcntr + 1;
      end if;
    end loop;

    return p_start_date + (v_direction * (v_counter + v_skipcntr));
    
  end;


ALTER function ETL_COMMON_BUS_DAYS_BETWEEN
    (@p_start_date date,
     @p_days2add integer)
    returns date
  as
  begin

  declare
    @v_counter      integer = 0,
    @v_curdate      date = @p_start_date,
    @v_daynum       integer,
    @v_skipcntr     integer = 0,
    @v_direction    integer = 1, -- days after start_date
    @v_businessdays integer = @p_days2add;


    if @p_days2add < 0
	begin
      select @v_direction    = -1; -- days before start_date
      select @v_businessdays = (-1) * @v_businessdays;
    end;

    while @v_counter < @v_businessdays
	begin
      select @v_curdate = dateadd(d, @v_direction,@v_curdate);
      select @v_daynum  = datepart(d,@v_curdate);
      if @v_daynum between 2 and 6
        select @v_counter = @v_counter + 1;
      else
        select @v_skipcntr = @v_skipcntr + 1;
   end;

    select @p_start_date= dateadd(d,(@v_direction * (@v_counter + @v_skipcntr)),@p_start_date);
	return @p_start_date;
end;

create function ETL_COMMON_GET_WEEKDAY
    (@p_start_date date,
     @p_days2add integer)
    returns date
  as
  begin

  declare
    @v_counter      integer = 0,
    @v_curdate      date = @p_start_date,
    @v_daynum       integer,
    @v_skipcntr     integer = 0,
    @v_direction    integer = 1, -- days after start_date
    @v_businessdays integer = @p_days2add;

  begin
    if @p_days2add < 0
	begin
      select @v_direction    = -1; -- days before start_date
      select @v_businessdays = (-1) * @v_businessdays;
    end;

    while @v_counter < @v_businessdays
	begin
      select @v_curdate = dateadd(d, @v_direction,@v_curdate);
      select @v_daynum  = datepart(d,@v_curdate);
      if @v_daynum between 2 and 6
        select @v_counter = @v_counter + 1;
      else
        select @v_skipcntr = @v_skipcntr + 1;
   end;
   end;

    select @p_start_date= dateadd(d,(@v_direction * (@v_counter + @v_skipcntr)),@p_start_date);
	return @p_start_date;
end;


create function ETL_COMMON_GET_BUS_DATE
    (@p_start_date date,
     @p_number_days integer)
    returns date
  begin

  declare
    @v_weekdate date = null,
   -- @v_loop integer = 0,
    @v_holiday integer = null,
    --@v_holiday_flag integer= 1,
    @v_counter      integer = 0,
    @v_curdate      date ,
    @v_daynum       integer,
    @v_skipcntr     integer = 0,
    @v_direction    integer = 1, -- days after start_date
    @v_businessdays integer = @p_number_days;

     select @v_curdate = @p_start_date;

		select @v_holiday =count(1)
		from HOLIDAYS
		where HOLIDAY_DATE = @v_curdate;
      
		if (datepart(d,@v_curdate) IN(1,7) OR @v_holiday != 0) and @p_number_days = 0
		select @v_businessdays = 1;        
  
		if @p_number_days < 0 
		begin
		select @v_direction    = -1; -- days before start_date
		select @v_businessdays = (-1) * @v_businessdays;
		end;
      
	while @v_counter < @v_businessdays
	begin
         
		select @v_curdate = dateadd(d,@v_direction,@v_curdate);
		select @v_holiday = 0;
		select @v_holiday= count(1)
		from HOLIDAYS
		where HOLIDAY_DATE = @v_curdate;
   
		select @v_daynum  = datepart(d,@v_curdate);
		if (@v_daynum between 2 and 6) AND @v_holiday = 0
			select @v_counter = @v_counter + 1;
		else
			select @v_skipcntr = @v_skipcntr + 1;
	end;

	select @v_weekdate=dateadd(d, (@v_direction * (@v_counter + @v_skipcntr)),  @p_start_date );
    
	RETURN @v_weekdate;
end;

alter function GET_INLIST_STR2
    (@p_task_type varchar,
     @p_list_type varchar)
    returns varchar
  as
  begin
    declare @v_list varchar(4000) = null,
    @v_first varchar(1) = 'Y',
	@list_char varchar(1)='';
    if @p_list_type = 'S' select @list_char='''';

Select @v_list= 
    substring(
        (
            Select ','+ST1.ref_id  AS [text()]
            From dbo.Corp_ETL_List_Lkup ST1
            Where ST1.Ref_ID = ST2.ref_id
			and ST1.Name = 'TASK_MONITOR_TYPE'
			and ST1.OUT_VAR = @p_task_type
            ORDER BY ST1.ref_id
            For XML PATH ('')
        ), 2, 1000)
From dbo.Corp_ETL_List_Lkup ST2
  
    return @v_list;
    
  end;


  create  function GET_INLIST_STR3
    (@p_name varchar,
     @p_list_type varchar)
    returns varchar
  as
  begin
    declare @v_list varchar(4000) = null,
    @v_first varchar(1) = 'Y',
	@list_char varchar(1)='';
    if @p_list_type = 'S' select @list_char='''';

Select @v_list= 
    substring(
        (
            Select ','+ST1.ref_id  AS [text()]
            From dbo.Corp_ETL_List_Lkup ST1
            Where ST1.Ref_ID = ST2.ref_id
			and st1.name=@p_name
            ORDER BY ST1.ref_id
            For XML PATH ('')
        ), 2, 1000)
From dbo.Corp_ETL_List_Lkup ST2
  
    return @v_list;
    
  end;




alter function GET_INLIST_STR2
    (@p_task_type varchar,
     @p_list_type varchar)
    returns varchar
  as
  begin
    declare @v_list varchar(4000) = null,
    @v_first varchar(1) = 'Y',
	@list_char varchar(1)='';
    if @p_list_type = 'S' select @list_char='''';

Select @v_list= 
    substring(
        (
            Select ','+ST1.ref_id  AS [text()]
            From dbo.Corp_ETL_List_Lkup ST1
            Where ST1.Ref_ID = ST2.ref_id
			and ST1.Name = 'TASK_MONITOR_TYPE'
			and ST1.OUT_VAR = @p_task_type
            ORDER BY ST1.ref_id
            For XML PATH ('')
        ), 2, 1000)
From dbo.Corp_ETL_List_Lkup ST2
  
    return @v_list;
    
  end;

alter function BPM_COMMON_BUS_DAYS_BETWEEN
(@p_start_date date,
     @p_end_date date)
    returns integer
as begin
declare @SVN_FILE_URL varchar(200) = '$URL$',
  @SVN_REVISION varchar(20) = '$Revision$',
  @SVN_REVISION_DATE varchar(60) = '$Date$',
  @SVN_REVISION_AUTHOR varchar(20) = '$Author$',
  @DATE_FMT smallint = 121;

  declare @MIN_GDATE date = convert(date,'0001-01-01 00:00:00',@DATE_FMT),
  @MAX_GDATE date = convert(date,'9999-12-31 00:00:00',@DATE_FMT),
  @MAX_DATE date = convert(date,'2077-07-07 00:00:00',@DATE_FMT),
  @LOG_LEVEL_SEVERE  varchar(6) = 'SEVERE',
  @LOG_LEVEL_WARNING varchar(7) = 'WARNING',
  @LOG_LEVEL_INFO    varchar(4) = 'INFO',
  @LOG_LEVEL_CONFIG  varchar(6) = 'CONFIG',
  @LOG_LEVEL_FINE    varchar(4) = 'FINE',
  @LOG_LEVEL_FINER   varchar(5) = 'FINER',
  @LOG_LEVEL_FINEST  varchar(6) = 'FINEST';
return dbo.ETL_COMMON_BUS_DAYS_BETWEEN(@p_start_date,@p_end_date);
  end;
alter function BPM_COMMON_BUS_DAYS_BETWEEN
(@p_start_date date,
     @p_end_date date)
    returns integer
as begin
declare @SVN_FILE_URL varchar(200) = '$URL$',
  @SVN_REVISION varchar(20) = '$Revision$',
  @SVN_REVISION_DATE varchar(60) = '$Date$',
  @SVN_REVISION_AUTHOR varchar(20) = '$Author$',
  @DATE_FMT smallint = 121;

  declare @MIN_GDATE date = convert(date,'0001-01-01 00:00:00',@DATE_FMT),
  @MAX_GDATE date = convert(date,'9999-12-31 00:00:00',@DATE_FMT),
  @MAX_DATE date = convert(date,'2077-07-07 00:00:00',@DATE_FMT),
  @LOG_LEVEL_SEVERE  varchar(6) = 'SEVERE',
  @LOG_LEVEL_WARNING varchar(7) = 'WARNING',
  @LOG_LEVEL_INFO    varchar(4) = 'INFO',
  @LOG_LEVEL_CONFIG  varchar(6) = 'CONFIG',
  @LOG_LEVEL_FINE    varchar(4) = 'FINE',
  @LOG_LEVEL_FINER   varchar(5) = 'FINER',
  @LOG_LEVEL_FINEST  varchar(6) = 'FINEST';
return dbo.ETL_COMMON_BUS_DAYS_BETWEEN(@p_start_date,@p_end_date);
  end;


create procedure BPM_COMMON_LOGGER
    (@p_log_level varchar,
     @p_pbqj_id integer,
     @p_run_data_object varchar,
     @p_bsl_id integer,
     @p_bil_id integer,
     @p_identifier integer,
     @p_bi_id integer,
     @p_log_message varchar,
     @p_error_number integer)
as
begin
begin tran logrow
    insert into BPM_Logging
      (LOG_DATE,LOG_LEVEL,PBQJ_ID,RUN_DATA_OBJECT,BSL_ID,BIL_ID,IDENTIFIER,BI_ID,MESSAGE,Error_Number,BACKTRACE)
    values 
      (getdate(),@p_log_level,@p_pbqj_id,@p_run_data_object,@p_bsl_id,@p_bil_id,@p_identifier,@p_bi_id,
       @p_log_message,@p_error_number,1);

commit tran logrow;
raiserror(@p_log_message,@p_log_level,1,1) with log;
end;



  -- Clean parameter to avoid SQL injection.
  create function BPM_COMMON_CLEAN_PARAMETER
    (@p_parameter_value varchar)
    returns varchar
  as
  begin
  declare @v_procedure_name varchar(61) = OBJECT_NAME(@@PROCID) + '.' + 'CLEAN_PARAMETER',
    @v_sql_code integer = null,
    @v_log_message varchar = null,
    @v_parameter_value_clean varchar(100) = null;

    if @p_parameter_value is null
       select @v_parameter_value_clean = @p_parameter_value;
    else begin
      select @v_parameter_value_clean = replace(@p_parameter_value,' ','');  -- Remove any spaces to avoid SQL injections  
      select @v_parameter_value_clean = replace(@v_parameter_value_clean,';','');  -- Remove any semicolon to avoid SQL injections
     end;    
    return @v_parameter_value_clean;
--      select @v_sql_code = SQLCODE;
--      select @v_log_message = 'Unable to clean parameter value "' + @p_parameter_value + '".  ' + SQLERRM;
--      BPM_COMMON_LOGGER(BPM_COMMON_LOG_LEVEL_SEVERE,null,@v_procedure_name,null,null,null,null,@v_log_message,@v_sql_code);
--      raise;
  end;

 create function BPM_CONSTANT_DATE_FMT()
 returns smallint
 as begin
 return 121;
 end;

  alter function BPM_CONSTANT_MIN_GDATE()
 returns date
 as begin
 return convert(date,'0001-01-01 00:00:00',dbo.BPM_CONSTANT_DATE_FMT())
 end;

 create function BPM_CONSTANT_MAX_GDATE()
 returns date
 as begin
 return convert(date,'9999-12-31 00:00:00',dbo.BPM_CONSTANT_DATE_FMT())
 end;

 create function BPM_CONSTANT_MAX_DATE()
 returns date
 as begin
 return convert(date,'2077-07-07 00:00:00',dbo.BPM_CONSTANT_DATE_FMT())
 end;

 create function BPM_CONSTANT_LOG_LEVEL_SEVERE()
 returns varchar
 as begin
 return 'SEVERE'
 end;

 create function BPM_CONSTANT_LOG_LEVEL_WARNING()
 returns varchar
 as begin
 return 'WARNING'
 end;

 create function BPM_CONSTANT_LOG_LEVEL_INFO()
 returns varchar
 as begin
 return 'INFO'
 end;

 create function BPM_CONSTANT_LOG_LEVEL_CONFIG()
 returns varchar
 as begin
 return 'CONFIG'
 end;

 create function BPM_CONSTANT_LOG_LEVEL_FINE()
 returns varchar
 as begin
 return 'FINE'
 end;

 create function BPM_CONSTANT_LOG_LEVEL_FINER()
 returns varchar
 as begin
 return 'FINER'
 end;



 create function BPM_CONSTANT_LOG_LEVEL_FINEST()
 returns varchar
 as begin
 return 'FINEST'
 end;

   create function BPM_COMMON_GET_DATE_FMT() returns varchar
  as
  begin
    return dbo.BPM_CONSTANT_DATE_FMT();
  end;


  -- Get maximum date for BPM Event data.
  create function BPM_COMMON_GET_MAX_DATE() returns date
  as
  begin
    return dbo.BPM_COMMON_MAX_DATE();
  end;


  -- Get weekday.
  create function BPM_COMMON_GET_WEEKDAY
    (@p_start_date date, 
     @p_days2add integer) 
    returns date
  as
  begin
    return dbo.ETL_COMMON_GET_WEEKDAY(@p_start_date,@p_days2add);
  end;


  -- Get business date.
  create function BPM_COMMON_GET_BUS_DATE
    (@p_start_date date,
     @p_number_days integer)
    returns date
  as
  begin
    return dbo.ETL_COMMON_GET_BUS_DATE(@p_start_date,@p_number_days);
  end;

create procedure BPM_COMMON_VALIDATE_CREATE_COMPLETE_DATE
    (@p_create_date date,
     @p_complete_date date)
  as
  begin
    declare @v_procedure_name varchar(61) = OBJECT_NAME(@@PROCID) + '.' + 'VALIDATE_CREATE_COMPLETE_DATE',
    @v_log_message varchar = null,
    @v_days_in_future_allowed float = (1/24);

    if @p_complete_date is null or @p_create_date is null 
      return;
    if @p_create_date > getdate() + @v_days_in_future_allowed 
	begin
      select @v_log_message = 'Invalid create date.  ' + convert(varchar,@p_create_date,dbo.BPM_COMMON_DATE_FMT()) + ' is in the future.'; 
      RAISERROR (50061,@v_log_message,1,1);        
    end;
    if @p_complete_date <> dbo.BPM_COMMON_MAX_DATE() and @p_complete_date > getdate() + @v_days_in_future_allowed
	begin
      select @v_log_message = 'Invalid complete date.  ' + convert(varchar,@p_complete_date,dbo.BPM_COMMON_DATE_FMT()) + ' is in the future.';
      RAISERROR(50062,@v_log_message,1,1);        
    end;
    if @p_complete_date < @p_create_date
	begin
      select @v_log_message = 'Invalid date span.  Complete date ' + convert(varchar,@p_complete_date,dbo.BPM_COMMON_DATE_FMT()) + ' is before create date ' + convert(varchar,@p_create_date,dbo.BPM_COMMON_DATE_FMT()) + '.';
      RAISERROR(50063,@v_log_message,1,1);        
    end;
  end;


create procedure BPM_COMMON_VAL_CREATE_COMPL_DT
    (@p_create_date date,
     @p_complete_date date)
  as
  begin
    declare @v_procedure_name varchar(61) = OBJECT_NAME(@@PROCID) + '.' + 'VALIDATE_CREATE_COMPLETE_DATE',
    @v_log_message varchar = null,
    @v_days_in_future_allowed float = (1/24);

    if @p_complete_date is null or @p_create_date is null 
      return;
    if @p_create_date > getdate() + @v_days_in_future_allowed 
	begin
      select @v_log_message = 'Invalid create date.  ' + convert(varchar,@p_create_date,dbo.BPM_COMMON_DATE_FMT()) + ' is in the future.'; 
      RAISERROR (50061,@v_log_message,1,1);        
    end;
    if @p_complete_date <> dbo.BPM_COMMON_MAX_DATE() and @p_complete_date > getdate() + @v_days_in_future_allowed
	begin
      select @v_log_message = 'Invalid complete date.  ' + convert(varchar,@p_complete_date,dbo.BPM_COMMON_DATE_FMT()) + ' is in the future.';
      RAISERROR(50062,@v_log_message,1,1);        
    end;
    if @p_complete_date < @p_create_date
	begin
      select @v_log_message = 'Invalid date span.  Complete date ' + convert(varchar,@p_complete_date,dbo.BPM_COMMON_DATE_FMT()) + ' is before create date ' + convert(varchar,@p_create_date,dbo.BPM_COMMON_DATE_FMT()) + '.';
      RAISERROR(50063,@v_log_message,1,1);        
    end;
  end;

create procedure BPM_COMMON_WARN_CREATE_COMPL_DT
    (@p_create_date date,
     @p_complete_date date,
     @p_bsl_id integer,
     @p_bil_id integer,
     @p_identifier varchar)
  as
  begin
  declare @v_procedure_name varchar(61) = OBJECT_NAME(@@PROCID) + '.' + 'WARN_CREATE_COMPLETE_DATE',
    @v_log_message varchar = null,
    @v_sql_code integer = null;
    --begin try
    exec dbo.BPM_COMMON_VAL_CREATE_COMPL_DT(select @p_create_date,@p_complete_date);
    --end try
	--begin catch
     select @v_sql_code = 'SQLCODE';
      select @v_log_message = 'SQLERRM';
      if @v_sql_code in (-50061,-50062,-50063)
        exec dbo.BPM_COMMON_LOGGER(select dbo.BPM_COMMON_LOG_LEVEL_WARNING(),null,@v_procedure_name,@p_bsl_id,@p_bil_id,@p_identifier,null,@v_log_message,@v_sql_code);       
--      else
        RAISERROR(@v_sql_code,@v_log_message,1,1);
	--end catch
end;

  */
