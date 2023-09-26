CREATE OR REPLACE FUNCTION  try_parse_date
                            (
                                p_date_string           IN                          VARCHAR2,
                                p_format                IN                          VARCHAR2                                        DEFAULT NULL
                            )
RETURN                                                                              DATE

IS

    TYPE t_dt_fmt IS TABLE OF VARCHAR2(30)
    INDEX BY binary_integer;
    
    l_dt_fmt                                                                        t_dt_fmt;

    l_date                                                                          DATE;

    PROCEDURE   pop_dt_fmt IS
    BEGIN
    
        l_dt_fmt    :=  t_dt_fmt();
        
        l_dt_fmt(NVL(l_dt_fmt.LAST,0) + 1)  :=  'MM/DD/YYYY';
        l_dt_fmt(NVL(l_dt_fmt.LAST,0) + 1)  :=  'DD-MON-YYYY';
        l_dt_fmt(NVL(l_dt_fmt.LAST,0) + 1)  :=  'YYYY-MM-DD';        
        l_dt_fmt(NVL(l_dt_fmt.LAST,0) + 1)  :=  'MMDDYYYY';        
        l_dt_fmt(NVL(l_dt_fmt.LAST,0) + 1)  :=  'DDMMYYYY';
        l_dt_fmt(NVL(l_dt_fmt.LAST,0) + 1)  :=  'DD/MON/YYYY';        
        l_dt_fmt(NVL(l_dt_fmt.LAST,0) + 1)  :=  'MM/DD/YY';        
        l_dt_fmt(NVL(l_dt_fmt.LAST,0) + 1)  :=  'DD-MON-YY';        
        l_dt_fmt(NVL(l_dt_fmt.LAST,0) + 1)  :=  'YY-MM-DD';        
        l_dt_fmt(NVL(l_dt_fmt.LAST,0) + 1)  :=  'DD/MON/YY';        
        l_dt_fmt(NVL(l_dt_fmt.LAST,0) + 1)  :=  'MMDDYY';        
        l_dt_fmt(NVL(l_dt_fmt.LAST,0) + 1)  :=  'DDMMYY';        
    
    END         pop_dt_fmt;

BEGIN

    pop_dt_fmt;
    
    FOR d IN 1..l_dt_fmt.COUNT
    LOOP
    
        IF
        (
            l_dt_fmt(d)   =   NVL(UPPER(TRIM(p_format)), l_dt_fmt(d))
        )
        THEN

            BEGIN            
                l_date  :=  TO_DATE(p_date_string, l_dt_fmt(d));
                EXIT;
            EXCEPTION
                WHEN    OTHERS
                THEN    l_date  :=  NULL;
            END;

            IF
            (
                p_format IS NOT NULL
            )
            THEN
                EXIT;
            END IF;

        END IF;
        
    END LOOP;
    
    l_dt_fmt.DELETE;
    
    RETURN  l_date;

END try_parse_date;