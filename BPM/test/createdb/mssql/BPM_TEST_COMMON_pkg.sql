-- Common BPM test data objects.


-- Generate test bit.
if OBJECT_ID ('MAXDAT.BPM_TEST_COMMON_GENERATE_BIT','FN') is not null
begin
  drop function MAXDAT.BPM_TEST_COMMON_GENERATE_BIT;
end;
go

create function MAXDAT.BPM_TEST_COMMON_GENERATE_BIT
  ()
  returns bit
as
begin

  declare @p_test_bit bit = null;

  declare @v_random_int int  = floor(3 * MAXDAT.BPM_TEST_COMMON_GET_RAND()) - 1;
  if @v_random_int in (0,1)
	begin
      set @p_test_bit = @v_random_int;
    end;
  else 
	begin
      set @p_test_bit = null;
    end;
  
  return @p_test_bit;

end;
go

grant execute on MAXDAT.BPM_TEST_COMMON_GENERATE_BIT to MAXDAT_READ_ONLY;
go


-- Generate varchar ID.
if OBJECT_ID ('MAXDAT.BPM_TEST_COMMON_GENERATE_VARCHAR_ID','FN') is not null
begin
  drop function MAXDAT.BPM_TEST_COMMON_GENERATE_VARCHAR_ID;
end;
go

create function MAXDAT.BPM_TEST_COMMON_GENERATE_VARCHAR_ID
  (@p_max_number_char int)
  returns varchar(MAX)
as
begin

  declare @v_character_set_size int = 62;
  declare @v_random_int int = null;
  declare @v_number_char int = ceiling(@p_max_number_char * MAXDAT.BPM_TEST_COMMON_GET_RAND());
  declare @v_character char = null;
  declare @p_test_varchar_id varchar(MAX) = '';

  declare @i int = 0;
  while @i <= @v_number_char
    begin

	  set @v_random_int = floor(@v_character_set_size * MAXDAT.BPM_TEST_COMMON_GET_RAND());
	  if @v_random_int >= 0 and @v_random_int <= 9
	    begin
	      set @v_character = char(ascii('0') + @v_random_int);
		end;
	  else if @v_random_int >= 10 and @v_random_int <= 35
	    begin
	      set @v_character = char(ascii('A') + (@v_random_int - 10));
		end;
	  else if @v_random_int >= 36 and @v_random_int <= 61
	    begin
	      set @v_character = char(ascii('a') + (@v_random_int - 36));
		end;

	  set @p_test_varchar_id = @p_test_varchar_id + @v_character;

	  set @i = @i + 1;

	end;
  
  return @p_test_varchar_id;

end;
go

grant execute on MAXDAT.BPM_TEST_COMMON_GENERATE_VARCHAR_ID to MAXDAT_READ_ONLY;
go


-- Calculates a random number.
-- Workaround for error: Invalid use of a side-effecting operator 'rand' within a function.
if OBJECT_ID ('MAXDAT.RAND_SV','V') is not null
begin
  drop view MAXDAT.RAND_SV;
end;
go

create view MAXDAT.RAND_SV as
select rand() as RAND;
go

grant select on MAXDAT.RAND_SV to MAXDAT_READ_ONLY;
go

-- Calculates a random float number.
-- Workaround for error: Invalid use of a side-effecting operator 'rand' within a function.
if OBJECT_ID ('MAXDAT.BPM_TEST_COMMON_GET_RAND','FN') IS NOT NULL
begin
  drop function MAXDAT.BPM_TEST_COMMON_GET_RAND;
end;
go

create function MAXDAT.BPM_TEST_COMMON_GET_RAND
  ()
  returns float
as
begin
  declare @p_random_number float = null;
  select @p_random_number = max(RAND) from MAXDAT.RAND_SV;
  return @p_random_number;
end;
go

grant execute on MAXDAT.BPM_TEST_COMMON_GET_RAND to MAXDAT_READ_ONLY;
go