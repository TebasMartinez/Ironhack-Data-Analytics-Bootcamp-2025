-- Intro to Stored Routines
-- A stored routine is either a procedure or a function that can be stored in the server.
-- differences between function and procedure: https://bestinterviewquestion.medium.com/difference-between-stored-procedure-and-function-in-mysql-52f845d70b05
-- functions are for smaller tasks and calculations, procedures are for more complex business logic.

-- Stored Function
create function print_function (param1 char(20))
returns char(50) deterministic
return concat('Feli', param1, '!');

select print_function('pe');


create function multiplier (x int)
returns int deterministic
return (select COUNT(*) from bank.account) * x;

select multiplier(2);

create function multiplier_table (x int)
returns int deterministic
return (select count(*) * x, max(district_id) from bank.account); -- doesn't work, you can return just one value

select multiplier_table(2);

-- "deterministic" if it always produces the same result with same input parameters,
-- and "not deterministic" otherwise. Default is "not deterministic".
-- not deterministic: value that might change between calls, rand(), curdate()

-- Stored Procedure
-- may take "in" and/or "out" parameters:
DELIMITER //
create procedure number_of_rows_proc(in x int, out param1 int)
begin
select count(*) * x into param1 from bank.account;
end //
DELIMITER ;

call number_of_rows_proc(2, @_variable_name);
select @_variable_name;


DELIMITER //
create procedure n_movies_2006(out param1 int)
begin

select count(*) into param1
from sakila.film
where release_year = 2006;

end //
DELIMITER ;

call n_movies_2006(@movie_count);
select @movie_count;

-- Allow to select different years: 
DELIMITER //
create procedure n_movies_year(in x int, out param1 int)
begin

select count(*) into param1
from sakila.film
where release_year = x;

end //
DELIMITER ;

call n_movies_year(2006, @movie_count);
select @movie_count;


-- Now let's say your manager wants to keep track of the customers with status "B",
-- the ones where the contract finished but the loan amount was not paid.

-- getting the customers
use bank;

DELIMITER //
create procedure return_query_rows_proc()
begin

  select *
  from bank.loan
  where status = "B";
  
end //
DELIMITER ;

call return_query_rows_proc();

-- getting the avg amount owed
DELIMITER //
create procedure average_loss_proc (out param1 float)
begin

	select (sum(amount) - sum(payments))/count(*) into param1
	from bank.loan
	where status = "B";  -- COLLATE utf8mb4_general_ci   -- COLLATE is to solve an error I get if I don't use it 
    
    select param1;
    
end //
DELIMITER ;

call average_loss_proc(@x);
select round(@x, 2) as Average_loss_per_customer;

drop procedure if exists average_loss_proc;

-- Defining variables:
 -- declare the variable or use the OUT param
DELIMITER //
create procedure average_loss_proc ()
begin

	declare avg_loss float; -- default 0.0;
    
	select (sum(amount) - sum(payments))/count(*) into avg_loss
	from bank.loan
	where status = "B";
    
    select avg_loss;
    
end //
DELIMITER ;

call average_loss_proc();


drop procedure if exists average_loss_proc;

-- IN parameter: get the average owed by chosen status
delimiter //
create procedure average_loss_proc (in param varchar(10))
begin

	declare avg_loss float; -- declare the variable or use the OUT param
    
	select round((sum(amount) - sum(payments))/count(*), 2) into avg_loss
	from bank.loan
	where status COLLATE utf8mb4_general_ci = param;  -- COLLATE utf8mb4_general_ci   -- COLLATE is to solve an error
    
	select avg_loss;
    
end;
//
delimiter ;

call average_loss_proc("A");

drop procedure if exists average_loss_status_regiom_proc;

-- besides the status, also consider the region:
-- step 1: first create your query with dummy values for status and region
select round((sum(amount) - sum(payments))/count(*), 2)
from (
  select a.account_id, d.A2 as district, d.A3 as region, l.amount, l.payments, l.status
  from bank.account a
  join bank.district d
  on a.district_id = d.A1
  join bank.loan l
  on l.account_id = a.account_id
  where l.status = "B" and d.A3 = 'Prague'
) sub1;

-- step 2: put it inside the procedure and adjust the parameters
delimiter //
create procedure average_loss_status_regiom_proc (in param1 varchar(10), in param2 varchar(100))
begin

  declare avg_loss_region float default 0.0;
  
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
  
  select avg_loss_region;
  
end;
//
delimiter ;

call average_loss_status_regiom_proc("B", "Prague");

-- More 
show procedure status;
show function status;
show procedure status where Db = 'bank';
