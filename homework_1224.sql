-- <셤 연습문제>
-- 1. 사원 테이블에서 인원수,최대 급여,최소 급여,급여의 합을 계산하여 출력하는 SELECT 문장을 작성하여라.
SELECT COUNT(*), MAX(SAL), MIN(SAL), SUM(SAL)
FROM EMP;

-- 2. 사원테이블에서 업무별 인원수를 구하여 출력하는 SELECT 문장을 작성하여라.
SELECT JOB, COUNT(*)
FROM EMP
GROUP BY JOB;

-- 3. 사원테이블에서 최고 급여와 최소 급여의 차이는 얼마인가 출력하는 SELECT문장을 작성하여라.
SELECT MAX(SAL), MIN(SAL), (MAX(SAL)-MIN(SAL))
FROM EMP;

-- 4. 각 부서별로 인원수, 급여 평균, 최저 급여, 최고 급여, 급여의 합을 출력하되 급여의 합이 많은 순으로 출력하라.
SELECT COUNT(*), TRUNC(AVG(SAL)), MIN(SAL), MAX(SAL), SUM(SAL)
FROM EMP
GROUP BY DEPTNO
ORDER BY SUM(SAL) DESC;

SELECT COUNT(*), TRUNC(AVG(SAL)), MIN(SAL), MAX(SAL), SUM(SAL)
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO
GROUP BY DNAME
ORDER BY SUM(SAL) DESC;

-- 5. 부서별, 업무별 그룹하여 결과를 부서번호, 업무, 인원수, 급여의 평균, 급여의 합을 구하여 출력하라(출력결과는 부서번호, 업무순으로 오름차순 정렬)
SELECT DEPTNO, JOB, COUNT(*), AVG(SAL), SUM(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

SELECT D.DNAME, JOB, COUNT(*), TRUNC(AVG(SAL)), SUM(SAL)
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO
GROUP BY D.DNAME, JOB
ORDER BY D.DNAME, JOB;

-- 6. 업무별, 부서별 그룹하여 결과를 업무, 부서번호, 인원수, 급여의 평균, 급여의 합을 구하여 출력하라.(출력결과는 업무순, 부서번호 순 오름차순 정렬)
SELECT JOB, DEPTNO, COUNT(*), AVG(SAL), SUM(SAL)
FROM EMP
GROUP BY JOB, DEPTNO
ORDER BY JOB, DEPTNO;

-- 7. 사원수가 5명이상 넘는 부서번호와 사원수를 출력하시오.
SELECT DEPTNO, COUNT(*)
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(*)>=5;

-- 8. 사원수가 5명이상 넘는 부서명과 사원수를 출력하시오
SELECT DNAME, COUNT(*)
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO
GROUP BY DNAME
HAVING COUNT(*) >= 5;

-- 9. 사원 테이블에서 업무별 급여의 평균이 3000이상인 업무에 대해서 업무명, 평균 급여, 급여의 합을 구하여 출력하라
SELECT JOB, AVG(SAL), SUM(SAL)
FROM EMP
GROUP BY JOB
HAVING AVG(SAL) >=3000;

-- 10. 사원테이블에서 급여합이 5000을 초과하는 각 업무에 대해서 업무와 급여합계를 출력하라 단, 급여 합계로 내림차순 정렬하라.
SELECT JOB, SUM(SAL)
FROM EMP
GROUP BY JOB
HAVING SUM(SAL)>=5000
ORDER BY SUM(SAL) DESC;

-- 11. 부서별 급여평균, 부서별 급여합계, 부서별 최소급여를 출력하라.
SELECT DEPTNO, ROUND(AVG(SAL)), SUM(SAL), MIN(SAL)
FROM EMP
GROUP BY DEPTNO;

SELECT DNAME, ROUND(AVG(SAL)), SUM(SAL), MIN(SAL)
FROM EMP ,DEPT
WHERE EMP.DEPTNO=DEPT.DEPTNO
GROUP BY DNAME;

-- 12. 위의 11번을 수정하여, 부서별 급여평균 최대치, 부서별 급여합의 최대치, 부서별 최소급여의 최대치를 출력하라.
SELECT MAX(AVG(SAL)), MAX(MAX(SAL)), MAX(MIN(SAL))
FROM EMP
GROUP BY DEPTNO;

-- 13. 사원 테이블에서 아래의 결과를 출력하는 SELECT 문장을 작성하여라.
--     H_YEAR	COUNT(*)	MIN(SAL)	MAX(SAL)	AVG(SAL)	SUM(SAL)
--	80	  1		800		800		800		800
	--	81	 10		950		5000		2282.5		22825
	--	82	  2		1300		3000		2150		4300
--       83       1		1100		1100		1100		1100
SELECT TO_CHAR(HIREDATE,'YY')AS H_YEAR, COUNT(*), MIN(SAL), MAX(SAL), AVG(SAL), SUM(SAL)
FROM EMP
GROUP BY TO_CHAR(HIREDATE,'YY')
ORDER BY TO_CHAR(HIREDATE,'YY');


-- 14. 사원테이블에서 아래의 결과를 출력하는 SELECT 문 작성
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

-- 15. 사원테이블에서 아래의 결과를 출력하는 SELECT 문 작성(JOB 순으로 오름차순 정렬)
-- JOB		DEPTNO10	DEPTNO20	DEPTNO30     TOTAL
-- ANALYST	     0		   6000		    0		6000
-- CLERK	  1300		   1900		  950		4150
-- ….
--SALESMAN	      0	 		0	 5600		 5600
SELECT JOB, SUM(DECODE(DEPTNO, 10, SAL, 0)) AS "DEPTNO10",
            SUM(DECODE(DEPTNO, 20, SAL, 0)) AS "DEPTNO20",
            SUM(DECODE(DEPTNO, 30, SAL, 0)) AS "DEPTNO30",
            SUM(SAL) "TOTAL"
FROM EMP
GROUP BY JOB
ORDER BY JOB;

-- 16. 사원테이블에서 최대급여, 최소급여, 전체급여합, 평균을 구하시오
SELECT MAX(SAL)AS 최대급여, MIN(SAL)AS 최소급여, SUM(SAL)AS 전체급여합, ROUND(AVG(SAL))AS 평균
FROM EMP;

-- 17. 사원테이블에서 부서별 인원수를 구하시오
SELECT DEPTNO, COUNT(*)
FROM EMP
GROUP BY DEPTNO;

-- 18. 사원 테이블에서 부서별 인원수가 6명이상인 부서코드를 구하시오
SELECT DEPTNO
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(*) >=6;

-- 19. 사원테이블에서 다음과 같은 결과가 나오게 하시오
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


-- 20. 사원테이블에서 급여가 높은 순서대로 등수를 부여하여 다음과 같은 결과가 나오게 하시오. (힌트 self join, group by, count사용)
--ENAME	    등수
--________________________
--KING		1
--SCOTT		2
--FORD		2
--JONES		4

-- 1단계
SELECT E1.ENAME, E1.SAL, E2.ENAME, E2.SAL
FROM EMP E1, EMP E2
WHERE E1.ENAME='SCOTT' AND E1.SAL < E2.SAL;

-- 2단계
SELECT E1.ENAME, COUNT(E2.ENAME)+1 AS 등수
FROM EMP E1, EMP E2
WHERE E1.SAL < E2.SAL
GROUP BY E1.ENAME
ORDER BY 등수;

-- 최종
SELECT E.ENAME, COUNT(W.SAL)+1 AS 등수
FROM EMP E, EMP W
WHERE E.SAL < W.SAL(+)
GROUP BY E.ENAME
ORDER BY COUNT(W.SAL);

SELECT ENAME, RANK() OVER(ORDER BY SAL DESC) AS 등수
FROM EMP;

-- RANK함수 종류
SELECT ENAME, RANK() OVER(ORDER BY SAL DESC) AS RANK,
              DENSE_RANK() OVER(ORDER BY SAL DESC) AS DENSE_RANK,
              ROW_NUMBER() OVER(ORDER BY SAL DESC) AS ROW_NUMBER
FROM EMP;

