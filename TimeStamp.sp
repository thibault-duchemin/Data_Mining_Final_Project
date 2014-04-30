CREATE FUNCTION convertTimeString(@time_in varchar) RETURNS time
	BEGIN 
		DECLARE @time_out time;
		SELECT @time_out = 
			CASE LEN(@time_in) 
				WHEN 5 THEN 
					CASE 
						WHEN RIGHT(CAST(@time_in AS VARCHAR(5)),1) == 'A' THEN
							CASE 
								WHEN LEFT(CAST(@time_in AS smallint),2) > 11 THEN
									CAST(LEFT(CAST(@time_in AS smallint),2) - 12,VARCHAR(2)) + SUBSTRING(CAST(@time_in AS VARCHAR(6)), 3,2) + ':00'
								ELSE
									LEFT(CAST(@time_in AS VARCHAR(6)),2) + SUBSTRING(CAST(@time_in AS VARCHAR(6)), 3,2) + ':00'
							END;
						WHEN RIGHT(CAST(@time_in AS VARCHAR(5)),1) == 'P' THEN
							CASE 
								WHEN LEFT(CAST(@time_in AS smallint),2) < 12 THEN
									CAST(LEFT(CAST(@time_in AS smallint),2) + 12,VARCHAR(2)) + SUBSTRING(CAST(@time_in AS VARCHAR(6)), 3,2) + ':00'
								ELSE
									LEFT(CAST(@time_in AS VARCHAR(6)),2) + SUBSTRING(CAST(@time_in AS VARCHAR(6)), 3,2) + ':00'
							END;
						ELSE
							'00:00:00'
					END;
				ELSE
					'00:00:00'
			END;
		RETURN CAST(@time_out, TIME);
	END;

	