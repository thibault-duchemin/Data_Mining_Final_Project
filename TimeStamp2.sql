CREATE FUNCTION test(a varchar) RETURNS varchar
	BEGIN
		DECLARE b time;
		SELECT b = a;
		RETURN b;
	END;

test('abc');