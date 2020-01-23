SHOW databases;

CREATE database kimdb; -- 데이타베이스 만들기
-- kimdb를 사용하겠다고 선언
use kimdb;
use world;

show tables; -- select * from tab; 과 같은명령어
select * from city;

USE KIMDB;
SELECT DATABASE(); -- 현재 위치한 데이타베이스확인

DROP TABLE if exists MAJOR;
CREATE TABLE MAJOR(
	MAJOR_CODE INT PRIMARY KEY auto_increment,
    MAJOR_NAME VARCHAR(30));
INSERT INTO MAJOR (MAJOR_NAME) VALUES('경영정보');
INSERT INTO MAJOR (MAJOR_NAME) VALUES('저나공학');
INSERT INTO MAJOR (MAJOR_NAME) VALUES('화학공학');
SELECT * FROM MAJOR;

DESC MAJOR;

DROP TABLE IF EXISTS STUDENT;
CREATE TABLE STUDENT (
	STU_ID INT PRIMARY KEY,
    NAME VARCHAR(15),
    MAJOR_CODE INT ,
    -- MYSQL은 제약조건은 맨 마지막에 적어준다
    FOREIGN KEY(MAJOR_CODE) REFERENCES MAJOR(MAJOR_CODE));
    
INSERT INTO STUDENT VALUES(1001,'홍길동',1);
INSERT INTO STUDENT VALUES(1002,'김길동',2);
INSERT INTO STUDENT VALUES(1003,'고길동',9);

SELECT * FROM STUDENT;

SELECT * FROM STUDENT S, MAJOR M
WHERE S.MAJOR_CODE=M.MAJOR_CODE;

SELECT * FROM STUDENT S LEFT JOIN MAJOR M
ON S.MAJOR_CODE=M.MAJOR_CODE; -- MYSQL용 OUTER JOIN문법

-- 자바(JDBC)수업시간에 쓸 테이블
DROP TABLE IF EXISTS DIVISION;
CREATE TABLE DIVISION (
	DNO INT PRIMARY KEY, -- 부서번호(부서코드)
    DNAME VARCHAR(20) NOT NULL, -- 부서이름
    PHONE VARCHAR(20) UNIQUE, -- 부서전화
    POSITION VARCHAR(20)); -- 부서위치
SHOW TABLES;

CREATE TABLE PERSONAL (
	PNO INT PRIMARY KEY,		-- 사번
    PNAME VARCHAR(10) NOT NULL,	-- 이름
    JOB VARCHAR(15) NOT NULL,	-- 직책
    MANAGER INT,				-- 직속상사의 사번
    STARTDATE DATE,				-- 입사일
    PAY INT,					-- 급여
    BONUS INT,					-- 보너스
    DNO INT,					-- 부서번호
    FOREIGN KEY(DNO) REFERENCES DIVISION(DNO));
INSERT INTO DIVISION VALUES (10, 'FINANCE', '02-777-7777', '종로');
INSERT INTO DIVISION VALUES (20, 'RESEARCH', '041-676-5677', '대전');
INSERT INTO DIVISION VALUES (30, 'SALES', '031-777-8888', '인천');
INSERT INTO DIVISION VALUES (40, 'MARKETING', '02-555-5555', '강남');

insert into personal values (1111,'smith','manager', 1001, '1990-12-17', 1000, null, 10);
insert into personal values (1112,'ally','salesman',1116,'1991-02-20',1600,500,30);
insert into personal values (1113,'word','salesman',1116,'1992-02-24',1450,300,30);
insert into personal values (1114,'james','manager',1001,'1990-04-12',3975,null,20);
insert into personal values (1001,'bill','president',null,'1989-01-10',7000,null,10);
insert into personal values (1116,'johnson','manager',1001,'1991-05-01',3550,null,30);
insert into personal values (1118,'martin','analyst',1111,'1991-09-09',3450,null,10);
insert into personal values (1121,'kim','clerk',1114,'1990-12-08',4000,null,20);
insert into personal values (1123,'lee','salesman',1116,'1991-09-23',1200,0,30);
insert into personal values (1226,'park','analyst',1111,'1990-01-03',2500,null,10);
SELECT * FROM PERSONAL;

-- 1. 사번, 이름, 급여를 출력
SELECT PNO, PNAME, PAY FROM PERSONAL;

-- 2. 급여가 2000~5000 사이 모든 직원의 모든 필드
SELECT * FROM PERSONAL
WHERE PAY BETWEEN 2000 AND 5000;

SELECT * FROM PERSONAL
WHERE PAY >=2000 && PAY <=5000; -- AND(&&), OR(||)

-- 3. 부서번호가 10또는 20인 사원의 사번, 이름, 부서번호
SELECT PNO, PNAME, DNO
FROM PERSONAL 
WHERE DNO IN (10,20)
ORDER BY DNO DESC;

-- 4. 보너스가 null인 사원의 사번, 이름, 급여 급여 큰 순정렬
SELECT PNO, PNAME, PAY
FROM PERSONAL
WHERE BONUS IS NULL
ORDER BY PAY DESC;

-- 5. 사번, 이름, 부서번호, 급여. 부서코드 순 정열 같으면 큰 순
SELECT PNO, PNAME, DNO, PAY
FROM PERSONAL 
ORDER BY DNO DESC;

-- 6. 사번, 이름, 부서명
SELECT PNO, PNAME, DNAME
FROM PERSONAL P, DIVISION D
WHERE P.DNO=D.DNO;

-- 7. 사번, 이름, 상사이름
SELECT P.PNO, P.PNAME, M.PNAME AS '상사'
FROM PERSONAL P, PERSONAL M
WHERE P.MANAGER = M.PNO;

-- 8. 사번, 이름, 상사이름(상사가 없는 사람도 출력)
SELECT P.PNO, P.PNAME, M.PNAME
FROM PERSONAL P LEFT OUTER JOIN PERSONAL M
ON P.MANAGER = M.PNO;

-- IFNULL() NVL()과 같다
SELECT P.PNO, P.PNAME, IFNULL(M.PNAME,'없음') 상사
FROM PERSONAL P LEFT OUTER JOIN PERSONAL M
ON P.MANAGER = M.PNO;

SELECT P.PNO, P.PNAME, IF(M.PNAME IS NULL,'없음',M.PNAME) 상사
FROM PERSONAL P LEFT OUTER JOIN PERSONAL M
ON P.MANAGER = M.PNO;

-- 9. 이름이 s로 시작하는 사원 이름
SELECT PNAME
FROM PERSONAL
WHERE PNAME LIKE 's%';

SELECT PNAME FROM PERSONAL WHERE SUBSTR(PNAME,1,1)='s';

-- 10. 사번, 이름, 급여, 부서명, 상사이름
SELECT P.PNO, P.PNAME, P.PAY, DNAME, M.PNAME
FROM PERSONAL P, PERSONAL M, DIVISION D
WHERE P.DNO=D.DNO AND P.MANAGER = M.PNO;

-- 11. 부서코드, 급여합계, 최대급여
SELECT DNO, SUM(PAY), MAX(PAY)
FROM PERSONAL
GROUP BY DNO;

-- 12. 부서명, 급여평균, 인원수
SELECT DNAME, AVG(PAY), COUNT(*)
FROM PERSONAL P, DIVISION D
WHERE P.DNO=D.DNO
GROUP BY DNAME;

-- 13. 부서코드, 급여합계, 인원수 인원수가 4명 이상인 부서만 출력
SELECT DNO, SUM(PAY), COUNT(*)
FROM PERSONAL
GROUP BY DNO
HAVING COUNT(*) >= 4;

-- 14. 사번, 이름, 급여 회사에서 제일 급여를 많이 받는 사람
SELECT PNO, PNAME, PAY
FROM PERSONAL
WHERE PAY = (SELECT MAX(PAY) FROM PERSONAL );

-- 15. 회사 평균보다 급여를 많이 받는 사람 이름, 급여
SELECT PNAME, PAY
FROM PERSONAL
WHERE PAY > ( SELECT AVG(PAY) FROM PERSONAL);

-- 16. 15번에 부서명을 추가하고 부서명순 정열 같으면 급여 큰순
SELECT PNAME, PAY, DNAME
FROM PERSONAL P, DIVISION D
WHERE P.DNO=D.DNO && PAY > ( SELECT AVG(PAY) FROM PERSONAL)
ORDER BY DNAME, PAY DESC;

-- 17. 자기부서평균보다 급여를 많이 받는 사람 이름, 급여
SELECT PNAME, PAY FROM PERSONAL P
WHERE PAY>(SELECT AVG(PAY) FROM PERSONAL WHERE P.DNO=DNO);

-- 18. 입사가 가장 빠른 사람의 이름, 급여, 부서명
 SELECT PNAME, PAY, DNAME 
 FROM PERSONAL P, DIVISION D
 WHERE P.DNO=D.DNO 
 AND STARTDATE = (SELECT MIN(STARTDATE) FROM PERSONAL);
 
-- 19. 이름, 급여, 해당부서평균
SELECT PNAME, PAY, (SELECT AVG(PAY) FROM PERSONAL WHERE DNO = P.DNO)
FROM PERSONAL P;

-- 20. 이름, 급여, 부서명, 해당부서평균
SELECT PNAME, PAY, DNAME, (SELECT AVG(PAY) FROM PERSONAL WHERE DNO = P.DNO)
FROM PERSONAL P, DIVISION D
WHERE P.DNO=D.DNO;

-- 오라클과 다소 다른 단일행 함수(컬럼함수)
SELECT CONCAT(PNAME,'(',JOB,')의 급여는 ',PAY) FROM PERSONAL;

SELECT ROUND(114.75,1); -- FROM절 생략 가능
SELECT YEAR(STARTDATE) FROM PERSONAL;
SELECT MONTH(STARTDATE) FROM PERSONAL;
SELECT MONTHNAME(STARTDATE) FROM PERSONAL;
SELECT DAYNAME(STARTDATE) FROM PERSONAL;
SELECT SYSDATE();
SELECT NOW();
SELECT CURRENT_DATE();
SELECT CURRENT_TIME();
SELECT DATE_FORMAT(STARTDATE, '%Y년%M월%E %a %p %h시 %i분') FROM PERSONAL;
SELECT DATE_FORMAT(NOW(), '%y년%m월%e일 %a %H시 %i분');

-- 이름, 급여, 높다 또는 낮다 (3000기준)
SELECT PNAME, PAY, IF(PAY>=3000,'높다','낮다') FROM PERSONAL;

-- TOP N 구문
SELECT PNAME, PAY FROM PERSONAL ORDER BY PAY DESC LIMIT 0, 3; -- 1등부터 3개 출력(MYSQL은 0등부터 시작)
SELECT PNAME, PAY FROM PERSONAL ORDER BY PAY DESC LIMIT 3, 3; -- 4등부터 6등까지

SELECT PNAME, FORMAT(PAY,0) FROM PERSONAL; -- 3자리마다 콤마표시
SELECT PNAME, FORMAT(PAY,1) FROM PERSONAL; -- 3자리마다 콤마표시 후 소수점 1자리 까지 출력















