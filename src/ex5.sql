CREATE OR REPLACE FUNCTION getBirthdays (refMonthOne char(2), refDayOne char(2), refMonthTwo char(2), refDayTwo char(2))
    RETURNS TABLE (CLI_ID int, CLI_NOM varchar(16),CLI_DATE_NAISSANCE date)
    AS $$
	  DECLARE
      		myPersonList RECORD;
      		myMonth int;
      		myDay int;
      		monthOne int :=	refMonthOne::integer;
      		monthTwo int := refMonthTwo::integer;
      		dayOne int := refDayOne::integer;
      		dayTwo int := refDayTwo::integer;
    BEGIN
	     DROP TABLE IF EXISTS tempo;
       CREATE TEMP TABLE tempo (CLI_ID int, CLI_NOM varchar(16),CLI_DATE_NAISSANCE date);
		   FOR myPersonList IN SELECT * FROM T_CLIENT_CLI LOOP
			     myMonth := substring(myPersonList.cli_date_naissance::varchar from 6 for 2)::integer;
			     myDay := substring(myPersonList.cli_date_naissance::varchar from 9 for 2)::integer;
			     IF ((myMonth > monthOne) AND (myMonth < monthTwo) OR
			         ((myMonth = monthOne) AND (myDay > dayOne))OR
			         ((myMonth = monthTwo) AND (myDay < dayTwo))) THEN
    			           INSERT INTO tempo VALUES (myPersonList.cli_id,myPersonList.cli_nom,myPersonList.cli_date_naissance);
			     END IF;
		   END LOOP;
       RETURN QUERY SELECT * FROM tempo;
	END;
$$ LANGUAGE plpgsql;

SELECT * FROM getBirthdays('02','21', '03', '20');  --birthdays between February 21th and March 20th
SELECT * FROM getBirthdays('12','21', '01', '20');  --birthdays between December 21th and January 20th
