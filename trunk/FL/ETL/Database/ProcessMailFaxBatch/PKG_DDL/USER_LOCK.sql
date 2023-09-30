CREATE OR REPLACE package user_lock is

  --  DESCRIPTION
  --    These routines allow the user to request, convert and release locks.
  --    The locks are managed by the rdbms lock management services.  All
  --    lock ids are prepended with the 'UL' prefix so that they cannot
  --    conflict with DBMS locks.  A sleep procedure is also provided which
  --    causes the caller to sleep for the given interval (expressed in
  --    tens of milliseconds.
  --
  --  NOTES
  --    It is up to the clients to agree on the use of these locks.  The lock
  --    identifier is a number in the range of 1 to approx. 2 billion.  
  --    Locks persist for the session and any outstanding locks are released
  --    when the session terminates.

  function  request(id number, lockmode number, timeout number, global number)
            return number;
  -- Returns:
  --    0 success
  --    1 timeout
  --    2 deadlock
  --    3 parameter error

  function convert(id number, lockmode number, timeout number) return number;
  -- Returns:
  --    0 success
  --    1 timeout
  --    2 deadlock
  --    3 parameter error
  --    4 don't own lock 'id'

  function release(id number) return number;
  -- Returns:
  --    0 success
  --    4 don't own lock 'id'

  procedure sleep(tens_of_millisecs number);

  -- PARAMETERS:

  -- lockid - this can be in the range of 0 to about 2 billion

  -- lockmodes
  nl_mode  constant number := 1;
  ss_mode  constant number := 2;
  sx_mode  constant number := 3;
  s_mode   constant number := 4;
  ssx_mode constant number := 5;
  x_mode   constant number := 6;

  --  LOCK COMPATIBILITY RULES:
  --
  --  When another process holds "held", an attempt to get "get" does
  --  the following:
  --
  --  held  get->  NL   SS   SX   S    SSX  X
  --  NL           SUCC SUCC SUCC SUCC SUCC SUCC
  --  SS           SUCC SUCC SUCC SUCC SUCC fail
  --  SX           SUCC SUCC SUCC fail fail fail
  --  S            SUCC SUCC fail SUCC fail fail
  --  SSX          SUCC SUCC fail fail fail fail
  --  X            SUCC fail fail fail fail fail

  -- global means multi-instance (parallel server)
  local    constant number := 0;
  global   constant number := 1;

  -- maxwait means wait forever
  maxwait  constant number := 32767;
end;
/


CREATE OR REPLACE package body user_lock is

  procedure psdlgt(id binary_integer, lockmode binary_integer, 
                   maxholders binary_integer, timeout binary_integer, 
                   rel_on_commit binary_integer, global binary_integer,
                   status in out binary_integer);
    pragma interface (C, psdlgt);
  procedure psdlcv(id binary_integer, lockmode binary_integer,
	  	   maxholders binary_integer, timeout binary_integer,
		   status in out binary_integer);
    pragma interface (C, psdlcv);
  procedure psdlrl(id binary_integer, status in out binary_integer);
    pragma interface (C, psdlrl);
  procedure psdwat(tens_of_millisecs binary_integer);
    pragma interface (C, psdwat);

  function  request(id number, lockmode number, timeout number, global number)
	    return number is
  arg1    binary_integer;
  arg2    binary_integer;
  arg3    binary_integer;
  arg4    binary_integer;
  arg5    binary_integer;
  status  binary_integer;
  begin
    arg1 := id;
    arg2 := lockmode;
    arg3 := 0;
    arg4 := timeout;
    arg5 := global;
    /* this package does not support release_on_commit - so just enter 0 */
    psdlgt(arg1, arg2, arg3, arg4, 0, arg5, status);
    return(status);
  end;

  function convert(id number, lockmode number, timeout number) return number is
    arg1   binary_integer;
    arg2   binary_integer;
    arg3   binary_integer;
    arg4   binary_integer;
    status binary_integer;
  begin
    arg1 := id;
    arg2 := lockmode;
    arg3 := 0;
    arg4 := timeout;
    psdlcv(arg1, arg2, arg3, arg4, status);
    return (status);
  end;

  function release(id number) return number is
    arg1   binary_integer;
    status binary_integer;
  begin
    arg1 := id;
    psdlrl(arg1, status);
    return (status);
  end;

  procedure sleep(tens_of_millisecs number) is
    arg1   binary_integer;
  begin
    arg1 := tens_of_millisecs;
    psdwat(arg1);
  end;

end;
/
