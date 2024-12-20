------------------------------------------------------------------------------------------------------------
---- exam table

use Project_Exam;

create Procedure select_exam  @id int
as
  
    if exists(select Exam_Id from Exam where Exam_Id=@id)
   begin
   select * from Exam 
   where Exam_Id=@id
   end
   else 
       select 'this exam not exist'
  


execute  select_exam 5

----------------------------------------------------------------
create Procedure delete_exam  @id int
as
   if exists(select Exam_Id from Exam where Exam_Id=@id)
   begin
   delete from Exam
   where Exam_Id=@id
   end
   else 
       select 'this exam not exist'




execute  delete_exam  5

---------------------------------------------------------------------------
create PROCEDURE update_exam  
    @id INT,  
    @col NVARCHAR(50), 
    @value NVARCHAR(50)
AS
BEGIN
    BEGIN TRY
        
        IF EXISTS (SELECT Exam_Id FROM Exam WHERE Exam_Id = @id)
        BEGIN
            DECLARE @SQL NVARCHAR(MAX);
            SET @SQL = 'UPDATE exam SET ' + QUOTENAME(@col) + ' = @value WHERE exam_id = @id';
            
            
            EXEC sp_executesql @SQL, 
                               N'@value NVARCHAR(50), @id INT', 
                               @value, 
                               @id;

            SELECT 'exam record updated successfully.' AS Message;
        END
        ELSE 
        BEGIN
            SELECT 'Cannot modify! exam ID not found.' AS Message;
        END
    END TRY
    BEGIN CATCH
        -- Handle errors
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END



execute  update_exam  1, 'exam_name','css'
execute  update_exam  1, 'time','70'

---------------------------------------------------------------------------

CREATE PROCEDURE insert_exam
    @ex_id INT,              
    @name VARCHAR(50),     
    @Time int,     
    @crs_id int      
  
AS

    BEGIN TRY
        INSERT INTO Exam(Exam_Id,Exam_Name,Time,Crs_Id)
        VALUES (@ex_id, @name, @Time, @crs_id);

        select 'exam record inserted successfully.';
    END TRY
    BEGIN CATCH
        select 'Error occurred while inserting the exam record.';
        select ERROR_MESSAGE();
    END CATCH


execute insert_exam  21,'bbbbb',50,500
