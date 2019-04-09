CREATE OR REPLACE FUNCTION multipleNames (IN namee char(30), IN city char(30),  IN amount INT)
    RETURNS TABLE ( PRS_NOM varchar(50) , PRS_VILLE varchar(50))
    AS $$
    DECLARE
    BEGIN
    	DROP TABLE IF EXISTS tempo;
      CREATE TEMP TABLE tempo ( PRS_NOM varchar(50) , PRS_PRENOM varchar(50));
    	LOOP
          EXIT WHEN amount = 0;
    	    INSERT INTO tempo VALUES (namee, city);
    	    amount = amount-1 ;
      END LOOP;
      RETURN QUERY SELECT * FROM tempo;
    END;
$$ LANGUAGE plpgsql;

SELECT (multipleNames(prs_nom, prs_ville, prs_nombre)) FROM T_PERSONNE_PRS;
