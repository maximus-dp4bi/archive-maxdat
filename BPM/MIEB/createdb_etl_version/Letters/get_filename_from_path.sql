CREATE or REPLACE function get_filename_from_path
   (p_path IN VARCHAR2)
   RETURN varchar2

IS
   v_file VARCHAR2(300);

BEGIN

   -- Parse string for UNIX system
   IF INSTR(p_path,'/') > 0 THEN
      v_file := SUBSTR(p_path,(INSTR(p_path,'/',-1,1)+1),length(p_path));

   -- Parse string for Windows system
   ELSIF INSTR(p_path,'\') > 0 THEN
      v_file := SUBSTR(p_path,(INSTR(p_path,'\',-1,1)+1),length(p_path));

   -- If no slashes were found, return the original string
   ELSE
      v_file := p_path;

   END IF;

   RETURN v_file;

END get_filename_from_path;