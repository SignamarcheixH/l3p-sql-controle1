SELECT PSP_NOM, ROW_NUMBER () OVER (ORDER BY PSP_NOM) AS N FROM T_PROSPECT_PSP;