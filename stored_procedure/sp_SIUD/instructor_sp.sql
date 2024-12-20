------------------------------------------------------------------------------------------------------------
---- instructor table

use Project_Exam;

create Procedure select_instructor  @id int
as
  
    if exists(select Ins_Id from Instructor where Ins_Id=@id)
   begin
   select * from Instructor 
   where Ins_Id=@id
   end
   else 
       select 'this instructor not exist'
  


execute  select_instructor 1

----------------------------------------------------------------------
create Procedure delete_instructor  @id int
as
   if exists(select Ins_Id from Instructor where Ins_Id=@id)
   begin
   delete from Instructor
   where Ins_Id=@id
   end
   else 
       select 'this instructor not exist'




execute  delete_instructor  5

-----------------------------------------------------------------------------

create PROCEDURE update_instructor 
    @id INT,  
    @col NVARCHAR(50), 
    @value NVARCHAR(50)
AS
BEGIN
    BEGIN TRY
        
        IF EXISTS (SELECT Ins_Id FROM Instructor WHERE Ins_Id = @id)
        BEGIN
            DECLARE @SQL NVARCHAR(MAX);
            SET @SQL = 'UPDATE instructor SET ' + QUOTENAME(@col) + ' = @value WHERE ins_id = @id';
            
            
            EXEC sp_executesql @SQL, 
                               N'@value NVARCHAR(50), @id INT', 
                               @value, 
                               @id;

            SELECT 'instructor record updated successfully.' AS Message;
        END
        ELSE 
        BEGIN
            SELECT 'Cannot modify! instructor ID not found.' AS Message;
        END
    END TRY
    BEGIN CATCH
        -- Handle errors
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END



execute  update_instructor  1, 'ins_fname','Hussien'
execute  update_instructor 1, 'salary','15000'
execute  update_instructor  1, 'dept_id','500' --error 

---------------------------------------------------------------------------

CREATE PROCEDURE insert_instructor
    @id INT,              
    @fname VARCHAR(20), 
	@lname VARCHAR(20),
    @mail VARCHAR(200),     
    @salary float,
	@dept_id int
  
AS

    BEGIN TRY
        INSERT INTO Instructor(Ins_Id,Ins_Fname,Ins_Lname,Ins_Email,Salary,Dept_Id)
        VALUES (@id, @fname, @lname, @mail,@salary,@dept_id);

        select 'instructor record inserted successfully.';
    END TRY
    BEGIN CATCH
        select 'Error occurred while inserting the instructor record.';
        select ERROR_MESSAGE();
    END CATCH


execute inserinsert_instructor 31,'sama','ibrahim','sklldwwfk@gmail.com',5000,1

