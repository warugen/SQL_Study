-- 예제 PART1
-- 1. EMP테이블의 모든 사원에 대해 사원명과 직속상사명을 출력하시오. 
SELECT W.ENAME AS 사원, NVL(M.ENAME,'없음') AS 직속상사 
FROM EMP W, EMP M
WHERE W.MGR = M.EMPNO(+);

-- 2. 상사가 있는 직원에 대해 사원명, 급여, 직책, 직속상사명을 출력하시오.
SELECT W.ENAME AS 사원, W.SAL AS 급여, W.JOB AS 직책, M.ENAME AS 직속상사
FROM EMP W, EMP M
WHERE W.MGR = M.EMPNO;

-- 3. 상사가 없는 직원과 상사가 있는 직원들 모두에 대해 사원명, 급여, 직책, 직속상사명을 출력하시오.
SELECT W.ENAME AS 사원, W.SAL AS 급여, W.JOB AS 직책, NVL(M.ENAME,'없음') AS 직속상사
FROM EMP W, EMP M
WHERE W.MGR = M.EMPNO(+);

-- 4. 상사가 있는 직원에 대해 사원명, 사원명, 급여, 부서명, 직속상사명을 출력하시오.
SELECT W.ENAME AS 사원, W.SAL AS 급여, DNAME AS 부서명, M.ENAME AS 직속상사
FROM EMP W, EMP M, DEPT D
WHERE W.MGR = M.EMPNO  AND W.DEPTNO = D.DEPTNO;

-- 5. 상사가 없는 직원과 상사가 있는 직원 모두에 대해 사명원, 급여, 부서코드, 부서명, 근무지, 직속상사명을 출력하시오. 
-- 단, 직속상사가 없을 경우 직속상사명에는 ‘없음’으로 대신 출력하시오.
SELECT W.ENAME AS 사원, W.SAL AS 급여, W.DEPTNO AS 부서코드, DNAME AS 부서명, LOC AS 근무지, NVL(M.ENAME,'없음') AS 직속상사
FROM EMP W, EMP M, DEPT D
WHERE W.MGR = M.EMPNO(+) AND W.DEPTNO = D.DEPTNO;

-- 6. 급여가 2000이상인 사원에 대해 사원명, 급여, 급여등급, 부서명, 직속상사명을 출력하시오.
SELECT W.ENAME AS 사원, W.SAL AS 급여, S.GRADE AS 급여등급, D.DNAME AS 부서명, M.ENAME AS 직속상사
FROM EMP W, EMP M, SALGRADE S, DEPT D
WHERE W.MGR=M.EMPNO AND W.DEPTNO=D.DEPTNO AND W.SAL BETWEEN S.LOSAL AND S.HISAL AND W.SAL >= 2000;

-- 7. 상사가 있는 직원과 상사가 없는 직원 모두에 대해 사원명, 급여, 급여등급, 부서명, 직속상사명을 
-- 부서명 알파벳 순으로 정렬하여 출력하시오.
SELECT W.ENAME AS 사원, W.SAL AS 급여, S.GRADE AS 급여등급, D.DNAME AS 부서명,NVL(M.ENAME,'없음') AS 직속상사
FROM EMP W, EMP M, SALGRADE S, DEPT D
WHERE W.MGR=M.EMPNO(+) AND W.DEPTNO=D.DEPTNO AND W.SAL BETWEEN S.LOSAL AND S.HISAL
ORDER BY D.DNAME;

-- 8. 사원명, 급여, 급여등급, 부서명, 연봉, 직속상사명을 출력하시오. 단 연봉은 (SAL+COMM)*12로 계산한다.
SELECT W.ENAME AS 사원, W.SAL AS 급여, S.GRADE AS 급여등급, D.DNAME AS 부서명, (W.SAL+NVL(W.COMM,0))*12 AS 연봉 ,NVL(M.ENAME,'없음') AS 직속상사
FROM EMP W, EMP M, SALGRADE S, DEPT D
WHERE W.MGR=M.EMPNO AND W.DEPTNO=D.DEPTNO AND W.SAL BETWEEN S.LOSAL AND S.HISAL;

-- 9. 위 8번을 부서명 알파벳 순으로 정렬하고 부서명이 같으면 급여가 큰 사원에서 작은 사원 순으로 정렬하여 출력하시오.
SELECT W.ENAME AS 사원, W.SAL AS 급여, S.GRADE AS 급여등급, D.DNAME AS 부서명, (W.SAL+NVL(W.COMM,0))*12 AS 연봉 ,NVL(M.ENAME,'없음') AS 직속상사
FROM EMP W, EMP M, SALGRADE S, DEPT D
WHERE W.MGR=M.EMPNO AND W.DEPTNO=D.DEPTNO AND W.SAL BETWEEN S.LOSAL AND S.HISAL
ORDER BY D.DNAME, W.SAL DESC;


-- 예제 PART2
--1.EMP 테이블에서 모든 사원에 대한 이름,부서번호,부서명을 출력하는 SELECT 문장을 작성하여라.
SELECT E.ENAME AS 이름, E.DEPTNO AS 부서번호, D.DNAME AS 부서명
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO;

--2. EMP 테이블에서 NEW YORK에서 근무하고 있는 사원에 대하여 이름,업무,급여,부서명을 출력하는 SELECT 문장을 작성하여라.
SELECT E.ENAME AS 이름, E.JOB AS 업무, E.SAL AS 급여, D.DNAME AS 부서명
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO AND D.LOC IN ('NEW YORK');

--3. EMP 테이블에서 보너스를 받는 사원에 대하여 이름,부서명,위치를 출력하는 SELECT 문장을 작성하여라.
SELECT E.ENAME AS 이름, D.DNAME AS 부서명, D.LOC AS 위치
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO AND COMM IS NOT NULL AND COMM <> 0;

--4. EMP 테이블에서 이름 중 L자가 있는 사원에 대하여 이름,업무,부서명,위치를 출력하는 SELECT 문장을 작성하여라.
SELECT E.ENAME AS 이름, JOB AS 업무, D.DNAME AS 부서명, D.LOC AS 위치
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO AND E.ENAME LIKE '%L%';

--5. 사번, 사원명, 부서코드, 부서명을 검색하라. 사원명기준으로 오름차순정열
SELECT E.EMPNO AS 사번, E.ENAME AS 사원명, E.DEPTNO AS 부서코드, D.DNAME AS 부서명
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO
ORDER BY E.ENAME;

--6. 사번, 사원명, 급여, 부서명을 검색하라. 단 급여가 2000이상인 사원에 대하여 급여를 기준으로 내림차순으로 정열하시오
SELECT E.EMPNO AS 사번, E.ENAME AS 사원명, E.SAL AS 급여, D.DNAME AS 부서명
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO AND SAL >= 2000
ORDER BY SAL DESC;

--7. 사번, 사원명, 업무, 급여, 부서명을 검색하시오. 단 업무가 MANAGER이며 
-- 급여가 2500이상인 사원에 대하여 사번을 기준으로 오름차순으로 정열하시오.
SELECT E.EMPNO AS 사번, E.ENAME AS 사원명, E.JOB AS 업무, E.SAL AS 급여, D.DNAME AS 부서명
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO AND JOB IN('MANAGER') AND SAL >= 2500
ORDER BY E.EMPNO;

--8. 사번, 사원명, 업무, 급여, 등급을 검색하시오. 단, 급여기준 내림차순으로 정렬하시오
SELECT E.EMPNO AS 사번, E.ENAME AS 사원명, E.JOB AS 업무, E.SAL AS 급여, S.GRADE
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
ORDER BY E.SAL DESC;

--9. 사원테이블에서 사원명, 사원의 상사를 검색하시오(상사가 없는 직원까지 전체)
SELECT E.ENAME AS 사원명, NVL(M.ENAME,'없음') AS 상사
FROM EMP E, EMP M
WHERE E.MGR = M.EMPNO(+);

--10. 사원명, 상사명, 상사의 상사명을 검색하시오
SELECT E1.ENAME AS 사원명, E2.ENAME AS 상사 , E3.ENAME AS "상사의 상사"
FROM EMP E1, EMP E2, EMP E3
WHERE E1.MGR = E2.EMPNO AND E2.MGR=E3.EMPNO;

--11. 위의 결과에서 상위 상사가 없는 모든 직원의 이름도 출력되도록 수정하시오
SELECT E1.ENAME AS 사원명, NVL(E2.ENAME,'없음') AS 상사, NVL(E3.ENAME,'없음') AS "상사의 상사"
FROM EMP E1, EMP E2, EMP E3
WHERE E1.MGR = E2.EMPNO(+) AND E2.MGR=E3.EMPNO(+);

SELECT E1.ENAME AS 사원명, '▶'||E2.ENAME AS 상사, '▶'||E3.ENAME AS "상사의 상사"
FROM EMP E1, EMP E2, EMP E3
WHERE E1.MGR = E2.EMPNO(+) AND E2.MGR=E3.EMPNO(+);