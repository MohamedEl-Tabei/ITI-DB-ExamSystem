---------------------------------------------------
-----student table

use Project_Exam;

create Procedure select_student  @id int
as
  
    if exists(select st_id from student where st_id=@id)
   begin
   select * from Student 
   where st_id=@id
   end
   else 
       select 'this student not exist'
  


execute  select_student 5

----------------------------------------
create Procedure delete_student  @id int
as
   if exists(select st_id from student where st_id=@id)
   begin
   delete from student
   where st_id=@id
   end
   else 
       select 'this student not exist'


execute  select_student 5

----------------------------------------------
alter Procedure update_student  @id int  ,  @col varchar(50) ,@value varchar(50)
as
  if exists(select st_id from student where st_id=@id)
  begin
    DECLARE @SQL  NVARCHAR(MAX);
	 SET @SQL = 'UPDATE Student SET ' + QUOTENAME(@col) + ' = @value WHERE st_id = @id';
     EXEC sp_executesql @SQL, N'@value NVARCHAR(50), @id INT', @value, @id;

	 select 'Record updated successfully.'
  end
  else 
    select 'can not modify !!!'


execute  update_student  1, 'fname','sama'

----------------------------------------------------------

CREATE PROCEDURE insert_student
    @st_id INT,              
    @fname VARCHAR(50),     
    @lname VARCHAR(50),     
    @city VARCHAR(50),      
    @street VARCHAR(50),    
    @phone VARCHAR(15),     
    @password VARCHAR(50),  
    @email VARCHAR(200)  , 
	@gender VARCHAR(1)
AS

    BEGIN TRY
        INSERT INTO Student (st_id, fname, lname, city, street, phone, Pasword, St_Email,gender)
        VALUES (@st_id, @fname, @lname, @city, @street, @phone, @password, @email,@gender);

        select 'Student record inserted successfully.';
    END TRY
    BEGIN CATCH
        select 'Error occurred while inserting the student record.';
        select ERROR_MESSAGE();
    END CATCH

------------------------------------------------------------------------------------------------------------


