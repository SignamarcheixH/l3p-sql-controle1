
CREATE OR REPLACE FUNCTION roomForOneDate (myDate date)
    RETURNS TABLE (CHB_NUM int)
    AS $$
    DECLARE
      BEGIN
        RETURN QUERY WITH firstR AS ((SELECT a.CHB_NUM FROM T_CHAMBRE_CHB a INNER JOIN T_PLANNING_PLN b ON a.CHB_NUM = b.CHB_NUM WHERE b.PLN_LIBRE = 'True' AND b.PLN_JOUR = myDate)
                                                                  UNION (SELECT a.CHB_NUM FROM T_CHAMBRE_CHB a WHERE a.CHB_NUM NOT IN (SELECT b.CHB_NUM FROM T_PLANNING_PLN b)))
        SELECT * FROM firstR;
      END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION roomForAllDates (myFirstDate date, mySecondDate date)
    RETURNS TABLE (CHB_NUM int)
    AS $$
    DECLARE myList RECORD;
    BEGIN
        DROP TABLE IF EXISTS tempo;
        CREATE TEMP TABLE tempo (CHB_NUM int);
        FOR myList IN SELECT (generate_series(myFirstDate, mySecondDate, '1 day'::interval))::date AS myDate LOOP
            INSERT INTO tempo SELECT roomForOneDate(myList.myDate);
        END LOOP;
        RETURN QUERY SELECT * FROM tempo;
    END;
$$ LANGUAGE plpgsql;

SELECT DISTINCT roomForAllDates('2000-01-11'::date, '2000-01-14'::date); 		--question 1 of ex4




CREATE OR REPLACE FUNCTION getOccupationForDay(myDate date)
RETURNS TABLE(CHB_NUM int, PLN_LIBRE char(5))
AS $$
DECLARE myList RECORD;
BEGIN
   DROP TABLE IF EXISTS tempo;
   CREATE TEMP TABLE tempo (CHB_NUM int, PLN_LIBRE char(5));
    INSERT INTO tempo SELECT a.CHB_NUM, a.PLN_LIBRE FROM T_PLANNING_PLN a WHERE PLN_JOUR = myDate;
	FOR myList IN SELECT a.CHB_NUM FROM T_CHAMBRE_CHB a WHERE a.CHB_NUM NOT IN (SELECT b.CHB_NUM FROM T_PLANNING_PLN b) LOOP
    	INSERT INTO tempo VALUES (myList.chb_num, 'True');
	END LOOP;
  RETURN QUERY SELECT * FROM tempo;
END;
$$LANGUAGE plpgsql;

SELECT * FROM getOccupationForDay('2000-01-13'::date);					-- question 2




CREATE OR REPLACE FUNCTION getOccupationForDayv2(myDate date)
RETURNS TABLE(PLN_JOUR date,CHB_NUM int, PLN_LIBRE char(5))
AS $$
DECLARE myList RECORD;
BEGIN
   DROP TABLE IF EXISTS tempor;
   CREATE TEMP TABLE tempor (PLN_JOUR date,CHB_NUM int, PLN_LIBRE char(5));
    INSERT INTO tempor SELECT a.PLN_JOUR, a.CHB_NUM, a.PLN_LIBRE FROM T_PLANNING_PLN a WHERE a.PLN_JOUR = myDate;
	FOR myList IN SELECT a.CHB_NUM FROM T_CHAMBRE_CHB a WHERE a.CHB_NUM NOT IN (SELECT b.CHB_NUM FROM T_PLANNING_PLN b WHERE b.PLN_JOUR = myDate)  LOOP
    	INSERT INTO tempor VALUES (myDate, myList.chb_num, 'True');
	END LOOP;
  RETURN QUERY SELECT * FROM tempor;
END;
$$LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION getAllOccupations (myFirstDate date, mySecondDate date)
RETURNS TABLE (PLN_JOUR date,CHB_NUM int, PLN_LIBRE char(5))
AS $$
	DECLARE myList RECORD;
BEGIN
	DROP TABLE IF EXISTS tempo;
   CREATE TEMP TABLE tempo (PLN_JOUR date,CHB_NUM int, PLN_LIBRE char(5));
	FOR myList IN SELECT (generate_series(myFirstDate, mySecondDate, '1 day'::interval))::date AS myDate LOOP
    	INSERT INTO tempo SELECT * FROM getOccupationForDayv2(myList.myDate);
	END LOOP;
    RETURN QUERY SELECT * FROM tempo;
	END;
$$ LANGUAGE plpgsql;

SELECT * FROM getAllOccupations('2000-01-11'::date, '2000-01-14'::date);  --question 3
