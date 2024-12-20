--Stored procedure to insert new question take 4 parameters title, answer, type and grade
CREATE PROCEDURE SP_INSERT_QUESTION @T VARCHAR(100), @ANS VARCHAR(20) , @TP VARCHAR(20) , @G INT
AS
		BEGIN TRY
			IF (@ANS NOT IN ('True','False') AND @TP='MCQ' ) OR  (@ANS IN ('True','False') AND @TP='T&F')
				INSERT INTO Question (Tittle,Answer,Type,Grade)
				VALUES(@T,@ANS,@TP,@G)
			ELSE
				SELECT'The answer of T&F question type must be True or False || MCQ must not be True or False'
		END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE()
		END CATCH
---------------------------------------------------------------
EXECUTE SP_INSERT_QUESTION 'What is your name?','A','MCQ',10
---------------------------------------------------------------

--Stored procedure to select question by id take one parameter question id
CREATE PROCEDURE SP_SELECT_QUESTION @ID INT
AS
	IF EXISTS(SELECT Q_Id FROM Question WHERE Q_Id=@ID)
		SELECT * 
		FROM Question
		WHERE Q_Id=@ID
	ELSE
		SELECT'Invalid question id'
--------------------------------
EXECUTE SP_SELECT_QUESTION 100
--------------------------------


--Stored procedure to delete question take one parameter question id .it delete qustion id from take exam , question choicr and exam question to avoid conflict error
CREATE PROCEDURE SP_DELETE_QUESTION @ID INT
AS 
	IF EXISTS(SELECT Q_Id FROM Question WHERE @ID=Q_Id)
	BEGIN
		delete from Ques_Choice
		where Q_Id=@ID
		delete from Take_Exam
		where Q_Id=@ID
		delete from Exam_Question
		where Q_Id=@ID
		delete from Question
		where Q_Id=@ID
	END
	ELSE
		SELECT'Invalid question id'

-----------------------------
EXECUTE SP_DELETE_QUESTION 106
-----------------------------


--Stored procedure to update question take 4 parameters	question id, type of question, column name(Grade,Title,Answer) and new data
CREATE PROCEDURE SP_UPDATE_QUESTION @ID INT, @TP VARCHAR(3), @CN VARCHAR(20), @ND VARCHAR(100)
AS
	BEGIN TRY
		IF @CN IN ('Answer','Grade','Tittle')
			IF (@CN='Answer'AND((@ND NOT IN ('True','False') AND @TP='MCQ' ) OR  (@ND IN ('True','False') AND @TP='T&F'))) OR @CN='Tittle' OR @CN='Grade'
			BEGIN
				DECLARE @SQLSTATEMENT NVARCHAR(MAX)='UPDATE Question SET '+QUOTENAME(@CN)+' = @ND , Type = @TP WHERE Q_Id=@ID'
				EXECUTE SP_EXECUTESQL @SQLSTATEMENT,
				N'@ID INT, @TP VARCHAR(3), @CN VARCHAR(20), @ND VARCHAR(100)',
				@ID , @TP , @CN , @ND
			END
			ELSE
				SELECT'The answer of T&F question type must be True or False || MCQ must not be True or False'
		ELSE 
			SELECT 'Invalid column name'
	END TRY

	BEGIN CATCH
		SELECT ERROR_MESSAGE()
	END CATCH
-----------------------------------------------------------------
EXECUTE SP_UPDATE_QUESTION 108,'MCQ','Tittle','What is your name?'
------------------------------------------------------------------
EXECUTE SP_UPDATE_QUESTION 108,'MCQ','Answer','ABC'
------------------------------------------------------------------
EXECUTE SP_UPDATE_QUESTION 108,'MCQ','Grade',5
