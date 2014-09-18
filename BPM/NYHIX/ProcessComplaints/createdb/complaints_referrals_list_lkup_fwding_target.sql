
--NYHIX Forwarding Target for 'REFERRAL' in business days
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
					,'REFERRAL'
					,'State Supervisory Review-MA/FHP'
					,'10'
					,null
					,4
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
					,'REFERRAL'
					,'State Supervisory Review-CHP'
					,'10'
					,null
					,4
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
					,'REFERRAL'
					,'State Supervisory Review-SHOP'
					,'10'
					,null
					,4
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
					,'REFERRAL'
					,'State Supervisory Review-Managed Care'
					,'10'
					,null
					,4
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
					,'REFERRAL'
					,'State Supervisory Review-Financial ManagementP'
					,'10'
					,null
					,4
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
					,'REFERRAL'
					,'State Supervisory Review-Appeals'
					,'10'
					,null
					,4
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
					,'REFERRAL'
					,'State Supervisory Review-Application Support'
					,'10'
					,null
					,4
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
					,'REFERRAL'
					,'State Supervisory Review-TPHI'
					,'10'
					,null
					,4
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
					,'REFERRAL'
					,'State Supervisory Review-Research'
					,'10'
					,null
					,4
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
					,'REFERRAL'
					,'State Supervisory Review-Transition'
					,'10'
					,null
					,4
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
					,'REFERRAL'
					,'Refer to State-Appeals'
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
					,'REFERRAL'
					,'Refer to State-Application Support'
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
					,'REFERRAL'
					,'Refer to State-TPHI'
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
					,'REFERRAL'
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
					,'REFERRAL'
					,'Refer to State-Transition'
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
					,'REFERRAL'
					,'Refer to State-MA/FHP'
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
					,'REFERRAL'
					,'Refer to State-CHP'
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
					,'REFERRAL'
					,'Refer to State-SHOP'
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
					,'REFERRAL'
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
					,'REFERRAL'
					,'Refer to State-Financial Management'
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
					,'REFERRAL'
					,'Refer to Supervisor'
					,'10'
					,null
					,0
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
					,'REFERRAL'
					,'Refer to ES-C'
					,'10'
					,null
					,1
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
					,'REFERRAL'
					,'Refer to State-Managed Care'
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
					,'REFERRAL'
					,'Refer to State-Research'
					,'10'
					,null
					,3
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'NYHIX Forwarding Target for Referral in business days represented by outvar.Ref_id represents the weight for forwarding hierarchy.'
					,SYSDATE
					,SYSDATE);
          
commit;