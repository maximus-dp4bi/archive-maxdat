-------------------------------------------------------------------
--Create NYHIX_MFB_V2_ENVELOPESTATS Pkg Head
create or replace Package NYHIX_MFB_V2_ENVELOPESTATS_PKG AS

    Procedure Insert_Load_ENVELOPESTATS;
    Procedure Update_Load_ENVELOPESTATS;
    Procedure Delete_Load_ENVELOPESTATS;
	Procedure Post_Error;
	Procedure Insert_Corp_ETL_Job_Statistics;
	Procedure Update_Corp_ETL_Job_Statistics;
	Procedure Load_Load_ENVELOPESTATS ( p_rm_id varchar2 default 'a');

END NYHIX_MFB_V2_ENVELOPESTATS_PKG;
