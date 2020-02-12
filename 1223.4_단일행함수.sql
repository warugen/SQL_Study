-- 2019.12.20 ~ 12.23 단일행 함수 (반대말 : 다중행함수=그룹함수)

SELECT ENAME, TO_CHAR(HIREDATE, 'YY-MM-DD DY"요일" AM HH:MI:SS') 
FROM EMP;

SELECT SUM(SAL) FROM EMP; -- EMP테이블의 SAL들의 합 -> 그룹함수(다중행함수)다.
SELECT DEPTNO, SUM(SAL) FROM EMP GROUP BY DEPTNO;

-- 단일행 함수의 종류 : 숫자관련함수, 문자처리함수, 날짜관련함수, 형변환함수, NULL, DECODE함수.....
------------------------------------------------------------------------------------------
-- (1) 숫자관련함수
------------------------------------------------------------------------------------------
SELECT ABS(-9) FROM EMP;
-- 아무 의미없는 1행짜리 테이블 : DUAL
SELECT * FROM DUAL;
SELECT ABS(-9) FROM DUAL;

-- 내림함수 
SELECT FLOOR(34.5678) FROM DUAL; -- 소수점 이하를 내림

SELECT FLOOR(34.5678*10)/10 FROM DUAL;

SELECT TRUNC(34.5678,2) FROM DUAL; -- 내릴 소수점 지정

SELECT TRUNC(156.54, -1) FROM DUAL; -- 마이너스는 정수단위에서 내림

SELECT TRUNC(156.54, -2) FROM DUAL; -- 마이너스는 정수단위에서 내림

-- 이름 SAL(백의자리 내림으로 출력)
SELECT ENAME, TRUNC(SAL, -2) FROM EMP;

-- 반올림함수 
SELECT ROUND(34.5678) FROM DUAL; -- 소수점에서 반올림
SELECT ROUND(34.5678, 1) FROM DUAL; -- 소수점 한자리까지에서 반올림
SELECT ROUND(34.5678, 3) FROM DUAL; -- 원하는 소수점자리까지 반올림
SELECT ROUND(34.5678, -1) FROM DUAL; 
-- 이름 SAL(백의자리 반올림으로 출력)
SELECT ENAME, ROUND(SAL,-3) FROM EMP;
-- 날짜도 적용가능

-- 올림함수
SELECT CEIL(34.5678) FROM DUAL; -- 소수점에서 올림
SELECT FLOOR(10/4) FROM DUAL;

SELECT POWER(3,2) FROM DUAL; -- 3의 2승

SELECT MOD(9,2) FROM DUAL; -- 나머지구하기
-- 홀수달에 입사한 직원들의 모든 필드 출력
SELECT * FROM EMP
WHERE MOD(TO_CHAR(HIREDATE, 'MM'), 2) = 1;

------------------------------------------------------------------------------------------
-- (2) 문자관련함수
------------------------------------------------------------------------------------------
SELECT UPPER('abcABC') FROM DUAL; -- 대문자로
SELECT LOWER('ABCabc') FROM DUAL; -- 소문자로

-- 첫번째문자만 대문자, 나머지는 소문자
SELECT INITCAP('abcabC') FROM DUAL;

-- JOB이 MANAGER인 직원의 모든 필드
SELECT * FROM EMP WHERE UPPER(JOB) = 'MANAGER';
SELECT * FROM EMP WHERE LOWER(JOB) = 'manager';

SELECT EMPNO, INITCAP(ENAME), INITCAP(JOB) FROM EMP;

-- CONCAT(A,B)
SELECT CONCAT('ABC','DEF') FROM DUAL;

SELECT CONCAT(CONCAT('ABC','DEF'),'GHI') FROM DUAL;

-- XXX는 JOB이다
SELECT CONCAT(CONCAT(ENAME, '는 '), CONCAT(JOB,'이다')) TITLE FROM EMP;

-- SUBSTR(STR, 시작할 위치, 추출할 갯수) 첫번째 위치는 1
SELECT SUBSTR('welcome to Oracle', 3,2) FROM DUAL;
SELECT SUBSTR('welcome to Oracle', -2,2) FROM DUAL; -- 임수일경우 문자끝에서부터 시작

-- 우리 시스템에서의 날짜 포맷 : 81/01/02
-- SUBSTR함수를 이용해서 짝수 일자에 입사한 직원의 모든 필드
SELECT * FROM EMP
WHERE MOD(SUBSTR(HIREDATE,-2,2),2)=0;

SELECT SUBSTR('안녕하세요 반갑습니다',3,2) FROM DUAL;

SELECT SUBSTRB('데이터베이스',4,6) FROM DUAL;


-- 9월에 입사한 사원의 모든 피드를 출력
-- like, substr(), to_char

SELECT * FROM EMP
WHERE HIREDATE LIKE '__/09/__';

SELECT * FROM EMP
WHERE SUBSTR(HIREDATE, 4,2) = '09';

SELECT * FROM EMP
WHERE TO_CHAR(HIREDATE, 'MM') = '09';

SELECT * FROM EMP
WHERE TO_CHAR(HIREDATE, 'MM') = 9;

SELECT SUBSTR('ABCD',2,3) FROM DUAL; -- 2번째 위치부터 3글자

SELECT SUBSTR('ABCD',2,3) FROM DUAL; -- 2번째 BYTE 위치부터 3BYTE 가져오기

SELECT SUBSTR('오라클디비' , 2,3) FROM DUAL; -- 2번째 위치부터 3글자
-- 2번째 BYTE 위치부터 3BYTE 가져오기 오라클익스프레스버전은 한글이 3바이트취급
-- 오라클 스탠다드는 한글을 2바이트씩 취급
SELECT SUBSTRB('오라클디비' , 4,6) FROM DUAL; 

-- LENGTH(문자):문자의 길이수, LENGTHB(문자):문자의 BYTE수
SELECT LENGTH('ABCD'), LENGTHB('ABCD') FROM DUAL;

SELECT LENGTH('오라클'), LENGTHB('오라클') FROM DUAL;

-- INSTR(STR, 찿을글자, (시작위치)): (시작위치부터)STR에서 찿을 글자의 위치를 반환
-- INSTR(STR, 찿을글자, (시작위치), K): (시작위치부터)STR에서 K번째 나오는 찿을 글자의 위치를 반환
SELECT INSTR('ABCABCABCABC','B') FROM DUAL;

SELECT INSTR('ABCABCABCABC','B',3) FROM DUAL;

SELECT INSTR('ABCABCABCABC','B',3,2) FROM DUAL; -- 3번째 위치부터 2번째 나오는 'B'를 찿는다

-- 9월에 입사한 직원들 모든 필드 출력
SELECT * FROM EMP WHERE INSTR(HIREDATE, '09') = 4;

-- LPAD(문자,10,'*') 문자를 10자리 확보하고 왼쪽 빈자리에 *를 채운다
SELECT LPAD('ORACLE', 20, '#') FROM DUAL;

-- RPAD((문자,10,'*') 문자를 10자리 확보하고 오른쪽 빈자리에 *를 채운다
SELECT RPAD('ORACLE', 20, '#') FROM DUAL;

SELECT ENAME, LPAD(SAL,6,'*') FROM EMP;

-- TRIM, LTRIM, RTRIM
SELECT TRIM('     ORACLE DB     ') TITLE FROM DUAL;

SELECT LTRIM('     ORACLE DB     ') TITLE FROM DUAL;

SELECT RTRIM('     ORACLE DB     ') TITLE FROM DUAL;

SELECT TRIM('a' FROM 'aaaORACLE DBaaa') FROM DUAL;

SELECT REPLACE('abcabc','a','999')FROM DUAL;


-- 83년도 입사한 직원의 모든 필드 출력하기
SELECT * FROM EMP WHERE SUBSTR(HIREDATE,1,2)='83';
SELECT * FROM EMP WHERE INSTR(HIREDATE, '83')=1;
SELECT * FROM EMP WHERE TO_CHAR(HIREDATE, 'YY') = '83';
SELECT * FROM EMP WHERE HIREDATE LIKE '83%';
-- 이름이 E로 끝나는 사원의 모든 필드 출력하기
SELECT * FROM EMP WHERE ENAME LIKE '%E';
SELECT * FROM EMP WHERE SUBSTR(ENAME,-1,1)='E';
SELECT * FROM EMP WHERE INSTR(ENAME, 'E', LENGTH(ENAME))=LENGTH(ENAME);
-- 이름이 E로 끝나는 사원의 이름(***E) 출력하기
SELECT LPAD(SUBSTR(ENAME,-1,1), LENGTH(ENAME),'*') FROM EMP
WHERE ENAME LIKE '%E';
-- 사번, 이름(S****), 직책, 입사일(81/09/**)
SELECT EMPNO, RPAD(SUBSTR(ENAME,1,1), LENGTH(ENAME),'*'), JOB, RPAD(SUBSTR(HIREDATE,1,6), LENGTH(HIREDATE),'*')
FROM EMP;

SELECT EMPNO, RPAD(SUBSTR(ENAME,1,1), LENGTH(ENAME),'*'), JOB, 
TO_CHAR(HIREDATE, 'YY/MM/**')
FROM EMP;

-- 사번, 이름 직책을 출력(직책은 이름의 문자열 수만큼만 표시)
SELECT EMPNO, ENAME, SUBSTR(JOB, 1, LENGTH(ENAME)) FROM EMP;

-- 82년 12월에 입사한 직원들의 모든 필드를 출력
SELECT * FROM EMP
WHERE HIREDATE LIKE '82/12/%';

SELECT * FROM EMP
WHERE HIREDATE BETWEEN '82/12/01' AND '82/12/31';

SELECT * FROM EMP
WHERE SUBSTR(HIREDATE, 1, 6) = '82/12/';

SELECT * FROM EMP
WHERE INSTR(HIREDATE, '82/12/') = 1;

-- 이름의 세번째 글자가 R인 사원의 이름을 출력
SELECT * FROM EMP
WHERE ENAME LIKE '__R%';

SELECT * FROM EMP
WHERE SUBSTR(ENAME, 3,1)='R';

SELECT * FROM EMP
WHERE INSTR(ENAME, 'R',3)=3;

------------------------------------------------------------------------------------------
-- (3) 날짜관련 예약어와 함수
------------------------------------------------------------------------------------------
SELECT SYSDATE "지금현재" FROM DUAL;

SELECT TO_CHAR(SYSDATE,'YY-MM-DD DY"요일" HH24:MI:SS') FROM DUAL;

SELECT SYSDATE-1 "어제", SYSDATE "오늘", SYSDATE+1 "내일" FROM DUAL;

SELECT TO_CHAR(SYSDATE+14, 'YY-MM-DD HH24"시"') FROM DUAL;

-- 이름, 입사일, 근무일자
SELECT ENAME, HIREDATE, FLOOR(SYSDATE-HIREDATE) "근무일자" FROM EMP;
SELECT ENAME, HIREDATE, TRUNC(SYSDATE-HIREDATE) "근무일자" FROM EMP;

SELECT ENAME, HIREDATE, TRUNC((SYSDATE-HIREDATE)/365) "근무년수" FROM EMP;

-- MONTHS_BETWEEN(특정날짜, 특정날짜):두 날짜간의 개월수
SELECT ENAME, HIREDATE, TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) "근무달수" FROM EMP;

-- ADD_MONTHS(특정날짜, N) : 특정날짜에서 N개월 후
-- 이름, 입사일, 수습기간마지막날(입사후6개월)
SELECT ENAME, HIREDATE, ADD_MONTHS(HIREDATE,6) FROM EMP;

-- NEXT_DAY(특정날짜, '수') 특정날짜로 처음 도래하는 수
SELECT SYSDATE, NEXT_DAY(SYSDATE,'토') FROM DUAL;

-- 이름, 입사일 입사후 맞는 첫 주말
SELECT ENAME, HIREDATE, NEXT_DAY(HIREDATE, '토') FROM EMP;

-- LAST_DAY(특정날짜) : 특정날짜인 달의 말일
SELECT ENAME, HIREDATE, LAST_DAY(HIREDATE) "월급날" FROM EMP;

SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- ROUND(반올림), TRUNC(버림) YEAR, MONTH, DAY, 생략
SELECT ROUND(SYSDATE, 'YEAR') FROM DUAL; -- YEAR반올림 결과 : 가까운 1월 1일

SELECT TRUNC(SYSDATE, 'YEAR') FROM DUAL; -- YEAR버림 결과 : 1월 1일

SELECT ROUND(SYSDATE, 'MONTH') FROM DUAL; -- MONTH반올림 결과 : 가까운 1일

SELECT TRUNC(SYSDATE, 'MONTH') FROM DUAL; -- MONTH 버림 결과 : 해당 달의 1일

SELECT ROUND(SYSDATE, 'DAY') FROM DUAL; -- DAY 반올림결과 : 해당 일자에서 가까운 일요일

SELECT ROUND(TO_DATE('19/12/26'), 'DAY') FROM DUAL;

SELECT TRUNC(TO_DATE('19/12/26'), 'DAY') FROM DUAL; -- DAY 버림 결과 : 전주 일요일
SELECT TRUNC(SYSDATE, 'DAY') FROM DUAL;

SELECT TO_CHAR(ROUND(SYSDATE), 'YY-MM-DD HH24:MI:SS') FROM DUAL; -- DEFAULT 반올림 결과 : 0시0분0초

SELECT TO_CHAR(TRUNC(SYSDATE), 'YY-MM-DD HH24:MI:SS') FROM DUAL;

-- ENAME, 입사일, 입사일달의 1일
SELECT ENAME, HIREDATE, TRUNC(HIREDATE,'MONTH') "입사한달" FROM EMP;

-- 이름, 입사일, 월급날(말일)
SELECT ENAME, HIREDATE, LAST_DAY(HIREDATE) "월급날" FROM EMP;
-- 이름, 입사일, 월급날(25일)
SELECT ENAME, HIREDATE, ROUND(TO_DATE(HIREDATE)-9,'MONTH')+24 FROM EMP; 
SELECT ENAME, HIREDATE, ROUND(HIREDATE-9,'MONTH')+24 FROM EMP; 
SELECT ROUND(TO_DATE('191224','YYMMDD')-9,'MONTH')+24 FROM DUAL;

-- 이름, 입사일, 월급날(17일)
SELECT ENAME, HIREDATE, ROUND(HIREDATE-1, 'MONTH')+16 FROM EMP; 

-- 이름 ,입사일, 월급, 이때까지 받은 월급합
SELECT ENAME, HIREDATE, SAL, SAL*12*TRUNC((SYSDATE-HIREDATE)/365) FROM EMP;

SELECT ENAME, HIREDATE, SAL, TRUNC((SYSDATE-HIREDATE)/365) FROM EMP;

SELECT ENAME, HIREDATE, SAL, SAL*TRUNC(MONTHS_BETWEEN(SYSDATE,HIREDATE)) FROM EMP;

SELECT ENAME, HIREDATE, SAL, NVL(COMM,0),
SAL*TRUNC(MONTHS_BETWEEN(SYSDATE,HIREDATE))+NVL(COMM,0) * TRUNC((SYSDATE-HIREDATE)/365) 
FROM EMP;


------------------------------------------------------------------------------------------
-- (4) 형변환 함수
------------------------------------------------------------------------------------------
-- TO_CHAR(날짜, 패턴) : 날짜를 문자로
-- YY(년도) MM(월) MON(월이름) DD(일) DY(요일) AM(오전/오후) HH(12시간) HH24(24시간단위) MI(분) SS(초)
-- 패턴내에 알파벳이나 특수문자 사용 가능 외래어일 경우 "" 안에
SELECT ENAME, SAL, TO_CHAR(HIREDATE, 'YY/MON/DD DY AM HH:MI:SS') FROM EMP;
SELECT TO_CHAR(SYSDATE, 'YY"년"MM"월"DD"일" DY AM HH"시"MI"분"SS"초"') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MM-DD') FROM DUAL;

-- TO_CHAR(숫자, 패턴) : 숫자를 문자로
-- 패턴에 올수있는것 : 0(자릿수항상 나타내기), 
--                    9(자릿수, 자릿수가 맞지 않으면 채우지 않는다)
--                    L(지역 통화단위표시)
--                    $($ 통화단위)
--                    , (천단위마다 콤마표시)

SELECT ENAME, SAL, TO_CHAR(SAL, 'L000,000.0') FROM EMP;
SELECT ENAME, SAL, TO_CHAR(SAL, '$999,999.9') FROM EMP;

-- TO_DATE(문자, 패턴) : 문자를 날짜형으로
-- DATE_FORMAT 을 모를때 81년5월1일부터 83년5월1일사이에 입사한 직원들의 모든필드
SELECT * FROM EMP
WHERE HIREDATE BETWEEN '81/05/01' AND '83/05/01';

SELECT * FROM EMP
WHERE HIREDATE BETWEEN TO_DATE('19810501','YYYYMMDD') AND TO_DATE('19830501','YYYYMMDD');

-- 2019,8,1 부터 오늘까지 날짜 계산
SELECT CEIL(SYSDATE - TO_DATE('20190801','YYYYMMDD')) FROM DUAL;

-- TO_NUMBER(문자, 패턴) : 문자를 숫자로 '9,876' -> 9876
SELECT TO_NUMBER('1,000', '9,999')+1000 FROM DUAL;


------------------------------------------------------------------------------------------
-- (5) NULL 관련 함수 = NVL(널일수있는데이터,널대신사용할값)
------------------------------------------------------------------------------------------
-- 사원이름, 상사의 이름(MGR이 널이면 'CEO'라고 출력)
SELECT W.ENAME 사원이름, NVL(M.ENAME,'CEO') 상사이름
FROM EMP W, EMP M
WHERE W.MGR=M.EMPNO(+);

-- 사원이름, MGR(MGR이 녈이면 'CEO')
SELECT ENAME, NVL(TO_CHAR(MGR,'9999'),'CEO') FROM EMP;

------------------------------------------------------------------------------------------
-- (6) DECODE(데이터, 값1, 결과1, 값2, 결과2, 값3, 결과3....... 값N, 결과N
------------------------------------------------------------------------------------------
SELECT DEPTNO, SUM(SAL) FROM EMP GROUP BY DEPTNO;

SELECT JOB, SUM(SAL) FROM EMP GROUP BY JOB;

SELECT ENAME, E.DEPTNO, DNAME FROM EMP E, DEPT D 
WHERE E.DEPTNO=D.DEPTNO;

SELECT ENAME, DEPTNO, DECODE(DEPTNO, 10,' ACCOUNTING', 20, 'RESEARCH', 30, 'SALES', 40, 'OPERATIONS','ETC') AS "DNAME"
FROM EMP;

SELECT ENAME, DEPTNO, CASE WHEN DEPTNO=10 THEN 'ACCOUNTING'
                           WHEN DEPTNO=20 THEN 'RESEARCH'
                           WHEN DEPTNO=30 THEN 'SALES'
                           WHEN DEPTNO=40 THEN 'OPERATIONS'
                           ELSE 'ETC' END AS "DNAME"
FROM EMP;

SELECT ENAME, DEPTNO, CASE DEPTNO WHEN 10 THEN 'ACCOUNTING'
                                WHEN 20 THEN 'RESEARCH'
                                WHEN 30 THEN 'SALES'
                                WHEN 40 THEN 'OPERATIONS' END AS "DNAME" FROM EMP;

-- 기존의 SAL을 이용해서 조정될 SAL은 JOB에따라 'ANALYST'10%인상 'SALESMAN' 20%인상, 'MANAGER" 30%인상, 'CLERK' 40%인상 그외 조정없으
-- 사번, 이름, 조정전 SAL, 조정후SAL

SELECT EMPNO, ENAME, JOB, SAL, CASE JOB WHEN 'ANALYST' THEN SAL*1.1
                                        WHEN 'SALESMAN' THEN SAL*1.2
                                        WHEN 'MANAGER' THEN SAL*1.3
                                        WHEN 'CLERK' THEN SAL*1.4 
                                        ELSE SAL END AS "조정후SAL" 
FROM EMP;

SELECT EMPNO, ENAME, JOB, SAL, DECODE(JOB, 'ANALYST', SAL*1.1, 'SALESMAN', SAL*1.2, 
                                           'MANAGER', SAL*1.3, 'CLERAK', SAL*1.4,SAL) AS "인상후SAL"
FROM EMP;

-- 입사한 년도만
SELECT TO_CHAR(HIREDATE, 'YYYY') FROM EMP; -- 문자열 '1980'

SELECT ENAME, EXTRACT(YEAR FROM HIREDATE) FROM EMP; --년도(1980)만 추출

SELECT ENAME, EXTRACT(MONTH FROM HIREDATE) FROM EMP;

------------------------------------------------------------------------------------------
-- (7) 그외
------------------------------------------------------------------------------------------
-- LEVEL, START, WITH, CONNECT BY PRIOR
SELECT LEVEL, LPAD(' ', LEVEL*2)||ENAME, MGR FROM EMP
WHERE ENAME != 'SCOTT'
    START WITH MGR IS NULL
    CONNECT BY PRIOR EMPNO = MGR; -- 윗레벨과 아랫레벨의 연결조건

--<셤 연습문제>
-- 1. 현재 날짜를 출력하고 TITLE에 “Current Date”로 출력하는 SELECT 문장을 기술하시오.
SELECT TO_CHAR(SYSDATE,'YY-MM-DD DY"요일"') "Current Date" 
FROM DUAL;

-- 2. EMP 테이블에서 현재 급여에 15%가 증가된 급여를 계산하여, 사원번호,이름,업무,급여,증가된 급여(New Salary),증가액(Increase)를 출력하는 SELECT 문장을 기술하시오.
SELECT EMPNO, ENAME, JOB, SAL, SAL*1.5 AS "New Salary", (SAL*1.5) - SAL AS "Increase" 
FROM EMP;

-- 3. EMP 테이블에서 이름, 입사일, 입사일로부터 6개월 후 돌아오는 월요일 구하여 출력하는 SELECT 문장을 기술하시오.
SELECT ENAME, HIREDATE, NEXT_DAY(ADD_MONTHS(HIREDATE,6), '월')
FROM EMP;

-- 4. EMP 테이블에서 이름, 입사일, 입사일로부터 현재까지의 개월수, 급여, 입사일부터 현재까지의 받은 급여의 총계를 출력하는 SELECT 문장을 기술하시오.
SELECT ENAME, HIREDATE, TRUNC(MONTHS_BETWEEN(SYSDATE,HIREDATE)) AS "WORK MONTH", TRUNC(MONTHS_BETWEEN(SYSDATE,HIREDATE))*SAL AS "TOTAL SAL"  
FROM EMP;

-- 5. EMP 테이블에서 모든 사원의 이름과 급여(15자리로 출력 좌측의 빈 곳은 “*”로 대치)를 출력하는 SELECT 문장을 기술하시오.
SELECT ENAME, LPAD(SAL, 15, '*')
FROM EMP;

-- 6. EMP 테이블에서 모든 사원의 정보를 이름,업무,입사일,입사한 요일을 출력하는 SELECT 문장을 기술하시오.
SELECT ENAME, JOB, HIREDATE, TO_CHAR(HIREDATE,'DY"요일"') AS 요일
FROM EMP;

-- 7. EMP 테이블에서 이름의 길이가 6자 이상인 사원의 정보를 이름,이름의 글자수,업무를 출력하는 SELECT 문장을 기술하시오.
SELECT ENAME, LENGTH(ENAME) AS "COUNT", JOB
FROM EMP
WHERE LENGTH(ENAME)>=6;

-- 8. EMP 테이블에서 모든 사원의 정보를 이름, 업무, 급여, 보너스, 급여+보너스를 출력하는 SELECT 문장을 기술하시오.
SELECT ENAME, JOB, SAL, NVL(COMM,0), SAL+NVL(COMM,0)
FROM EMP;

-- 9.사원 테이블의 사원명에서 2번째 문자부터 3개의 문자를 추출하시오. 
SELECT SUBSTR(ENAME, 2,3)
FROM EMP;

-- 10. 사원 테이블에서 입사일이 12월인 사원의 사번, 사원명, 입사일을 검색하시오. 
SELECT EMPNO, ENAME, HIREDATE
FROM EMP
WHERE SUBSTR(HIREDATE, 4,2) = '12';

-- 11. 다음과 같은 결과를 검색할 수 있는 SQL 문장을 작성하시오
-- EMPNO		ENAME		급여
-- 7369		SMITH		*******800
-- 7499		ALLEN		******1600
-- 7521		WARD		******1250
-- …….
SELECT EMPNO, ENAME, LPAD(SAL,10,'*')AS 급여
FROM EMP;

-- 12. 다음과 같은 결과를 검색할 수 있는 SQL 문장을 작성하시오
-- EMPNO	 ENAME 	입사일
-- 7369	  SMITH		1980-12-17
-- ….
SELECT EMPNO, ENAME, TO_CHAR(HIREDATE,'YYYY-MM-DD') AS 입사일
FROM EMP;

-- 13. 사원 테이블에서 급여에 따라 사번, 이름, 급여, 등급을 검색하는 SQL 문장을 작성 하시 오. 급여가 0~1000 E / 1001~2000 D / 2001~3000 C / 3001~4000 B / 4001~5000 A

--------급여가- 0~999 E / 1000~1999 D / 2000~2999 C / 3000~3999 B / 4000이상 A
SELECT EMPNO, ENAME, SAL, CASE WHEN SAL<=999 THEN 'E' 
                               WHEN SAL <= 1999 THEN 'D'
                               WHEN SAL <= 2999 THEN 'C'
                               WHEN SAL <= 3999 THEN 'B'
                               WHEN SAL >= 4000 THEN 'A'
                               END AS 등급
FROM EMP;
SELECT EMPNO, ENAME, SAL,
       CASE
          WHEN SAL BETWEEN 0 AND 999 THEN 'E'
          WHEN SAL BETWEEN 1000 AND 1999 THEN 'D'
          WHEN SAL BETWEEN 2000 AND 2999 THEN 'C'
          WHEN SAL BETWEEN 3000 AND 3999 THEN 'B'
          ELSE 'A'
       END 등급
FROM EMP;


-- 14. 사원 테이블에서 부서 번호가 20인 사원의 사번, 이름, 직무, 급여를 출력하시오.(급여는 앞에 $를 삽입하고3자리마다 ,를 출력한다)
SELECT EMPNO, ENAME, JOB, TO_CHAR(SAL, '$9,999,999') AS 급여
FROM EMP
WHERE DEPTNO IN (20);


