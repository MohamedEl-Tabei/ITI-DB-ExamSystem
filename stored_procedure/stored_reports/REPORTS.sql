--Report that returns the students information according to Department No parameter.
CREATE PROCEDURE SP_STUDENTS_IN_DEPARTMENT @DNO INT
AS
	SELECT * FROM Student S WHERE S.Dept_Id=@DNO

EXECUTE SP_STUDENTS_IN_DEPARTMENT 2


--Report that takes the student ID and returns the grades of the student in all courses. %
CREATE OR ALTER PROCEDURE SP_STUDENTS_GRADS @SID INT
AS
	SELECT FORMAT(100*(SUM(0.00+CG.Grade)/SUM(0.00+CG.QGRADE)),'N2') AS TOTAL,CG.Crs_Name
	FROM
	(SELECT CR.Crs_Name,Q.Grade AS QGRADE,
		CASE
			WHEN TE.Answer=Q.Answer THEN Q.Grade
			ELSE 0
		END AS Grade
	FROM Take_Exam TE
	JOIN Exam E
	ON TE.E_Id=E.Exam_Id
	JOIN Student S 
	ON S.St_Id=TE.St_Id AND S.St_Id=@SID
	JOIN Question Q
	ON Q.Q_Id=TE.Q_Id
	JOIN Course CR
	ON CR.Crs_Id=E.Crs_Id) CG
	GROUP BY CG.Crs_Name
	


EXECUTE SP_STUDENTS_GRADS 3


--Report that takes the instructor ID and returns the name of the courses that he teaches and the number of student per course.
CREATE OR ALTER PROCEDURE SP_INSTRUCTOR_COURSES @ID INT
AS 
	SELECT C.Crs_Name,COUNT(SC.St_Id) AS STUDENT_NUMBER
	FROM Course C
	JOIN Ins_Course IC
	ON IC.Crs_Id=C.Crs_Id AND IC.Ins_Id=@ID
	JOIN Stud_Course SC
	ON SC.Crs_Id=C.Crs_Id
	GROUP BY C.Crs_Name

EXECUTE SP_INSTRUCTOR_COURSES 1

--Report that takes course ID and returns its topics  
CREATE PROCEDURE SP_COURSE_TOPICS @ID INT
AS 
	SELECT T.T_Name
	FROM  Topic T
	WHERE @ID =T.Crs_Id

EXECUTE SP_COURSE_TOPICS 1
--Report that takes exam number and returns the Questions in it and chocies [freeform report]
EXECUTE SP_SELECT_QUESTIONS_OF_EXAM 2

--Report that takes exam number and the student ID then returns the Questions in this exam with the student answers. 
--Hints:
	--Use stored procedures to return data for each Report.
CREATE OR ALTER PROCEDURE SP_SELECT_TAKE_EXAM_BY_EXAM_NUMBER @ST_ID INT, @EN INT
AS
           IF EXISTS (SELECT St_Id FROM Take_Exam WHERE @ST_ID=St_Id)
		   SELECT S.Fname+' '+S.Lname AS Student_FullName, E.Exam_Name AS Exam_Name , Q.Tittle AS Question_Tittle , T.Answer AS Answer
		   FROM Exam E , Student S , Question Q , Take_Exam T 
		   WHERE S.St_Id=@ST_ID AND S.St_Id=T.St_Id AND E.Exam_Id=T.E_Id AND Q.Q_Id=T.Q_Id AND E.Exam_Id=@EN

		   ELSE
		         SELECT 'Invalid Student ID'


        EXECUTE SP_SELECT_TAKE_EXAM_BY_EXAM_NUMBER 3,1
