/*(a)*/
SELECT E.SSN, E.Lname, E.Fname FROM Employee E
WHERE E.Dno = '4'
  AND E.SSN IN (
      SELECT W1.ESSN
      FROM Works_on W1
      JOIN Comp_Project P1 ON W1.Pno = P1.Pnumber
      WHERE P1.Pname = 'ProductX' AND W1.Hours > 5
  )
  AND E.SSN IN (
      SELECT W2.ESSN
      FROM Works_on W2
      JOIN Comp_Project P2 ON W2.Pno = P2.Pnumber
      WHERE P2.Pname = 'ProductY' AND W2.Hours > 5
  );

/*(b)*/
SELECT E.SSN,E.Fname,E.Lname FROM Employee E
WHERE E.SSN NOT IN (SELECT D.ESSN FROM Dependent D);

/*(c)*/
SELECT E.SSN,E.Fname,E.Lname FROM Employee E
WHERE E.SuperSSN IN (SELECT E1.SSN FROM Employee E1 WHERE E1.SuperSSN =
  (SELECT E2.SSN FROM Employee E2 WHERE E2.Fname = 'James' AND E2.Lname = 'Borg')
  );

/*(d)*/
SELECT DISTINCT E.SSN, E.Fname, E.Lname FROM Employee E
JOIN Works_on W ON E.SSN = W.ESSN;

/*(e)*/
SELECT E.SSN, E.Fname, E.Lname FROM Employee E
WHERE NOT EXISTS (
    SELECT P.Pnumber
    FROM Comp_Project P
    WHERE P.Plocation = 'Stafford'
      AND NOT EXISTS (
          SELECT W.ESSN
          FROM Works_on W
          WHERE W.ESSN = E.SSN AND W.Pno = P.Pnumber
      )
);

/*(f)*/
SELECT DISTINCT D.Dname, MIN(E.Salary) AS LowestMaleSalary
FROM Department D JOIN Employee E ON E.Dno = D.Dnumber
WHERE D.Dnumber = '5' AND E.Sex = 'M'
GROUP BY D.Dname;

/*(g)*/
SELECT E.SSN, E.Fname, E.Lname, E.Salary FROM Employee E 
WHERE E.Dno = '4' AND E.Salary = (SELECT MAX(E2.Salary) FROM Employee E2 WHERE E2.Dno = '4');

/*(h)*/
SELECT E.SSN, E.Fname, E.Lname, E.address FROM Employee E 
WHERE E.SSN IN (SELECT W.ESSN FROM Works_on W JOIN Comp_Project P ON W.Pno = P.Pnumber WHERE P.Plocation = 'Houston')
AND E.Dno IN (SELECT DL.Dnumber FROM Dept_Locations DL WHERE DL.Dlocation = 'Houston');

/*(i)*/
SELECT E.SSN, E.Lname FROM Employee E
WHERE E.SSN IN (
    SELECT D.MgrSSN FROM Department D
)
AND E.SSN IN (
    SELECT Dep.ESSN
    FROM Dependent Dep
    WHERE Dep.Relationship = 'Spouse'
);