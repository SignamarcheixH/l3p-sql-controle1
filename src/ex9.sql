CREATE OR REPLACE FUNCTION getHoles ()
    RETURNS TABLE (Trou int)
    AS $$
	  DECLARE myList RECORD;
			 maxVal RECORD;
			 boolCheck boolean;
    BEGIN
	       DROP TABLE IF EXISTS tempo;
         CREATE TEMP TABLE tempo (Trou int);
	       SELECT INTO maxVal max(NMR) as maxi FROM T_NUMERO_NMR;
	        FOR myList IN SELECT (generate_series(1,maxVal.maxi)) AS val LOOP
		            SELECT INTO boolCheck EXISTS(SELECT 1 FROM T_NUMERO_NMR WHERE NMR=myList.val);
		            if(boolCheck = false) THEN
    		              INSERT INTO tempo VALUES (myList.val);
		            END IF;
	        END LOOP;
          RETURN QUERY SELECT * FROM tempo;
	   END;
$$ LANGUAGE plpgsql;
				 
select getHoles();
