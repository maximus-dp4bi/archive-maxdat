--UAT Values    
    	--Part A
        insert into C_MW_STANDARD_WORK select SEQ_CMW_SW_ID.nextVal, 430,98,null from dual; -- new request, null
        insert into C_MW_STANDARD_WORK select SEQ_CMW_SW_ID.nextVal, 430,96,98 from dual; -- appeal entered, new request
        insert into C_MW_STANDARD_WORK select SEQ_CMW_SW_ID.nextVal, 430,867270,96 from dual; -- ready for triage, appeal entered
        insert into C_MW_STANDARD_WORK select SEQ_CMW_SW_ID.nextVal, 430,101,867270 from dual; -- ready for appeal review, ready for triage
        insert into C_MW_STANDARD_WORK select SEQ_CMW_SW_ID.nextVal, 430,101,96 from dual; -- ready for appeal review, appeal entered
        insert into C_MW_STANDARD_WORK select SEQ_CMW_SW_ID.nextVal, 430,103,101 from dual; -- pending medical review, ready for appeal review       
        insert into C_MW_STANDARD_WORK select SEQ_CMW_SW_ID.nextVal, 430,118,103 from dual; -- medical review complete, pending medical review
        insert into C_MW_STANDARD_WORK select SEQ_CMW_SW_ID.nextVal, 430,118,101 from dual; -- medical review complete, ready for appeal review
        insert into C_MW_STANDARD_WORK select SEQ_CMW_SW_ID.nextVal, 430,97,118 from dual; -- ready to close, medical review complete    
        insert into C_MW_STANDARD_WORK select SEQ_CMW_SW_ID.nextVal, 430,97,101 from dual; -- ready to close, ready for appeal review
    
        --Part C
        insert into C_MW_STANDARD_WORK select SEQ_CMW_SW_ID.nextVal, 431,98,null from dual; -- new request, null
        insert into C_MW_STANDARD_WORK select SEQ_CMW_SW_ID.nextVal, 431,96,98 from dual; -- appeal entered, new request
        insert into C_MW_STANDARD_WORK select SEQ_CMW_SW_ID.nextVal, 431,867270,96 from dual; -- ready for triage, appeal entered
        insert into C_MW_STANDARD_WORK select SEQ_CMW_SW_ID.nextVal, 431,101,867270 from dual; -- ready for appeal review, ready for triage
        insert into C_MW_STANDARD_WORK select SEQ_CMW_SW_ID.nextVal, 431,101,96 from dual; -- ready for appeal review, appeal entered
        insert into C_MW_STANDARD_WORK select SEQ_CMW_SW_ID.nextVal, 431,103,101 from dual; -- pending medical review, ready for appeal review       
        insert into C_MW_STANDARD_WORK select SEQ_CMW_SW_ID.nextVal, 431,101,103 from dual; -- ready for appeal review, pending medical review
        insert into C_MW_STANDARD_WORK select SEQ_CMW_SW_ID.nextVal, 431,97,101 from dual; -- ready to close, ready for appeal review
        
        --Part D-Drug
        insert into C_MW_STANDARD_WORK select SEQ_CMW_SW_ID.nextVal, 432,98,null from dual; -- new request, null
        insert into C_MW_STANDARD_WORK select SEQ_CMW_SW_ID.nextVal, 432,96,98 from dual; -- appeal entered, new request
        insert into C_MW_STANDARD_WORK select SEQ_CMW_SW_ID.nextVal, 432,101,96 from dual; -- ready for appeal review, appeal entered
        insert into C_MW_STANDARD_WORK select SEQ_CMW_SW_ID.nextVal, 432,101,101 from dual; -- ready for appeal review, ready for appeal review
        insert into C_MW_STANDARD_WORK select SEQ_CMW_SW_ID.nextVal, 432,103,101 from dual; -- pending medical review, ready for appeal review       
        insert into C_MW_STANDARD_WORK select SEQ_CMW_SW_ID.nextVal, 432,101,103 from dual; -- ready for appeal review, pending medical review
        insert into C_MW_STANDARD_WORK select SEQ_CMW_SW_ID.nextVal, 432,97,101 from dual; -- ready to close, ready for appeal review
           