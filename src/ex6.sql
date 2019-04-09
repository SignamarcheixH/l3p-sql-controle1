CREATE OR REPLACE FUNCTION fillTable (amount int)
    RETURNS VOID
    AS $$
    BEGIN
        CREATE SEQUENCE filltable START 10;
        INSERT INTO	T_ENTIER_ENT VALUES (nextval('filltable'));
	      WHILE(currval('filltable') != amount) LOOP
		          INSERT INTO	T_ENTIER_ENT VALUES (nextval('filltable'));
	      END LOOP;
   END;
$$ LANGUAGE plpgsql;

SELECT fillTable(10);
SELECT * from T_ENTIER_ENT;
