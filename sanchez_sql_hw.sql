-- 1. SQL Queries
-- 1.1 SELECT
-- Select the employeeId, last name, and email for records in the Employee table where last name is King.
	select "EmployeeId" , "LastName" , "Email" 
	from "Employee" e where e."LastName" = 'King';

-- Select the city and state for the records in the Employee table where first name is Andrew and REPORTSTO is NULL.
	select "City", "State" from "Employee" e 
	where e."FirstName" = 'Andrew' and e."ReportsTo" is null;

-- 1.2 Sub- queries (Select in a Select)
-- Select all records from the Album table where the composer is AC/DC.
	select * from "Album" a1
	where "ArtistId" in (
		select "ArtistId" from "Artist" a2
		where a2."Name" = 'AC/DC'
	); 
--other way
	select a3.* from "Artist" a2 
	inner join "Album" a3 ON a2."ArtistId" = a3."ArtistId" 
	where a2."Name" = 'AC/DC';

-- 1.3 ORDER BY
-- Select all albums in Album table and sort result set in descending order by title.
	select a."Title" from "Album" a 
	order by a."Title" desc;

-- Select first name from Customer and sort result set in ascending order by city.
	select c."FirstName" from "Customer" c
	order by c."City" asc;
	
-- 1.6 LIKE
-- Select all invoices with a billing address like “T%”.
	select * from "Invoice" i
	where "BillingAddress" like 'T%';

-- 1.7 BETWEEN
-- Select all invoices that have a total between 15 and 50.
	select * from "Invoice" i inner join "InvoiceLine" il
	ON i."InvoiceId" = il."InvoiceLineId" 
	where "Total" between 15 and 50;

-- Select all employees hired between 1st of June 2003 and 1st of March 2004.
	select * from "Employee" e 
	where "HireDate" between '2003-06-01' and '2004-03-01';

-- 2. DML Statements
-- 2.1 INSERT INTO
-- Insert two complete new records into Genre table. 
	insert into "Genre" 
	values (26, 'Neoclasic Metal');

-- Insert two complete new records into Employee table.
	insert into "Employee" 
	values (9, 'Sanchez', 'Gabriela', 'Software Engineer', 6, '1984-05-09', '2020-08-17',
	'16257 Enclave Village Dr', 'Tampa', 'Fl', 'USA', '33547', '+1 (863) 738-329', '+1 (863) 738-3329', 'gabskatzedev@gmail.com');
	
	insert into "Employee"
	values (10, 'Rudin', 'Juan Carlos', 'Software Engineer', 6, '1984-09-26', '2020-08-17',
	'16257 Enclave Village Dr', 'Tampa', 'Fl', 'USA', '33547', '+1 (863) 738-328', '+1 (863) 738-3239', 'juancrud@gmail.com');

-- Insert two complete new records into Customer table.
	insert into "Customer" 
	values (60, 'Jules', 'Richardson', 'Revature', '3659 Victoria Manor Dr', 'Lakeland', 'Fl', 'USA', '33567', '+1 (863) 738-325',
	'+1 (863) 738-3283', 'email@email.com', 5);
	
	insert into "Customer"
	values (61, 'Valery', 'Ximai', 'Revature', '3421 Victoria Manor Dr', 'Temple Terrace', 'Fl', 'USA', '33454', '+1 (863) 564-3125',
	'+1 (863) 324-3283', 'vximai@email.com', 5);

-- 2.2 UPDATE
-- Update Aaron Mitchell in Customer table to Robert Walter.
	update "Customer"
	set "LastName" = 'Walter', "FirstName" = 'Robert'
	where "CustomerId" = 32;

-- Update name of artist in the Artist table “Creedence Clearwater Revival” to “CCR”.
	update "Artist"
	set "Name" = 'CCR'
	where "ArtistId" = 76;

-- DELETE
-- Delete a record in Customer table where the name is Robert Walter (There may be constraints that rely on this,
-- (find out how to resolve them).

	delete from "InvoiceLine" il
	where il."InvoiceId" in (
		select i2."InvoiceId" from "Invoice" i2 
		where i2."CustomerId" in (
			select c."CustomerId" from "Customer" c
			where c."FirstName" = 'Robert' and c."LastName" = 'Walter'
		)
	);
	
	delete from "Invoice" i2 
	where i2."CustomerId" in (
		select c."CustomerId" from "Customer" c
		where c."FirstName" = 'Robert' and c."LastName" = 'Walter'
	);

	delete from "Customer" c
	where c."FirstName" = 'Robert' and c."LastName" = 'Walter';

-- 3. SQL Functions
-- 3.1 System Defined Functions
-- Create a query that returns the current time.
	CREATE or replace FUNCTION curt_time(out myTime time with time zone)
    AS 
    $$ 
    SELECT current_time 
    $$
    LANGUAGE SQL;

	SELECT * FROM curt_time();

-- Create a query that returns the length of name in MEDIATYPE table
	create or replace function lng_name()
		returns table(_lenght integer)
		as $$
		   declare
			begin
				return query
				select length(mt."Name") from "MediaType" mt;
			end;
		$$ language plpgsql;
	
	select * from lng_name();

-- 3.2 System Defined Aggregate Functions
-- Create a function that returns the average total of all invoices 
		create or replace function avg_total_fn()
		returns table(avg_total decimal)
		as $$
		   declare
			begin
				return query
					select avg("Total") from "Invoice" i ;
			end;
		$$ language plpgsql;
	
		select * from avg_total_fn();
-- Create a function that returns the most expensive track
	create or replace function max_unit_price_fn()
		returns table(max_unit_price numeric)
		as $$
		   declare
			begin
				return query
					select max("UnitPrice") from "Track" t;
			end;
		$$ language plpgsql;
	
	select * from avg_total_fn();

-- 3.3 User Defined Functions
-- Create a function that returns the average price of invoiceline items in the invoiceline table.
	create or replace function avg_unit_price_fn()
		returns table(avg_unit_price numeric)
		as $$
		   declare
			begin
				return query
					select avg("UnitPrice") from "InvoiceLine" il;
			end;
		$$ language plpgsql;
	
	select * from avg_unit_price_fn();

-- Create a function that returns all employees who are born after 1968.
	create or replace function born_after_fn()
		returns table(_firstName varchar, _lastName varchar, _birthdate timestamp)
		as $$
		   declare
			begin
				return query
				select e2."FirstName", e2."LastName", e2."BirthDate" from "Employee" e2
				where "BirthDate" >  '1968-12-31';
			end;
		$$ language plpgsql;
	
	select * from born_after_fn();

-- 4. Triggers
-- 4.1 After Insert Trigger
-- Create an after insert trigger on the employee table fired after a new record is inserted into the table to set 
-- the phone number to 867-5309.
	create or replace function insert_Trig()
	returns trigger as $$
    begin
        if(TG_OP = 'INSERT') then
        update "Employee"
        set "Phone" = '867-5309' where new."EmployeeId" = "Employee"."EmployeeId" ;
        end if;
        return new;
    end;
    $$ language plpgsql;

		DROP TRIGGER if exists empl_Phone_Trigger ON "Employee";
		create trigger empl_Phone_Trigger
		after insert on "Employee"
		for each row
		execute function insert_Trig();
	
insert into "Employee"
	values (32, 'Jim', 'Bob', 'Housekeeper', 6, '1934-09-26', '2020-08-17',
	'16257 Enclave Dr', 'Manhathan', 'Fl', 'USA', '33547', '+1 (863) 738-328', '+1 (863) 738-3239', 'e@gmail.com');
	
select * from "Employee" e2 
----------------------------------------------------

-- 4.2 Before Insert Trigger
-- Create a before trigger on the customer table that fires before a row is inserted from the table to set the company to Revature.
	create or replace function insert_Trig_Bef()
	returns trigger as $$
    begin
		new."Company" := 'Revature';        
        return new;
    end;
    $$ language plpgsql;
   
	DROP TRIGGER if exists insert_Trig_Bef ON "Customer";
	create trigger insert_Trig_Bef
	before insert on "Customer"
	for each row
	execute function insert_Trig_Bef();
   
   select * from "Customer" c; 
  
  	insert into "Customer" 
	values (71, 'olivia1', 'boo', 'hey', '3659 Victoria Manor Dr', 'Lakeland', 'Fl', 'USA', '33567', '+1 (863) 738-325',
	'+1 (863) 738-3283', 'email@email.com', 5);
-- 5. Joins
-- 5.1 INNER
-- Create an inner join that joins customers and orders and specifies the name of the customer and the invoiceId.
	select c2."FirstName", c2."LastName", i."InvoiceId" from "Customer" c2
	inner join "Invoice" i on c2."CustomerId" = i."CustomerId"; 

-- 5.2 FULL OUTER
-- Create an outer join that joins the customer and invoice table, specifying the CustomerId, firstname, lastname, invoiceId, and total.
	select c2."CustomerId", c2."FirstName", c2."LastName", i2."InvoiceId", i2."Total" from "Customer" c2
	full outer join "Invoice" i2 
	on c2."CustomerId"  = i2."CustomerId"; 

-- 5.3 RIGHT
-- Create a right join that joins album and artist specifying artist name and title.
	select * from "Album" a2 
	right join "Artist" a3 
	on a2."ArtistId" = a3."ArtistId";

-- 5.4 CROSS
-- Create a cross join that joins album and artist and sorts by artist name in ascending order.
	select * from "Artist" a2
	cross join "Album" a3
	where a2."ArtistId"  = a3."ArtistId"
	order by "Name" asc;

-- 5.5 SELF
-- Perform a self-join on the employee table, joining on the reportsto column.
	select * from "Employee" e2, "Employee" e 
	where e2."ReportsTo" <> e."ReportsTo";

-- 6. Set Operations
-- 6.1 Union
-- Create a UNION query for finding the unique records of last name, first name, and phone number for all customers and employees.
	select e2."FirstName", e2."LastName", e2."Phone" from "Employee" e2
	union
	select e2."FirstName", e2."LastName", e2."Phone" from "Employee" e2;
	
-- 6.2 Except All
-- Create an EXCEPT ALL query for finding the all records of the city, state, and postal codes for all customers 
-- and all records of employees that have a different  city, state, and postal codes of any customer.
	select c."City", c."State", c."PostalCode" from "Customer" c 
	except all
	select e."City", e."State", e."PostalCode" from "Employee" e;



