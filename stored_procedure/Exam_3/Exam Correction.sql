
	CREATE OR ALTER PROCEDURE SP_EXAM_CORRECTION 
    @EID INT, 
    @SID INT
AS 
BEGIN
    BEGIN TRY
        -- Declare variable for total grade
        DECLARE @G INT;

        -- Declare table variable for results
        DECLARE @T TABLE (
            Student_Id INT,
            Exam_Id INT,
            Student_Name VARCHAR(100), -- Adjusted size
            Exam_Name VARCHAR(100),    -- Adjusted size
            Student_Answer VARCHAR(100), -- Adjusted size
            Question_Answer VARCHAR(100), -- Adjusted size
            Grade INT
        );

        -- Insert data into the table variable
        INSERT INTO @T
        SELECT 
            S.St_Id,
            E.Exam_Id,
            ISNULL(S.Fname, '') + ' ' + ISNULL(S.Lname, '') AS Student_Name,
            E.Exam_Name,
            TE.Answer AS Student_Answer,
            Q.Answer AS Question_Answer,
            CASE
                WHEN upper(TE.Answer) = upper(left(Q.Answer,1)) THEN Q.Grade
                ELSE 0
            END AS Grade
        FROM Take_Exam TE
        INNER JOIN Exam E ON TE.E_Id = E.Exam_Id AND E.Exam_Id = @EID
        INNER JOIN Student S ON S.St_Id = TE.St_Id AND S.St_Id = @SID
        INNER JOIN Question Q ON Q.Q_Id = TE.Q_Id;

        -- Display the results
        SELECT * FROM @T;

        -- Optionally, calculate and return the total grade
        SELECT @G = SUM(Grade) *100 /( select count(Q_Id)*2 from Exam_Question where E_Id=@EID) FROM @T;
        select 'Total Grade: ' + CAST(@G AS VARCHAR)+'%' as Grade_Percent;
    END TRY
    BEGIN CATCH
        -- Handle errors gracefully
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;
END;

EXECUTE SP_EXAM_CORRECTION 2,1
