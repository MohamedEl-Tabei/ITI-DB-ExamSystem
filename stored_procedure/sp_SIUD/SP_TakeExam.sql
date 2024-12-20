

CREATE OR ALTER PROCEDURE SP_INSERT_TAKE_EXAM @E_ID INT , @ST_ID INT ,@Q_ID INT , @ANSWER VARCHAR(10)
AS
            BEGIN TRY
			         INSERT INTO Take_Exam (E_Id,St_Id,Q_Id,Answer)
				     VALUES (@E_ID,@ST_ID,@Q_ID,@ANSWER)
			END TRY
			BEGIN CATCH
			         SELECT 'Invalid_FK'
			END CATCH

		
		EXECUTE SP_INSERT_TAKE_EXAM 1,1,66,b

	-----------------------------------------

CREATE OR ALTER PROCEDURE SP_SELECT_TAKE_EXAM @ST_ID INT
AS
           IF EXISTS (SELECT St_Id FROM Take_Exam WHERE @ST_ID=St_Id)
		   SELECT S.Fname+' '+S.Lname AS Student_FullName, E.Exam_Name AS Exam_Name , Q.Tittle AS Question_Tittle , T.Answer AS Answer
		   FROM Exam E , Student S , Question Q , Take_Exam T 
		   WHERE S.St_Id=@ST_ID AND S.St_Id=T.St_Id AND E.Exam_Id=T.E_Id AND Q.Q_Id=T.Q_Id

		   ELSE
		         SELECT 'Invalid Student ID'


        EXECUTE SP_SELECT_TAKE_EXAM 1

		-----------------------------------------

CREATE OR ALTER PROCEDURE SP_DELETE_TAKE_EXAM @ST_ID INT
AS
        IF EXISTS (SELECT St_Id FROM Take_Exam WHERE St_Id=@ST_ID)
		DELETE FROM Take_Exam WHERE St_Id=@ST_ID

		ELSE
		SELECT 'Student Not Exist'

		
     EXECUTE SP_DELETE_TAKE_EXAM 16

	 -----------------------------------------

CREATE OR ALTER PROCEDURE SP_UPDATE_TAKE_EXAM @ST_ID INT ,  @COL VARCHAR(50) ,@VALUE NVARCHAR(50)
AS
         IF EXISTS (SELECT St_Id FROM Take_Exam WHERE St_Id=@ST_ID)
		 BEGIN
		 DECLARE @SQL NVARCHAR(MAX)
		 SET @SQL = 'UPDATE Take_Exam SET '+ QUOTENAME(@COL) + ' = @VALUE WHERE St_Id=@ST_ID';
		 EXEC sp_executesql @SQL ,  N'@VALUE NVARCHAR(50), @ST_ID INT' , @VALUE , @ST_ID;
		 SELECT 'Record Updated Successfully.' AS Message_
		 END
         
		 ELSE 
		 SELECT 'Invalid Student ID' AS Message_

      EXECUTE SP_UPDATE_TAKE_EXAM 16 , 'St_Id' , '15'


