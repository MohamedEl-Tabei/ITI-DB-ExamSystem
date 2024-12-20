--Stored procedure to insert new topic take two parameter topic name and course id if error occurred it will be catched and display message 
CREATE PROCEDURE SP_INSERT_TOPIC @TN VARCHAR(20),@CID INT
AS 
	BEGIN TRY
		INSERT INTO Topic
		VALUES((SELECT MAX(T_Id) FROM Topic)+1,@TN,@CID)
	END TRY
	BEGIN CATCH
		SELECT 'Invalid course id'
	END CATCH
-----------------------------------
EXECUTE SP_INSERT_TOPIC 'ABC3',10
------------------------------------


--Stored procedure select topic by id take one parameter topic id
CREATE PROCEDURE SP_SELECT_TOPIC @ID INT
AS
	IF EXISTS(SELECT T_Id FROM Topic WHERE T_Id=@ID)
		SELECT * 
		FROM Topic 
		WHERE T_Id=@ID
	ELSE
		SELECT 'Invalid topic id'
---------------------------
EXECUTE SP_SELECT_TOPIC 8
---------------------------


--Stored procedure to delete topic by id take one parameter topic id 
CREATE PROCEDURE SP_DELETE_TOPIC  @ID INT
AS	
	IF EXISTS( SELECT T_Id FROM Topic WHERE T_Id=@ID)
		DELETE FROM Topic
		WHERE T_Id=@ID
	ELSE
		SELECT 'Invalid topic id'
---------------------------
EXECUTE SP_DELETE_TOPIC 82
---------------------------


--Stored procedure to update topic name or course id take three parameters column name, topic id and new data  
CREATE PROCEDURE SP_UPDATE_TOPIC @CN VARCHAR(20), @ND VARCHAR(20), @ID INT
AS
	BEGIN TRY
		IF EXISTS(SELECT T_Id FROM Topic WHERE T_Id=@ID)
		BEGIN
			DECLARE @SQLSTATEMENT NVARCHAR(MAX)='UPDATE Topic SET '+QUOTENAME(@CN)+' = @ND WHERE T_Id=@ID' 
			EXECUTE SP_EXECUTESQL @SQLSTATEMENT,
			N'@CN VARCHAR(20), @ND VARCHAR(20) ,@ID INT',
			@CN, @ND,@ID
		END
		ELSE
			SELECT 'Invalid topic id'
	END TRY
	BEGIN CATCH 
		SELECT 'Invalild course id'
	END CATCH



--------------------------------------
EXECUTE SP_UPDATE_TOPIC 'Crs_Id',7,8
--------------------------------------