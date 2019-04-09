SELECT * FROM T_CELKO_TEN_IN_ON_TIO WHERE ((ABS(tio_1) + ABS(tio_2) +ABS(tio_3) +ABS(tio_4) +ABS(tio_5)+ABS(tio_6)+ABS(tio_7)+ABS(tio_8)+ABS(tio_9)+ABS(tio_10)) = 1)
									                                                           AND (tio_1 + tio_2 +tio_3 +tio_4 +tio_5+tio_6+tio_7+tio_8+tio_9+tio_10) = 1;

SELECT * FROM T_CELKO_TEN_IN_ON_TIO WHERE ((CASE WHEN (tio_1 = 0) THEN 1 ELSE 0 END)+
                                                                      											(CASE WHEN (tio_2 = 0) THEN 1 ELSE 0 END)+
                                                                      											(CASE WHEN (tio_3 = 0) THEN 1 ELSE 0 END)+
                                                                      											(CASE WHEN (tio_4 = 0) THEN 1 ELSE 0 END)+
                                                                      											(CASE WHEN (tio_5 = 0) THEN 1 ELSE 0 END)+
                                                                      											(CASE WHEN (tio_6 = 0) THEN 1 ELSE 0 END)+
                                                                      											(CASE WHEN (tio_7 = 0) THEN 1 ELSE 0 END)+
                                                                      											(CASE WHEN (tio_8 = 0) THEN 1 ELSE 0 END)+
                                                                      											(CASE WHEN (tio_9 = 0) THEN 1 ELSE 0 END)+
                                                                      											(CASE WHEN (tio_10 = 0) THEN 1 ELSE 0 END)) =9;
