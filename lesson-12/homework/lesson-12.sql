-- 1.

SELECT 
	p.firstName,
	p.lastName,
	a.city,
	a.state
FROM
	Person AS p
LEFT JOIN
	Address AS a
	ON p.personId = a.personId;

-- 2.

SELECT 
	e1.id,
	e1.name,
	e1.salary,
	e1.managerId
FROM 
	Employee AS e1
JOIN 
	Employee AS e2
	ON e1.managerId = e2.id
WHERE 
	e1.Salary > e2.salary;
												
-- 3.

SELECT
	email
FROM
	Person
GROUP BY 
	email
HAVING
	COUNT(TRIM(email)) > 1;


-- 4.

DELETE 
	p1
FROM 
	Person AS p1
JOIN
	Person AS p2
	ON TRIM(p1.email) = TRIM(p2.email)
	AND p1.id > p2.id;

-- 5.

SELECT 
	g.ParentName
FROM 
	girls AS g
WHERE
	NOT EXISTS (SELECT 1 FROM boys AS b WHERE b.ParentName = g.ParentName);


-- 6.

SELECT 
    custid,
    SUM(CASE WHEN freight > 50 THEN freight ELSE 0 END) AS TotalWeightOver50,
    MIN(weight) AS LeastWeight
FROM 
    Sales.Orders
GROUP BY 
    custid;



-- 7.

SELECT
	ISNULL(c1.Item, '') AS Item1,
	ISNULL(c2.Item, '') AS Item2
FROM 
	Cart1 AS c1
FULL OUTER JOIN
	Cart2 AS c2
	ON c1.item = c2.Item;

-- 8.

WITH Details AS (
SELECT
	MatchID,
	Match,
	Score,
	LEFT(Score, CHARINDEX(':', Score) - 1) AS LH,
	RIGHT(Score, LEN(Score) - CHARINDEX(':', Score)) AS RH,
	LEFT(TRIM(Match), CHARINDEX('-', TRIM(Match)) - 1) AS MLH,
	RIGHT(TRIM(Match), LEN(TRIM(Match)) - CHARINDEX('-', TRIM(Match))) AS MRH
FROM 
	match1 AS m1)

SELECT
	MatchId,
	Match,
	Score,
	CASE
		WHEN LH > RH THEN MLH
		WHEN RH > LH THEN MRH
	ELSE
		'Draw'
	END AS Result
FROM Details;

-- 9.

SELECT
	c.id,
	c.name
FROM
	Customers AS c
WHERE
	NOT EXISTS (SELECT 1 FROM Orders WHERE c.id = customerId);


-- 10.

SELECT 
	st.student_id,
	st.student_name,
	sb.subject_name,
	COUNT(ex.subject_name) AS NumOfExam
FROM
	Students AS st
CROSS JOIN
	Subjects AS sb
LEFT JOIN
	Examinations AS ex
	ON st.student_id = ex.student_id
	AND ex.subject_name = sb.subject_name
GROUP BY
	st.student_id,
	st.student_name,
	sb.subject_name
ORDER BY
	st.student_id,
	sb.subject_name;
