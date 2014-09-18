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
					,'Complaint'
					,'Refer to State-Medicaid Managed Care'
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
					,'Referral'
					,'Refer to State-Medicaid Managed Care'
					,'10'
					,null
					,3
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'NYHIX Forwarding Target for Referral in business days represented by outvar.Ref_id represents the weight for forwarding hierarchy.'
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
					,'Referral'
					,'Refer to State-APTC/QHP Plan Management'
					,'10'
					,null
					,3
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'NYHIX Forwarding Target for Referral in business days represented by outvar.Ref_id represents the weight for forwarding hierarchy.'
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
					,'Complaint'
					,'Refer to State-APTC/QHP Plan Management'
					,'10'
					,null
					,3
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'NYHIX Forwarding Target for Complaints in business days represented by outvar.Ref_id represents the weight for forwarding hierarchy.'
					,SYSDATE
					,SYSDATE);

commit;