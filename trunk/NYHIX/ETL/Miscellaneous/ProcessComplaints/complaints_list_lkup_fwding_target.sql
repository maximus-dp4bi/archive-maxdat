
--NYHIX Forwarding Target for Complaints in business days
--value represents the forwarded to and ref_id represents the hierarchy in forwarding.
--the higher the ref_id , the higher level the forwarding is

insert into corp_etl_list_lkup (	cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cell_id.NEXTVAL
					,'ProcessComp_Fwding_Target'
					,'COMPLAINT'
					,'State Supervisory Review-MA/FHP'
					,'10'
					,null
					,12
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'NYHIX Forwarding Target for Complaints in business days represented by outvar.Ref_id represents the weight for forwarding hierarchy.'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (	cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cell_id.NEXTVAL
					,'ProcessComp_Fwding_Target'
					,'COMPLAINT'
					,'State Supervisory Review-CHP'
					,'10'
					,null
					,11
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'NYHIX Forwarding Target for Complaints in business days represented by outvar.Ref_id represents the weight for forwarding hierarchy.'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (	cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cell_id.NEXTVAL
					,'ProcessComp_Fwding_Target'
					,'COMPLAINT'
					,'State Supervisory Review-SHOP'
					,'10'
					,null
					,10
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'NYHIX Forwarding Target for Complaints in business days represented by outvar.Ref_id represents the weight for forwarding hierarchy.'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (	cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cell_id.NEXTVAL
					,'ProcessComp_Fwding_Target'
					,'COMPLAINT'
					,'State Supervisory Review-Managed Care'
					,'10'
					,null
					,9
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'NYHIX Forwarding Target for Complaints in business days represented by outvar.Ref_id represents the weight for forwarding hierarchy.'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (	cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cell_id.NEXTVAL
					,'ProcessComp_Fwding_Target'
					,'COMPLAINT'
					,'State Supervisory Review-Financial ManagementP'
					,'10'
					,null
					,8
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'NYHIX Forwarding Target for Complaints in business days represented by outvar.Ref_id represents the weight for forwarding hierarchy.'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (	cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cell_id.NEXTVAL
					,'ProcessComp_Fwding_Target'
					,'COMPLAINT'
					,'Refer to State-MA/FHP'
					,'10'
					,null
					,7
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'NYHIX Forwarding Target for Complaints in business days represented by outvar.Ref_id represents the weight for forwarding hierarchy.'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (	cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cell_id.NEXTVAL
					,'ProcessComp_Fwding_Target'
					,'COMPLAINT'
					,'Refer to State-CHP'
					,'10'
					,null
					,6
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'NYHIX Forwarding Target for Complaints in business days represented by outvar.Ref_id represents the weight for forwarding hierarchy.'
					,SYSDATE
					,SYSDATE);


insert into corp_etl_list_lkup (	cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cell_id.NEXTVAL
					,'ProcessComp_Fwding_Target'
					,'COMPLAINT'
					,'Refer to State-SHOP'
					,'10'
					,null
					,5
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'NYHIX Forwarding Target for Complaints in business days represented by outvar.Ref_id represents the weight for forwarding hierarchy.'
					,SYSDATE
					,SYSDATE);
         
         
         insert into corp_etl_list_lkup (	cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cell_id.NEXTVAL
					,'ProcessComp_Fwding_Target'
					,'COMPLAINT'
					,'Refer to State-Managed Care'
					,'10'
					,null
					,4
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'NYHIX Forwarding Target for Complaints in business days represented by outvar.Ref_id represents the weight for forwarding hierarchy.'
					,SYSDATE
					,SYSDATE);
          
          insert into corp_etl_list_lkup (	cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cell_id.NEXTVAL
					,'ProcessComp_Fwding_Target'
					,'COMPLAINT'
					,'Refer to State-Financial Management'
					,'10'
					,null
					,3
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'NYHIX Forwarding Target for Complaints in business days represented by outvar.Ref_id represents the weight for forwarding hierarchy.'
					,SYSDATE
					,SYSDATE);
          
          insert into corp_etl_list_lkup (	cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cell_id.NEXTVAL
					,'ProcessComp_Fwding_Target'
					,'COMPLAINT'
					,'Refer to ES-C Supervisor'
					,'10'
					,null
					,2
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'NYHIX Forwarding Target for Complaints in business days represented by outvar.Ref_id represents the weight for forwarding hierarchy.'
					,SYSDATE
					,SYSDATE);    
          
          insert into corp_etl_list_lkup (	cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cell_id.NEXTVAL
					,'ProcessComp_Fwding_Target'
					,'COMPLAINT'
					,'Refer to ES-C'
					,'10'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'NYHIX Forwarding Target for Complaints in business days represented by outvar.Ref_id represents the weight for forwarding hierarchy.'
					,SYSDATE
					,SYSDATE);          
          
commit;