# Stored Routines

# Stored Procedure
delimiter //
create procedure number_of_rows_proc (out param1 int)
begin
select COUNT(*) into param1 from bank.account;
end;
//
delimiter ;
 
call number_of_rows_proc(@x);
select @x;

# Stored Function
create
function print_function (x char(20))
returns char(50) deterministic
return concat('Iron', x, '!');
 
select print_function('hack');