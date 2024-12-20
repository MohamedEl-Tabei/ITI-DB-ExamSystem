------------------------------------------------------------------------------------------------------------
---- departement table

use Project_Exam;

alter Procedure select_departement  @id int
as
  
    if exists(select Dept_Id from Department where Dept_Id=@id)
   begin
   select * from Department 
   where Dept_Id=@id
   end
   else 
       select 'this departement not exist'
  


execute  select_departement 5

--------------------------------------------------------------------

create Procedure delete_departement  @id int
as
   if exists(select Dept_Id from Department where Dept_Id=@id)
   begin
   delete from Department
   where Dept_Id=@id
   end
   else 
       select 'this departement not exist'




execute  delete_departement  5

-------------------------------------------------------------------------
alter PROCEDURE update_departement  
    @id INT,  
    @col NVARCHAR(50), 
    @value NVARCHAR(50)
AS
BEGIN
    BEGIN TRY
        
        IF EXISTS (SELECT Dept_Id FROM Department WHERE Dept_Id = @id)
        BEGIN
            DECLARE @SQL NVARCHAR(MAX);
            SET @SQL = 'UPDATE department SET ' + QUOTENAME(@col) + ' = @value WHERE dept_id = @id';
            
            
            EXEC sp_executesql @SQL, 
                               N'@value NVARCHAR(50), @id INT', 
                               @value, 
                               @id;

            SELECT 'Department record updated successfully.' AS Message;
        END
        ELSE 
        BEGIN
            SELECT 'Cannot modify! Department ID not found.' AS Message;
        END
    END TRY
    BEGIN CATCH
        -- Handle errors
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END



execute  update_departement  1, 'dept_name','cs'
execute  update_departement  1, 'loc','ismailia'
execute  update_departement  1, 'ins_id','500'

------------------------------------------------------------------
CREATE PROCEDURE insert_department
    @dept_id INT,              
    @fname VARCHAR(50),     
    @location VARCHAR(50),     
    @instruc_id int      
  
AS

    BEGIN TRY
        INSERT INTO Department(Dept_Id,Dept_Name,Loc,Ins_Id)
        VALUES (@dept_id, @name, @location, @instruc_id);

        select 'departement record inserted successfully.';
    END TRY
    BEGIN CATCH
        select 'Error occurred while inserting the department record.';
        select ERROR_MESSAGE();
    END CATCH


execute insert_department 11,'cs','ismailia',1
-------------------------------------------------------------------------------
