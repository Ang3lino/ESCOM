
-- mysql -u root -p --disable-auto-rehash --auto-vertical-output
-- mysql -u root -p --auto-vertical-output


-- load database
drop database if exists dbname;
create database dbname;
use elektra;
source dbname.sql ;
use dbname;

-- view
drop view if exists v;
create view v as 
  select * from t;

-- procedure

drop procedure if exists p;
delimiter $
create procedure p ([ [in|out] arg1 type, ..., [in|out] argn type])
begin
  -- procedure body
end $
delimiter ;

show procedure status where db = 'dbname';
show create procedure;

-- DECLARE s VARCHAR(50) DEFAULT(CONCAT("%", p_ap, "%") );


-- trigger
drop trigger if exists t;
delimiter $
create trigger t 
  trigger_time trigger_event on table_name for each row 
  begin 
  -- stuff
end $
delimiter ;

show triggers;