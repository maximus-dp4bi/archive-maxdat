CREATE TABLE maxdat_support.enrollment_transaction_type
(transaction_type_id int
 ,transaction_type_code VARCHAR(50)
 ,transaction_type VARCHAR(50))

GO

 begin transaction
 INSERT INTO maxdat_support.enrollment_transaction_type(transaction_type_id,transaction_type_code,transaction_type) 
 VALUES (1,'Disenrolled','Disenrolled')
 INSERT INTO maxdat_support.enrollment_transaction_type(transaction_type_id,transaction_type_code,transaction_type) 
 VALUES(2,'Enrolled','Enrolled')
 INSERT INTO maxdat_support.enrollment_transaction_type(transaction_type_id,transaction_type_code,transaction_type) 
 VALUES(3,'FFS','Fee For Service')
 INSERT INTO maxdat_support.enrollment_transaction_type(transaction_type_id,transaction_type_code,transaction_type) 
 VALUES(4,'New','New')
 INSERT INTO maxdat_support.enrollment_transaction_type(transaction_type_id,transaction_type_code,transaction_type) 
 VALUES(5,'Transfer','Transfer')
 INSERT INTO maxdat_support.enrollment_transaction_type(transaction_type_id,transaction_type_code,transaction_type) 
 VALUES(6,'PCPTransfer','PCP Transfer')
 INSERT INTO maxdat_support.enrollment_transaction_type(transaction_type_id,transaction_type_code,transaction_type) 
 VALUES(-1,'UD','Undefined')

 commit 