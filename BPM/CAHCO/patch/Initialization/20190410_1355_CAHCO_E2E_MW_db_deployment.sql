-- Last Mail Transaction ID

DECLARE
	l_last_mail_transaction_id					HCO_MAIL_CLIENT_TRANS.mail_transaction_id%TYPE;
BEGIN

	SELECT	MAX(mail_transaction_id)
      INTO l_last_mail_transaction_id
      FROM	HCO_MAIL_CLIENT_TRANS;

	UPDATE	CORP_ETL_CONTROL
       SET	value			=	l_last_mail_transaction_id
     WHERE	name			=	'MW_LAST_MAIL_TRANSACTION_ID';

	IF
	(
		SQL%ROWCOUNT = 0
	)
	THEN
		INSERT
          INTO  corp_etl_control    (   NAME,                               value_type,     VALUE,                  		    DESCRIPTION )
        VALUES                      (   'MW_LAST_MAIL_TRANSACTION_ID',      'N',            l_last_mail_transaction_id,  		'The last processed mail transaction ID');
	END IF;

	COMMIT;
END;
/