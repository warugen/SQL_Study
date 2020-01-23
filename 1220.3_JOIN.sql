-- 2019.12.20_3장. JOIN

SELECT * FROM EMP; -- 사원정보
SELECT * FROM DEPT; -- 부서정보

SELECT * FROM EMP
WHERE ENAME = 'SMITH';

SELECT * FROM DEPT;

-- CROSS JOIN 잘 사용 안함
SELECT * FROM EMP,DEPT
    WHERE ENAME = 'SMITH';

-- EQUI JOIN(동등 조인) 2개의 테이블에 동등한 필드가 있는경우
SELECT * FROM EMP, DEPT
    WHERE ENAME = 'SMITH' AND EMP.DEPTNO = DEPT.DEPTNO;

SELECT * FROM EMP, DEPT
    WHERE EMP.DEPTNO = DEPT.DEPTNO;

-- 테이블에 별명을 주면 별명만 계속 사용해야한다.    
SELECT E.*, D.DNAME FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO;
    
SELECT E.*, DNAME FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO;

-- 사번, 이름, 부서번호, 부서이름, 근무지
SELECT * FROM EMP;
SELECT * FROM DEPT;

SELECT EMPNO, ENAME, E.DEPTNO, DNAME, LOC FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

-- 사번, 이름 ,급여, 부서번호(부서코드), 부서명
SELECT EMPNO, ENAME, SAL, E.DEPTNO, DNAME FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

-- 이름, 업무, 급여 부서명, 근무지 급여가 2000이상
SELECT ENAME, JOB, SAL, DNAME, LOC FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO AND SAL >=2000;
    
-- 이름, 업무, 부서명, 근무지 근무지가 CHICAGO인 사람
SELECT ENAME, JOB, DNAME, LOC FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO AND LOC IN('CHICAGO');

-- 이름 ,업무, 근무지 DEPTNO이 10 또는 20인경우 급여순 정렬
SELECT ENAME, JOB, LOC FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO AND D.DEPTNO IN (10, 20)
ORDER BY SAL;

-- 이름, 급여, COMM, 연봉(별칭), 부서명, 근무지. 연봉=(SAL+COMM)*12 단 COMM이 NULL이면 0
SELECT ENAME, SAL, NVL(COMM,0), SAL*12+NVL(COMM,0) AS 연봉, DNAME, LOC FROM EMP E, DEPT D
WHERE E.DEPTNO= D.DEPTNO;

-- 위에서 JOB이 SALESMAN이거나 MANAGER를 대상으로 연봉이 큰 순서대로 출력
SELECT ENAME, SAL, NVL(COMM,0), SAL*12+NVL(COMM,0) AS 연봉, DNAME, LOC 
    FROM EMP E, DEPT D
    WHERE E.DEPTNO= D.DEPTNO AND JOB IN('SALESMAN','MANAGER')
    ORDER BY 연봉 DESC;

-- 이릌, 급여, 입사일, 부서코드(번호), 부서명. COMM이 NULL 이고 급여가 1200이상인경우
-- 부서명순 정렬. 부서명이 같으면 급여큰순
SELECT ENAME, SAL, HIREDATE, E.DEPTNO, DNAME
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO AND COMM IS NULL AND SAL >=1200
    ORDER BY DNAME ASC, SAL DESC;

-- 뉴욕에서 근무하는 사원의 이름과 급여를 출력하시오
SELECT ENAME, SAL  FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO AND LOC IN ('NEW YORK');

-- ACCOUNTING 부서 소속 사원의 이름과 입사일을 출력하시오
SELECT ENAME, HIREDATE FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO AND DNAME IN ('ACCOUNTING');

-- 직급이 MANAGER인 사원의 이름, 부서명을 출력하시오
SELECT ENAME, DNAME FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO AND JOB IN ('MANAGER');

-- Comm이 null이 아닌 사원의 이름, 급여, 부서코드, 근무지를 출력하시오.
SELECT ENAME, SAL, E.DEPTNO, LOC FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO AND COMM IS NOT NULL;

-----------------------------------------------------------------------
-- NON EQUI JOIN (동일한 필드가 없는 2개의 테이블을 JOIN)
-----------------------------------------------------------------------
SELECT * FROM EMP;
SELECT * FROM SALGRADE; -- 급여 등급 정보 테이블

SELECT ENAME, SAL, SALGRADE.* FROM EMP, SALGRADE
WHERE ENAME = 'SMITH' AND SAL BETWEEN LOSAL AND HISAL;

SELECT ENAME, SAL, GRADE||'등급' AS GRADE FROM EMP, SALGRADE
WHERE SAL BETWEEN LOSAL AND HISAL;

-- Comm이 null이 아닌 사원의 이름, 급여, 등급, 부서번호, 부서이름, 근무지를 출력하시오.
SELECT ENAME, SAL, GRADE, E.DEPTNO, DNAME, LOC FROM EMP E, DEPT D, SALGRADE S
WHERE E.DEPTNO = D.DEPTNO AND SAL BETWEEN LOSAL AND HISAL AND COMM IS NOT NULL;

-- 이름, 급여, 입사일, 급여등급
SELECT ENAME, SAL, HIREDATE, GRADE FROM EMP, SALGRADE
WHERE SAL BETWEEN LOSAL AND HISAL
ORDER BY GRADE DESC, SAL DESC;

-- 이름, 급여, 입사일, 급여등급, 부서명, 근무지
SELECT ENAME, SAL, HIREDATE, GRADE, DNAME, LOC FROM EMP E, DEPT D, SALGRADE
WHERE E.DEPTNO=D.DEPTNO AND SAL BETWEEN LOSAL AND HISAL
ORDER BY GRADE DESC;

-- 이름, 급여, 등급, 부서코드, 근무지. 단 comm 이 null아닌 경우
SELECT ENAME, SAL, GRADE, E.DEPTNO, LOC FROM EMP E, DEPT D, SALGRADE
WHERE E.DEPTNO=D.DEPTNO AND SAL BETWEEN LOSAL AND HISAL AND COMM IS NOT NULL;

-- 이름, 급여, 급여등급, 연봉, 부서명, 부서별 출력, 부서가 같으면 연봉순. 연봉=(sal+comm)*12 comm이 null이면 0
SELECT ENAME, SAL, GRADE, (SAL+NVL(COMM,0))*12 AS 연봉, DNAME
FROM EMP E, DEPT D, SALGRADE
WHERE E.DEPTNO=D.DEPTNO AND SAL BETWEEN LOSAL AND HISAL
ORDER BY DNAME, 연봉;

-- 이름, 업무, 급여, 등급, 부서코드, 부서명 출력. 급여가 1000~3000사이. 
-- 정렬조건 : 부서별, 부서같으면 업무별, 업무같으면 급여 큰순
SELECT ENAME, JOB, SAL, GRADE, E.DEPTNO, DNAME
FROM EMP E, DEPT D, SALGRADE
WHERE E.DEPTNO=D.DEPTNO AND SAL BETWEEN LOSAL AND HISAL AND SAL BETWEEN 1000 AND 3000
ORDER BY DNAME, JOB, SAL DESC;

-- 이름, 급여, 등급, 입사일, 근무지. 81년에 입사한 사람. 등급 큰순
SELECT ENAME, SAL, GRADE, TO_CHAR(HIREDATE, 'YYYY"년" MM"월" DD"일" DY"요일" HH24:MI:SS')AS 입사일, LOC FROM EMP E, DEPT D, SALGRADE
WHERE E.DEPTNO = D.DEPTNO 
AND SAL BETWEEN LOSAL AND HISAL 
AND TO_CHAR(HIREDATE,'YYYY') = '1981'
ORDER BY GRADE DESC;

----------------------------------------------------------------------------------------
-- (4) SELF JOIN : 한테이블을 서로 JOIN
----------------------------------------------------------------------------------------
SELECT EMPNO, ENAME, MGR FROM EMP; -- MGR : 내 직속상사의 사번

SELECT WORK.EMPNO, WORK.ENAME, WORK.MGR, MANAGER.EMPNO, MANAGER.ENAME
FROM EMP WORK, EMP MANAGER
WHERE WORK.ENAME = 'SMITH' AND WORK.MGR = MANAGER.EMPNO;

SELECT WORK.EMPNO, WORK.ENAME AS 사원, MANAGER.ENAME AS 직속상사
FROM EMP WORK, EMP MANAGER
WHERE WORK.MGR = MANAGER.EMPNO
ORDER BY EMPNO;


SELECT W.ENAME || '의 상사는 ' || M.ENAME||'이다'
FROM EMP W, EMP M
WHERE W.MGR= M.EMPNO;

-- 매니저가 KING인 사원들의 이름과 직급을 출력하시오.
SELECT W.ENAME, W.JOB FROM EMP W, EMP M
WHERE W.MGR=M.EMPNO AND M.ENAME = 'KING';

-- SCOTT과 동일한 부서번호에서 근무하는 사원의 이름을 출력하시오
SELECT M.ENAME FROM EMP E, EMP M
WHERE E.ENAME = 'SCOTT' AND E.DEPTNO=M.DEPTNO AND M.ENAME <> 'SCOTT';

-- SCOTT과 동일한 근무지에서 근무하는 사원의 이름을 출력하시오
-- 테이블 4개 이용 1단계
SELECT E1.ENAME, E1.DEPTNO, D1.DNAME, E2.ENAME, E2.DEPTNO, D2.DNAME
FROM EMP E1,DEPT D1, EMP E2, DEPT D2
WHERE E1.DEPTNO = D1.DEPTNO AND E2.DEPTNO=D2.DEPTNO -- EQUI JOIN조건
AND E1.ENAME = 'SCOTT' 
AND D1.LOC = D2.LOC; -- SELF JOIN 조건

-- 테이블 4개 이용 최종단계
SELECT E2.ENAME, E2.DEPTNO, D2.DNAME, D1.LOC
FROM EMP E1,DEPT D1, EMP E2, DEPT D2
WHERE E1.DEPTNO = D1.DEPTNO AND E2.DEPTNO=D2.DEPTNO -- EQUI JOIN조건
AND E1.ENAME = 'SCOTT' 
AND D1.LOC = D2.LOC
AND E2.ENAME <> 'SCOTT'; -- SELF JOIN 조건

------ TEST ------
SELECT * FROM EMP;
INSERT INTO DEPT VALUES (50,'IT','DALLAS');
SELECT * FROM DEPT;
INSERT INTO EMP VALUES(9999,'홍길동','MANAGER',7902,'19/12/20',1000,NULL,50);
ROLLBACK;
------ TEST ------

----------------------------------------------------------------------------------------
-- (5) OUTER JOIN : 조인 조건에 만족하지 않는 행을 나타나게 하는 조인
----------------------------------------------------------------------------------------
SELECT W.ENAME AS "부하", W.MGR, M.EMPNO, M.ENAME AS "직속상사"
FROM EMP W, EMP M
WHERE W.MGR=M.EMPNO(+);

-- XX의 매니저는 YY입니다.(없으면 '없음'으로)
SELECT W.ENAME || '의 매니저는 ' || NVL(M.ENAME, '없음') || '입니다.'
FROM EMP W, EMP M
WHERE W.MGR=M.EMPNO(+);

-- 말단 사원들 리스트
SELECT M.ENAME FROM EMP W, EMP M WHERE W.MGR(+)=M.EMPNO AND W.ENAME IS NULL;

-- EQUI JOIN에서 손실된 데이터
SELECT * FROM EMP;  --14명 (10,20,30)
SELECT * FROM DEPT; -- 4개부서 (10,20,30,40)
SELECT * FROM EMP, DEPT
WHERE EMP.DEPTNO(+)=DEPT.DEPTNO;

-- ★★★이름, 업무(JOB), 부서명(DNAME), 급여(SAL) 출력
-- (단,직원이 없는 부서명도 함께 출력 부서명정렬, 같으면 급여큰순정렬)
SELECT NVL(ENAME,'-'), NVL(JOB,'-'), DNAME, NVL(TO_CHAR(SAL,'9,999'),'-') 
FROM EMP E, DEPT D
WHERE E.DEPTNO(+)=D.DEPTNO
ORDER BY DNAME, SAL DESC;


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

SELECT * FROM EMP;
SELECT * FROM DEPT;
SELECT * FROM SALGRADE;

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
WHERE E.DEPTNO=D.DEPTNO AND COMM IS NOT NULL;

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
WHERE E1.MGR = E2.EMPNO AND E2.MGR=E3.EMPNO(+);




















