-- Stored Procedures Platinum Plus Max Pro

-- Conditional Statements

-- Similar to the procedure we created last class, we will be calculating the average loss of the unpaid loans
-- by status and region, returning also the 'group' in which it belong according to the average resulted (green, yellow, red)

DELIMITER //
create procedure average_loss_status_region_proc (in param1 varchar(10), in param2 varchar(100), out param3 varchar(20), out param4 int)
begin

  declare zone varchar(20) default "";

  select round((sum(amount) - sum(payments))/count(*), 2) into param4
  from (
    select a.account_id, d.A2 as district, d.A3 as region, l.amount, l.payments, l.status
    from bank.account a
    join bank.district d
    on a.district_id = d.A1
    join bank.loan l
    on l.account_id = a.account_id
    where l.status COLLATE utf8mb4_general_ci = param1 -- COLLATE is necessary here to fix a string encoding error
    and d.A3 COLLATE utf8mb4_general_ci = param2
  ) sub1;

  if param4 > 70000 then
    set zone = 'Red Zone';
  elseif param4 between 40000 and 70000 then -- <= 70000 and param4 > 40000 then
    set zone = 'Yellow Zone';
  else
    set zone = 'Green Zone';
  end if;

  set param3 = zone; -- select zone into param3;
  
  select concat("Zone: ", param3, " | Average Loss: ", param4); -- this is just like a print() inside a python function
  
end //
DELIMITER ;

call average_loss_status_region_proc("B", "Prague", @zone, @average);
select @zone, @average;

drop procedure if exists average_loss_status_region_proc;

-- Case Statement

delimiter //
create procedure average_loss_status_region_proc (in param1 varchar(10), in param2 varchar(100), out param3 varchar(20))
begin

  declare avg_loss_region float default 0.0;
  
  declare zone varchar(20) default "";
  
  select round((sum(amount) - sum(payments))/count(*), 2) into avg_loss_region
  from (
    select a.account_id, d.A2 as district, d.A3 as region, l.amount, l.payments, l.status
    from bank.account a
    join bank.district d
    on a.district_id = d.A1
    join bank.loan l
    on l.account_id = a.account_id
    where l.status COLLATE utf8mb4_general_ci = param1
    and d.A3 COLLATE utf8mb4_general_ci = param2
  ) sub1;

  select avg_loss_region; -- just displaying value, similar to print() in python
 
  case
    when avg_loss_region > 50000 then
      set zone = 'PLATINUM';
    when avg_loss_region <= 50000 AND avg_loss_region > 10000 then
      set zone = 'GOLD';
  else
    set zone = 'SILVER';
  end case;

  select zone into param3;

end;
//
delimiter ;

call average_loss_status_region_proc("A", "Prague", @x);
select @x;

-- IF/ELSE vs CASE WHEN: https://www.mysqltutorial.org/mysql-case-statement/

-- Exceptions Handling
select * from account;

drop procedure if exists update_account_table;

DELIMITER //
create procedure update_account_table (in param1 int, in param2 int, in param3 varchar(100), in param4 int)
begin
  
  declare HasError char(100) default 'Table updated!';
  -- declare continue handler for 1000 set HasError = 'This account already exists in the database'; -- sqlstate 23000
  declare exit handler for sqlexception select 'This account already exists in the database'; 
  
  insert into bank.account values(param1, param2, param3, param4);
  
  select HasError;
  
end //
DELIMITER ;

call update_account_table(100001, 2, "freq", 31);

/*
Template for exceptions:
declare ACTION handler for EXCEPTION_TYPE ...;

ACTION:
	continue (continues with the code, raises sql error if it isn't possible to continue the code)
    exit (does not continue, raises your error message)
    
EXCEPTION_TYPE: <the error code>, sqlstate "<state code>", sqlwarning, not found, sqlexception

More error messages: https://dev.mysql.com/doc/refman/8.0/en/error-handling.html
*/