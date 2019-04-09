
CREATE OR REPLACE FUNCTION formatDate (oldDate char(6))
    RETURNS VOID
    AS $$
    DECLARE
        yearPart char(2) := substring(oldDate from 1 for 2);
        monthPart char(2) := substring(oldDate from 5 for 2);
        dayPart char(2) := substring(oldDate from 3 for 2);
    BEGIN
        yearPart := CASE WHEN (yearPart::integer > 60) THEN '19' ELSE '20' END;
        UPDATE T_AMORTISSEMENT_AMT SET AMT_FIN_Y2K = dayPart || '-' || monthPart || '-' || yearPart WHERE AMT_FIN = oldDate;
  END;
$$ LANGUAGE plpgsql;

SELECT formatDate(AMT_FIN) FROM T_AMORTISSEMENT_AMT;    --! launch this to format all dates in T_AMORTISSEMENT_AMT

SELECT * from T_AMORTISSEMENT_AMT;  --! launch this to verify
