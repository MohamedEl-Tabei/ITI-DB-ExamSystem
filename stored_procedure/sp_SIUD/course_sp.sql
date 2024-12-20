------ course table

create Procedure select_course  @id int
as
  
    if exists(select crs_id from Course where crs_id=@id)
   begin
   select * from Course 
   where Crs_Id=@id
   end
   else 
       select 'this course not exist'
  


execute  select_course 8

--------------------------------------------------
create Procedure delete_course  @id int
as
   if exists(select crs_id from Course where Crs_Id=@id)
   begin
   delete from Course
   where Crs_Id=@id
   end
   else 
       select 'this course not exist'


execute  select_course 5

--------------------------------------------
create Procedure update_course  @id int  ,  @name varchar(50) 
as
  if exists(select crs_id from Course where Crs_Id=@id)
  begin
     update course set Crs_Name = @name where crs_id= @id

	 select 'course name updated successfully.'
  end
  else 
    select 'can not modify !!!'


execute  update_course  1, 'html'

--------------------------------------------------

CREATE PROCEDURE insert_course
    @id INT,              
    @name VARCHAR(50)     
   
AS

    BEGIN TRY
        INSERT INTO Course(Crs_Id, Crs_Name)
        VALUES (@id, @name);

        select 'course record inserted successfully.';
    END TRY
    BEGIN CATCH
        select 'Error occurred while inserting the course record.';
        select ERROR_MESSAGE();
    END CATCH


execute  insert_course  22, 'data structure'

---------------------------------------------------------------------------------------------------