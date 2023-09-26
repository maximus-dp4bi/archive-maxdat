if OBJECT_ID ('MAXDAT.ETL_COMMON_BUS_DAYS_BETWEEN','FN') is not null
begin
  drop function MAXDAT.ETL_COMMON_BUS_DAYS_BETWEEN;
end;
go

create function MAXDAT.ETL_COMMON_BUS_DAYS_BETWEEN
  (@p_start_date datetime,
   @p_end_date datetime)
  returns int
as
begin

  declare @v_num_days integer = 0;
  declare @v_from_date date = null;
  declare @v_to_date date = null; 
  
  set @v_from_date = convert(date,@p_start_date)
  set @v_to_date = convert(date,@p_end_date);

  with date_tab(business_date) as
    (select @v_from_date
	 union all
     select dateadd(day,1,date_tab.business_date) 
	 from date_tab 
	 where date_tab.business_date < @v_to_date)
  select  @v_num_days = count(business_date) - 1 
  from date_tab
  where
    datename(dw,business_date) not in ('Saturday','Sunday')
    and business_date not in 
      (select HOLIDAY_DATE 
       from MAXDAT.HOLIDAYS 
       where HOLIDAY_DATE between @v_from_date and @v_to_date);
  
  if @v_num_days < 0 
    begin
      set @v_num_days = 0;
	end;

  return @v_num_days;
end;
go

grant execute on MAXDAT.ETL_COMMON_BUS_DAYS_BETWEEN to MAXDAT_READ_ONLY;
go


/*
  create function GET_WEEKDAY
    (p_start_date in datetime, 
     p_days2add in number) 
    return datetime 
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


  create function BUS_DAYS_BETWEEN
    (@p_start_date datetime,
     @p_days2add integer)
    returns datetime
  as
  begin

  declare
    @v_counter      integer = 0,
    @v_curdate      datetime = @p_start_date,
    @v_daynum       integer,
    @v_skipcntr     integer = 0,
    @v_direction    integer = 1, -- days after start_date
    @v_businessdays integer = @p_days2add;


    if @p_days2add < 0
	  begin
        set @v_direction    = -1; -- days before start_date
        set @v_businessdays = (-1) * @v_businessdays;
      end;

    while @v_counter < @v_businessdays
	begin
      set @v_curdate = dateadd(d, @v_direction,@v_curdate);
      set @v_daynum = datepart(d,@v_curdate);
      if @v_daynum between 2 and 6
        set @v_counter = @v_counter + 1;
      else
        set @v_skipcntr = @v_skipcntr + 1;
    end;

    set @p_start_date= dateadd(d,(@v_direction * (@v_counter + @v_skipcntr)),@p_start_date);
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

create function ETL_COMMON_GET_INLIST_STR2
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


  create  function ETL_COMMON_GET_INLIST_STR3
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
 */