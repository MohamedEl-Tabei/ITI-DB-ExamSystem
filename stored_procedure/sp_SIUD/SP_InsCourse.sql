

CREATE OR ALTER PROCEDURE SP_INSERT_INSCOURSE @CRS_ID INT , @INS_ID INT 
AS
            BEGIN TRY
			         INSERT INTO Ins_Course(Crs_Id,Ins_Id)
				     VALUES (@CRS_ID,@INS_ID)
			END TRY
			BEGIN CATCH
			         SELECT 'Invalid Data'
			END CATCH

		EXECUTE SP_INSERT_INSCOURSE 6 , 1 

	-----------------------------------------

CREATE OR ALTER PROCEDURE SP_SELECT_INSCOURSE @INS_ID INT
AS
          IF EXISTS (SELECT Ins_Id FROM Ins_Course WHERE Ins_Id=@INS_ID)
		  BEGIN
		  SELECT I.Ins_Fname+' '+I.Ins_Lname AS INS_Full_Name , C.Crs_Name
		  FROM Instructor I  , Ins_Course IC , Course C
		  WHERE I.Ins_Id=@INS_ID AND I.Ins_Id=IC.Ins_Id AND C.Crs_Id=IC.Crs_Id
		  END

		  ELSE
		       SELECT 'Invalid Instructor ID'

      EXECUTE SP_SELECT_INSCOURSE 1

	-----------------------------------------

CREATE OR ALTER PROCEDURE SP_DELETE_INSCOURSE @INS_ID INT
AS
        IF EXISTS (SELECT Ins_Id FROM Ins_Course WHERE Ins_Id=@INS_ID)
		DELETE FROM Ins_Course WHERE Ins_Id=@INS_ID

		ELSE
		SELECT 'Instructor Not Exist'

	EXECUTE SP_DELETE_INSCOURSE 10

	-----------------------------------------

CREATE OR ALTER PROCEDURE SP_UPDATE_INSCOURSE @INS_ID INT , @COL VARCHAR(50) , @VALUE NVARCHAR(50)
AS
       IF EXISTS (SELECT Ins_Id FROM Ins_Course WHERE Ins_Id=@INS_ID)
	   BEGIN
	   DECLARE @SQL NVARCHAR(MAX)
	   SET @SQL = 'UPDATE Ins_Course SET '+ QUOTENAME(@COL) + ' = @VALUE WHERE Ins_Id=@INS_ID';
	   EXEC sp_executesql @SQL ,  N'@VALUE NVARCHAR(50), @INS_ID INT' , @VALUE , @INS_ID;
	   SELECT 'Record Updated Successfully.' AS Message_
	   END
	   
	   ELSE
	   SELECT 'Invalid Instructor ID' AS Message_


	EXECUTE SP_UPDATE_INSCOURSE 27 , 'Crs_Id' , '10'

