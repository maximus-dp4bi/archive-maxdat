 update D_MFDOC_CURRENT
    set
      "Age in Business Days" = MANAGE_MAIL_FAX_DOC.GET_AGE_IN_BUSINESS_DAYS("DCN Create Date","Instance Complete Date"),
      "Age in Calendar Days" = MANAGE_MAIL_FAX_DOC.GET_AGE_IN_CALENDAR_DAYS("DCN Create Date","Instance Complete Date"),
      "DCN Jeopardy Status" = MANAGE_MAIL_FAX_DOC.GET_DCN_JEOPARDY_STATUS("DCN Create Date","Instance Complete Date","Document Type"),
      "DCN Jeopardy Status Date" =NVL( "Instance Complete Date",SYSDATE),
      "DCN Timeliness Status" = MANAGE_MAIL_FAX_DOC.GET_TIMELINESS_STATUS("DCN Create Date","Instance Complete Date","Document Type");
      

commit;