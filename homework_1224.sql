-- <�� ��������>
-- 1. ��� ���̺��� �ο���,�ִ� �޿�,�ּ� �޿�,�޿��� ���� ����Ͽ� ����ϴ� SELECT ������ �ۼ��Ͽ���.
SELECT COUNT(*), MAX(SAL), MIN(SAL), SUM(SAL)
FROM EMP;

-- 2. ������̺��� ������ �ο����� ���Ͽ� ����ϴ� SELECT ������ �ۼ��Ͽ���.
SELECT JOB, COUNT(*)
FROM EMP
GROUP BY JOB;

-- 3. ������̺��� �ְ� �޿��� �ּ� �޿��� ���̴� ���ΰ� ����ϴ� SELECT������ �ۼ��Ͽ���.
SELECT MAX(SAL), MIN(SAL), (MAX(SAL)-MIN(SAL))
FROM EMP;

-- 4. �� �μ����� �ο���, �޿� ���, ���� �޿�, �ְ� �޿�, �޿��� ���� ����ϵ� �޿��� ���� ���� ������ ����϶�.
SELECT COUNT(*), TRUNC(AVG(SAL)), MIN(SAL), MAX(SAL), SUM(SAL)
FROM EMP
GROUP BY DEPTNO
ORDER BY SUM(SAL) DESC;

SELECT COUNT(*), TRUNC(AVG(SAL)), MIN(SAL), MAX(SAL), SUM(SAL)
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO
GROUP BY DNAME
ORDER BY SUM(SAL) DESC;

-- 5. �μ���, ������ �׷��Ͽ� ����� �μ���ȣ, ����, �ο���, �޿��� ���, �޿��� ���� ���Ͽ� ����϶�(��°���� �μ���ȣ, ���������� �������� ����)
SELECT DEPTNO, JOB, COUNT(*), AVG(SAL), SUM(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

SELECT D.DNAME, JOB, COUNT(*), TRUNC(AVG(SAL)), SUM(SAL)
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO
GROUP BY D.DNAME, JOB
ORDER BY D.DNAME, JOB;

-- 6. ������, �μ��� �׷��Ͽ� ����� ����, �μ���ȣ, �ο���, �޿��� ���, �޿��� ���� ���Ͽ� ����϶�.(��°���� ������, �μ���ȣ �� �������� ����)
SELECT JOB, DEPTNO, COUNT(*), AVG(SAL), SUM(SAL)
FROM EMP
GROUP BY JOB, DEPTNO
ORDER BY JOB, DEPTNO;

-- 7. ������� 5���̻� �Ѵ� �μ���ȣ�� ������� ����Ͻÿ�.
SELECT DEPTNO, COUNT(*)
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(*)>=5;

-- 8. ������� 5���̻� �Ѵ� �μ���� ������� ����Ͻÿ�
SELECT DNAME, COUNT(*)
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO
GROUP BY DNAME
HAVING COUNT(*) >= 5;

-- 9. ��� ���̺��� ������ �޿��� ����� 3000�̻��� ������ ���ؼ� ������, ��� �޿�, �޿��� ���� ���Ͽ� ����϶�
SELECT JOB, AVG(SAL), SUM(SAL)
FROM EMP
GROUP BY JOB
HAVING AVG(SAL) >=3000;

-- 10. ������̺��� �޿����� 5000�� �ʰ��ϴ� �� ������ ���ؼ� ������ �޿��հ踦 ����϶� ��, �޿� �հ�� �������� �����϶�.
SELECT JOB, SUM(SAL)
FROM EMP
GROUP BY JOB
HAVING SUM(SAL)>=5000
ORDER BY SUM(SAL) DESC;

-- 11. �μ��� �޿����, �μ��� �޿��հ�, �μ��� �ּұ޿��� ����϶�.
SELECT DEPTNO, ROUND(AVG(SAL)), SUM(SAL), MIN(SAL)
FROM EMP
GROUP BY DEPTNO;

SELECT DNAME, ROUND(AVG(SAL)), SUM(SAL), MIN(SAL)
FROM EMP ,DEPT
WHERE EMP.DEPTNO=DEPT.DEPTNO
GROUP BY DNAME;

-- 12. ���� 11���� �����Ͽ�, �μ��� �޿���� �ִ�ġ, �μ��� �޿����� �ִ�ġ, �μ��� �ּұ޿��� �ִ�ġ�� ����϶�.
SELECT MAX(AVG(SAL)), MAX(MAX(SAL)), MAX(MIN(SAL))
FROM EMP
GROUP BY DEPTNO;

-- 13. ��� ���̺��� �Ʒ��� ����� ����ϴ� SELECT ������ �ۼ��Ͽ���.
--     H_YEAR	COUNT(*)	MIN(SAL)	MAX(SAL)	AVG(SAL)	SUM(SAL)
--	80	  1		800		800		800		800
	--	81	 10		950		5000		2282.5		22825
	--	82	  2		1300		3000		2150		4300
--       83       1		1100		1100		1100		1100
SELECT TO_CHAR(HIREDATE,'YY')AS H_YEAR, COUNT(*), MIN(SAL), MAX(SAL), AVG(SAL), SUM(SAL)
FROM EMP
GROUP BY TO_CHAR(HIREDATE,'YY')
ORDER BY TO_CHAR(HIREDATE,'YY');


-- 14. ������̺��� �Ʒ��� ����� ����ϴ� SELECT �� �ۼ�
-- TOTAL		1980	1981	1982	1983
--   14         	1	  10	  2	  1
SELECT COUNT(*), SUM(DECODE(TO_CHAR(HIREDATE,'YYYY'), '1980', 1, 0)) AS "1980",
                 SUM(DECODE(TO_CHAR(HIREDATE,'YYYY'), '1981', 1, 0)) AS "1981",
                 SUM(DECODE(TO_CHAR(HIREDATE,'YYYY'), '1982', 1, 0)) AS "1982",
                 SUM(DECODE(TO_CHAR(HIREDATE,'YYYY'), '1983', 1, 0)) AS "1983"
FROM EMP;

SELECT COUNT(*),
       COUNT(DECODE(TO_CHAR(HIREDATE,'YYYY'), '1980', 1)) AS "1980",
       COUNT(DECODE(TO_CHAR(HIREDATE,'YYYY'), '1981', 1)) AS "1981",
       COUNT(DECODE(TO_CHAR(HIREDATE,'YYYY'), '1982', 1)) AS "1982",
       COUNT(DECODE(TO_CHAR(HIREDATE,'YYYY'), '1983', 1)) AS "1983"
FROM EMP;

SELECT EXTRACT(YEAR FROM HIREDATE), COUNT(*)
FROM EMP
GROUP BY EXTRACT(YEAR FROM HIREDATE);

-- 15. ������̺��� �Ʒ��� ����� ����ϴ� SELECT �� �ۼ�(JOB ������ �������� ����)
-- JOB		DEPTNO10	DEPTNO20	DEPTNO30     TOTAL
-- ANALYST	     0		   6000		    0		6000
-- CLERK	  1300		   1900		  950		4150
-- ��.
--SALESMAN	      0	 		0	 5600		 5600
SELECT JOB, SUM(DECODE(DEPTNO, 10, SAL, 0)) AS "DEPTNO10",
            SUM(DECODE(DEPTNO, 20, SAL, 0)) AS "DEPTNO20",
            SUM(DECODE(DEPTNO, 30, SAL, 0)) AS "DEPTNO30",
            SUM(SAL) "TOTAL"
FROM EMP
GROUP BY JOB
ORDER BY JOB;

-- 16. ������̺��� �ִ�޿�, �ּұ޿�, ��ü�޿���, ����� ���Ͻÿ�
SELECT MAX(SAL)AS �ִ�޿�, MIN(SAL)AS �ּұ޿�, SUM(SAL)AS ��ü�޿���, ROUND(AVG(SAL))AS ���
FROM EMP;

-- 17. ������̺��� �μ��� �ο����� ���Ͻÿ�
SELECT DEPTNO, COUNT(*)
FROM EMP
GROUP BY DEPTNO;

-- 18. ��� ���̺��� �μ��� �ο����� 6���̻��� �μ��ڵ带 ���Ͻÿ�
SELECT DEPTNO
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(*) >=6;

-- 19. ������̺��� ������ ���� ����� ������ �Ͻÿ�
--DNAME               CLERK    MANAGER  PRESIDENT    ANALYST   SALESMAN
--ACCOUNTING            1300       2450       5000          0          0
--RESEARCH               1900       2975          0       6000          0
--SALES                 950       2850          0          0       5600

SELECT DNAME,  SUM(DECODE(JOB, 'CLERK', SAL, 0)) AS CLERK,
               SUM(DECODE(JOB, 'MANAGER', SAL, 0)) AS MANAGER,
               SUM(DECODE(JOB, 'PRESIDENT', SAL, 0)) AS PRESIDENT,
               SUM(DECODE(JOB, 'ANALYST', SAL, 0)) AS ANALYST,
               SUM(DECODE(JOB, 'SALESMAN', SAL, 0)) AS SALESMAN
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO
GROUP BY DNAME;


-- 20. ������̺��� �޿��� ���� ������� ����� �ο��Ͽ� ������ ���� ����� ������ �Ͻÿ�. (��Ʈ self join, group by, count���)
--ENAME	    ���
--________________________
--KING		1
--SCOTT		2
--FORD		2
--JONES		4

-- 1�ܰ�
SELECT E1.ENAME, E1.SAL, E2.ENAME, E2.SAL
FROM EMP E1, EMP E2
WHERE E1.ENAME='SCOTT' AND E1.SAL < E2.SAL;

-- 2�ܰ�
SELECT E1.ENAME, COUNT(E2.ENAME)+1 AS ���
FROM EMP E1, EMP E2
WHERE E1.SAL < E2.SAL
GROUP BY E1.ENAME
ORDER BY ���;

-- ����
SELECT E.ENAME, COUNT(W.SAL)+1 AS ���
FROM EMP E, EMP W
WHERE E.SAL < W.SAL(+)
GROUP BY E.ENAME
ORDER BY COUNT(W.SAL);

SELECT ENAME, RANK() OVER(ORDER BY SAL DESC) AS ���
FROM EMP;

-- RANK�Լ� ����
SELECT ENAME, RANK() OVER(ORDER BY SAL DESC) AS RANK,
              DENSE_RANK() OVER(ORDER BY SAL DESC) AS DENSE_RANK,
              ROW_NUMBER() OVER(ORDER BY SAL DESC) AS ROW_NUMBER
FROM EMP;

