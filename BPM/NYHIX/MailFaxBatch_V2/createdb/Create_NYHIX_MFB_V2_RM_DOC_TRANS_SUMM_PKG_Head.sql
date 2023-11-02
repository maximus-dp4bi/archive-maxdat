create or replace Package NYHIX_MFB_V2_RM_DOC_TRANS_SUMM_PKG AS

    Procedure Insert_Load_RM_DOC_TRANS_SUMM;
    Procedure Update_Load_RM_DOC_TRANS_SUMM;
    Procedure Delete_Load_RM_DOC_TRANS_SUMM;
	Procedure Post_Error;
	Procedure Insert_Corp_ETL_Job_Statistics;
	Procedure Update_Corp_ETL_Job_Statistics;
	Procedure Load_Load_RM_DOC_TRANS_SUMM ( p_rm_id varchar2 default 'a');

END NYHIX_MFB_V2_RM_DOC_TRANS_SUMM_PKG;

