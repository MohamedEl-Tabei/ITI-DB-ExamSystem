
CREATE or alter PROC SP_EXAM_GENERATION @CRS_ID INT , @MCQ_NUM INT , @TF_NUM INT ,@exam_name VARCHAR(50) , @duration int
AS
BEGIN
DECLARE @T TABLE 
(
  Q_Id INT PRIMARY KEY,
  Tittle VARCHAR(MAX),
  Answer VARCHAR(MAX),
  Type VARCHAR(20),
  Grade INT ,
  Crs_Id INT
)
INSERT INTO @T (Q_Id, Tittle, Answer, Type, Grade, Crs_Id)
  select * from (select top (@MCQ_NUM) * from Question Q
where Q.Crs_Id=@CRS_ID and Type = 'MCQ' 
order by NEWID()  ) as MCQ_question 

INSERT INTO @T (Q_Id, Tittle, Answer, Type, Grade, Crs_Id)
select * from (select top (@TF_NUM) * from Question Q 
where Q.Crs_Id=@CRS_ID and Type='T&F'
order by NEWID() ) as TF_question

 
 
 DECLARE @Exam_Id INT;
    SELECT  @Exam_Id = (case
	when MAX(Exam_Id) is null then 1
	else MAX(Exam_Id)+1 
	end )FROM Exam 


 EXECUTE insert_exam @Exam_Id , @exam_name , @duration , @CRS_ID
 INSERT INTO Exam_Question  
 SELECT @Exam_Id ,   Q_Id FROM @T WHERE CRS_ID = @CRS_ID
 


SELECT T.Crs_Id , T.Q_Id , T.Tittle , T.Type ,T.Grade FROM @T T ORDER BY NEWID() 
END;


EXECUTE SP_EXAM_GENERATION 10 , 8 , 2 , 'node js' , 120


