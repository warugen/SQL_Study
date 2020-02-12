------------------------------------------------------------------------------------------
-- VII. 테이블 생성 , 데이블 구조변경, 테이블 삭제  - DDL
------------------------------------------------------------------------------------------
--데이터입력(INSERT문), 데이터삭제(DELETE문), 데이터수정(UPDATE문), 데이터검색(SELECT문)  -> DML

-- 1.테이블생성
CREATE TABLE BOOK(
    BOOKID NUMBER(4),
    BOOKNAME VARCHAR2(100),
    PUBLISHER VARCHAR2(20),
    PRICE NUMBER(7),
    PRIMARY KEY(BOOKID)
    );

CREATE TABLE BOOK(
    BOOKID NUMBER(4) PRIMARY KEY,
    BOOKNAME VARCHAR2(100),
    PUBLISHER VARCHAR2(20),
    PRICE NUMBER(7)
    );

SELECT * FROM BOOK;

DESC BOOK;

SELECT * FROM EMP;

SELECT ROWNUM, EMPNO, ENAME FROM EMP; -- 테이블 출력시 논리적인 순서

SELECT ROWNUM, BOOKID, BOOKNAME, PRICE FROM BOOK;

-- EMP01 EMPNO(NUMBER4), ENAME(VARCHR2(20)), SAL(NUMBER(7,2))

CREATE TABLE EMP01 (
    EMPNO NUMBER(4),
    ENAME VARCHAR2(20),
    SAL NUMBER(7,2)
    );

SELECT * FROM EMP01;

-- DEPT01  -DEPTNO(NUMBER2), DNAME(VARCHAR2(14)), LOC(VARCHAR2(13))

CREATE TABLE DEPT01 (
    DEPTNO NUMBER(2),
    DNAME VARCHAR2(14),
    LOC VARCHAR2(13)
    );

SELECT * FROM DEPT01;

-- 서브쿼리를 이용한 CREATE TABLE
DESC EMP;
-- EMP테이블과 같은 구조 같은 데이터가 들어있는 EMP02테이블생성
CREATE TABLE EMP02 
    AS 
    SELECT * FROM EMP; -- SELECT 수행 결과가 EMP02로(구조와 데이터만, 제약조건은 생성X)

SELECT * FROM EMP02;
DESC EMP02;

-- EMP테이블의 사번, 이름, 부서번호만 EMP03으로 복사
CREATE TABLE EMP03
    AS
    SELECT EMPNO, ENAME, DEPTNO FROM EMP;
    
SELECT * FROM EMP03;
DESC EMP03;

-- EMP테이블의 이름, 급여만 복사한 EMP04 만들기
CREATE TABLE EMP04
    AS
    SELECT ENAME, SAL FROM EMP;
SELECT * FROM EMP04;

-- EMP테이블에서 10번 부서 직원의 모든 데이타 EMP05로 복사
CREATE TABLE EMP05
    AS
    SELECT * FROM EMP WHERE DEPTNO = 10;
SELECT * FROM EMP05;

-- EMP테이블 구조만 복사하고 데이터는 없는 테이블 EMP06만들기
CREATE TABLE EMP06
    AS
    SELECT * FROM EMP WHERE 1=0;
SELECT * FROM EMP06;

-- DEPT 테이블 구조만 복사한 DEPT02 테이블 생성(구조만복사)
CREATE TABLE DEPT02
    AS
    SELECT * FROM DEPT WHERE 1=0;

SELECT * FROM DEPT02;

SELECT * FROM TAB;

------------------------------------------------------------------------------------------
-- 테이블 구조 바꾸기 - ALTER TABLE
------------------------------------------------------------------------------------------

-- 새로운 필드 추가 - ALTER TABLE 테이블이름 ADD(필드이름 그 타입,....);
DESC EMP03;
ALTER TABLE EMP03 ADD (JOB VARCHAR2(10), SAL NUMBER(7,2));
ALTER TABLE EMP03 ADD (MGR NUMBER(4));

-- 현재필드의 타입 수정 ALTER TABLE 테이블이름 MODIFY(수정하고자하는 필드 타입);
ALTER TABLE EMP03 MODIFY(EMPNO VARCHAR2(5)); -- 불가(EMPNO필드에 데이터들이 있어서 불가능)
ALTER TABLE EMP03 MODIFY(JOB VARCHAR2(20));
ALTER TABLE EMP03 MODIFY(ENAME VARCHAR2(5)); -- 불가(ENAME필드에 이미 6자리 데이터가 들어있다.
ALTER TABLE EMP03 MODIFY(ENAME VARCHAR2(30)); -- 자리수를 늘리는건 가능
DESC EMP03;

-- 현재 있는 필드 삭제 -- ALTER TABLE 테이블 DROP COLUMN 필드명
-- 물리적인 삭제보다는 논리적인 삭제를 한후 접근하지 않는 시간에 물리적인 삭제를 하는경우가 일반적
ALTER TABLE EMP03 DROP COLUMN JOB;
SELECT * FROM EMP03;
ALTER TABLE EMP03 DROP COLUMN DEPTNO;

-- 논리적으로 특정 필드를 접근 못하도록 함 => 논리적인 필드 삭제
ALTER TABLE EMP03 SET UNUSED(SAL); -- 논리적으로 SAL필드 접근 불가
SELECT * FROM EMP03;
DESC EMP03;

ALTER TABLE EMP03 DROP UNUSED COLUMNS; -- 논리적으로 접근 불가한 필드들을 물리적으로 삭제


------------------------------------------------------------------------------------------
-- 테이블 삭제 : DROP TABLE 테이블이름;
------------------------------------------------------------------------------------------
DROP TABLE EMP01;
SELECT * FROM EMP01;

SELECT * FROM EMP02;
-- 테이블의 모든 데이터를 제거하는 명령(DDL:취소불가)
TRUNCATE TABLE EMP02;

-- DDL 명령어 수행하면 데이터 사전(시스템테이블)수정됨(오라클이수정)
-- 사용자는 데이터딕셔너리를 수정X, 검색X. 데이터딕셔너리뷰를 이용해서 검색가능
-- 데이터 딕셔너리뷰의 종류 DBA_XXX, ALL_XXX, USER_XXX
SELECT * FROM USER_TABLES;
SELECT TABLE_NAME FROM USER_TABLES;
SELECT * FROM USER_INDEXES;
SELECT * FROM USER_CONSTRAINTS;
SELECT * FROM USER_VIEWS;

SELECT * FROM DBA_TABLES;
SELECT TABLE_NAME FROM DBA_TABLES;
SELECT * FROM DBA_INDEXES;
SELECT * FROM DBA_CONSTRAINTS;
SELECT * FROM DBA_VIEWS;

SELECT * FROM ALL_TABLES;
SELECT TABLE_NAME FROM ALL_TABLES;
SELECT * FROM ALL_INDEXES;
SELECT * FROM ALL_CONSTRAINTS;
SELECT * FROM ALL_VIEWS;

SHOW USER;


-- DML(데이터추가, 데이터수정, 데이터삭제, 데이터검색)
-- 데이터 추가 INSERT INTO 테이블명(필드명1, 필드명2,....) VALUES(값1, 값2.....)
SELECT * FROM DEPT01;
INSERT INTO DEPT01(DEPTNO, DNAME, LOC) VALUES (10, '회계', '종로');
SELECT * FROM DEPT;

INSERT INTO DEPT(DEPTNO, DNAME, LOC) VALUES (NULL, 'IT', '종로'); -- 삽입불가 PRIMARY KEY 제약(중복값,NULL불가)

-- DEPT01에 (20,'IT',NULL) 추가
INSERT INTO DEPT01 ( DEPTNO, DNAME, LOC) VALUES(20,'IT',NULL);
-- DEPT01에 (30,'영업',NULL) 추가
INSERT INTO DEPT01 ( DEPTNO, DNAME) VALUES(30,'영업');

SELECT DEPTNO, DNAME, NVL(LOC,'사무실못얻음') FROM DEPT01;
INSERT INTO DEPT01 VALUES (40, '기획','용산');
SELECT * FROM DEPT01;

-- DEPT테이블의 내용을 DEPT02테이블에 추가
INSERT INTO DEPT02 SELECT * FROM DEPT WHERE DEPTNO < 40;
SELECT * FROM DEPT02;

-- 테이블 이름 변경
RENAME EMP2 TO EMP02;
SELECT * FROM EMP02;


-- 연습문제
DROP TABLE SAM01;
CREATE TABLE SAM01 (
    EMPNO NUMBER(4) PRIMARY KEY,
    ENAME VARCHAR2(10),
    JOB VARCHAR2(9),
    SAL NUMBER(7,2)
    );

SELECT * FROM SAM01;

INSERT INTO SAM01 VALUES(1000, 'APPLE', 'POLICE', 10000);
INSERT INTO SAM01 VALUES(1010, 'BANANA', 'NURSE', 15000);
INSERT INTO SAM01 VALUES(1020, 'ORANGE', 'DOCTOR', 25000);
INSERT INTO SAM01 VALUES(1030, 'VERY', NULL, 25000);
INSERT INTO SAM01 VALUES(1040, 'CAT', NULL, 2000);


INSERT INTO SAM01 SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE DEPTNO = 10;

SELECT EMPNO, ENAME, NVL(JOB,' '), SAL FROM SAM01;

------------------------------------------------------------------------------------------
-- 테이블 데이터 수정하기
-- UPDATE 테이블 이름 SET 필드명1=수정할값1, 필드명2=수정할값2 WHERE 조건;
------------------------------------------------------------------------------------------

SELECT * FROM EMP01;
CREATE TABLE EMP01 AS SELECT * FROM EMP;

UPDATE EMP01 SET DEPTNO=30;

-- 모든 직원의 SAL을 10% 인상시키는 UPDATE
UPDATE EMP01 SET SAL = SAL*1.1;

-- 모든 직원의 입사일을 지금으로 바꾸는 UPDATE
UPDATE EMP01 SET HIREDATE = SYSDATE;

-- 급여가 3000이상인 사원만 급여를 10%인상하는 UPDATE
UPDATE EMP01 SET SAL = SAL *1.1 WHERE SAL>=3000;

-- 근무지가 'DALLAS'인 사원만 SAL을 1000인상
UPDATE EMP01 SET SAL = SAL+1000
    WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE LOC  = 'DALLAS');
    
-- SCOTT사원의 부서번호를 20으로 직급은 MANAGER로
UPDATE EMP01 SET DEPTNO = 20, JOB='MANAGER' WHERE ENAME ='SCOTT';

-- SMITH의 입사일자를 오늘로, SAL은 5000으로 COMM은 400으로 수정
UPDATE EMP01 SET HIREDATE=SYSDATE, SAL=5000, COMM=400 WHERE ENAME='SMITH';

-- 20번 부서의 지역명을 40번 부서의 지역명으로 변경(DEPT01)
UPDATE DEPT01 SET LOC = (SELECT LOC FROM DEPT01 WHERE DEPTNO = 40) WHERE DEPTNO=20;

-- 30번 부서의 지역명, 부서명을 40번 부서의 지역명과 부서명으로 수정
UPDATE DEPT01 SET DNAME=(SELECT DNAME FROM DEPT01 WHERE DEPTNO=40),
                  LOC = (SELECT LOC FROM DEPT01 WHERE DEPTNO=40) WHERE DEPTNO=30;
                  
UPDATE DEPT01 SET (DNAME, LOC) = (SELECT DNAME, LOC FROM DEPT01 WHERE DEPTNO=40)
                   WHERE DEPTNO=30;

-- 모든 사원의 급여와 입사일을 KING과 같은 값으로 수정하는 UPDATE
SELECT SAL, HIREDATE FROM EMP01 WHERE ENAME='KING';
UPDATE EMP01 SET (SAL ,HIREDATE) = (SELECT SAL, HIREDATE FROM EMP01 WHERE ENAME='KING');

DELETE FROM DEPT01 WHERE DEPTNO=40;
INSERT INTO DEPT01 VALUES (40,'설계','용산');
DROP TABLE EMP01;
CREATE TABLE EMP01 AS SELECT * FROM EMP;
SELECT * FROM EMP01;
SELECT * FROM DEPT01;

------------------------------------------------------------------------------------------
-- 데이터 삭제 DELETE FROM 테이블이름 WHERE 조건;
------------------------------------------------------------------------------------------
SELECT * FROM DEPT01;
DELETE FROM DEPT01; -- DML은 ROLLBACK (DML쿼리만 취소) 불가
TRUNCATE TABLE DEPT01; -- DDL은 ROLLBACK 불가
ROLLBACK;

-- EMP01테이블에서 30번 부서 직원 삭제
DELETE FROM EMP01 WHERE DEPTNO=30;

-- SAM01테이블에 JOB이 NULL인 행 삭제
DELETE FROM SAM01 WHERE JOB IS NULL;
SELECT * FROM SAM01;

-- EMP01테이블에서 부서명이 'SALES'인 직원들 삭제
DELETE FROM EMP01 WHERE DEPTNO = (SELECT DEPTNO FROM DEPT01 WHERE DNAME='SALES');


------------------------------------------------------------------------------------------
-- 제약조건;
------------------------------------------------------------------------------------------
SELECT * FROM EMP;
SELECT * FROM DEPT;

INSERT INTO EMP (EMPNO, ENAME, DEPTNO)  VALUES(9999,'홍',50);

-- 제약조건에 따른 테이블 생성
DROP TABLE DEPT1;

CREATE TABLE DEPT1 (
    DEPTNO NUMBER(2) PRIMARY KEY,
    DENAME VARCHAR2(14) UNIQUE NOT NULL,
    LOC VARCHAR2(13) NOT NULL);

SELECT * FROM DEPT1;

DROP TABLE EMP1;
CREATE TABLE EMP1 (
    EMPNO NUMBER(4),
    ENAME VARCHAR2(10),
    JOB VARCHAR2(9) NOT NULL, -- NOT NULL 제약조건
    MGR NUMBER(4),
    HIREDATE DATE DEFAULT SYSDATE,
    SAL NUMBER(7,2) CHECK (SAL >= 0), -- 체크제약조건
    COMM NUMBER(7,2),
    DEPTNO NUMBER(2),-- 외래키(FOREING KEY) 제약조건
    PRIMARY KEY(EMPNO), --주키 제약조건
    UNIQUE(ENAME), -- 유니크 제약조건
    FOREIGN KEY(DEPTNO) REFERENCES DEPT1(DEPTNO)
    );

SELECT * FROM EMP1;

INSERT INTO DEPT1 VALUES(10,'회계','종로');
INSERT INTO DEPT1 VALUES(20,'설계','용산');
UPDATE DEPT1 SET DNAME='회계' WHERE DEPTNO=20; -- 중복제약조건때문에 실행불가
INSERT INTO DEPT1 VALUES(30,'전산','중구');

INSERT INTO EMP1 VALUES(1000,'SMITH','MANAGER',2000,'81/01/01',800,NULL,10);
INSERT INTO EMP1 (EMPNO,ENAME,JOB,SAL,DEPTNO) VALUES(2000,'SCOTT','SALESMAN',2000,30);
INSERT INTO EMP1 (EMPNO,ENAME,JOB,HIREDATE,SAL,DEPTNO) VALUES(3000,'WARD','SALESMAN',NULL,3000,20);

DROP TABLE EMP1;
DROP TABLE DEPT1;

COMMIT; --DML쿼리를 데이터베이스에 적용

-- 연습문제
-- 1.
DROP TABLE MY_DATA;
CREATE TABLE MY_DATA (
    ID NUMBER(4) PRIMARY KEY,
    NAME VARCHAR2(10),
    USERID VARCHAR2(30),
    SALARY NUMBER(10,2));

--2.
INSERT INTO MY_DATA VALUES(1,'Scott','sscoot',10000.00);
INSERT INTO MY_DATA VALUES(2,'Ford','fford',13000.00);
INSERT INTO MY_DATA VALUES(3,'Patel','ppatel',33000.00);
INSERT INTO MY_DATA VALUES(4,'Report','rreport',23500.00);
INSERT INTO MY_DATA VALUES(5,'Good','ggood',TO_NUMBER('44,450.00','99,999.99'));

-- 3.
SELECT * FROM MY_DATA;

-- 4.
COMMIT;

-- 6.
UPDATE MY_DATA SET SALARY = 65000.00
WHERE ID = 3;

COMMIT;

-- 7.
DELETE FROM MY_DATA WHERE NAME = 'Ford';
COMMIT;

-- 8.
UPDATE MY_DATA SET SALARY = 15000 
WHERE SALARY < 15000;

-- 9.
DROP TABLE MY_DATA;

-- PPT 4P
DROP TABLE BOOK;
DROP TABLE BOOKKIND;

CREATE TABLE BOOKKIND (
    BOOKCODE NUMBER(4),
    BOOKKIND VARCHAR2(15),
    LOC VARCHAR2(16),
    PRIMARY KEY(BOOKCODE)
    );

INSERT INTO BOOKKIND VALUES(100,'철학','3층 인문실');
INSERT INTO BOOKKIND VALUES(200,'인문','3층 인문실');
INSERT INTO BOOKKIND VALUES(300,'자연과학','4층 과학실');
INSERT INTO BOOKKIND VALUES(400,'IT','4층 과학실');

SELECT * FROM BOOKKIND;

CREATE TABLE BOOK (
    BOOKCODE NUMBER(4),
    BOOKID VARCHAR2(6),
    BOOKNAME VARCHAR2(20),
    PUBLISHER VARCHAR2(20),
    PUBYER NUMBER(4),
    PRIMARY KEY(BOOKID),
    FOREIGN KEY(BOOKCODE) REFERENCES BOOKKIND(BOOKCODE)
    );

INSERT INTO BOOK VALUES(100,'100A01','철학자의 삶','더존출판',2017);
INSERT INTO BOOK VALUES(400,'400A01','이것이 DB다','더존출판',2018);

SELECT * FROM BOOK;

-- PPT 5P
DROP TABLE STUDENT;
DROP TABLE MAJOR;

CREATE TABLE MAJOR (
    MAJOR_CODE NUMBER(1),
    MAJOR_NAME VARCHAR2(30),
    OFFICE_LOC VARCHAR2(16),
    PRIMARY KEY(MAJOR_CODE)
    );
    
CREATE TABLE STUDENT (
    HAKBUN VARCHAR2(3),
    NAME VARCHAR2(12),
    SOCRE NUMBER(3),
    MAJOR_CODE NUMBER(1),
    PRIMARY KEY(HAKBUN),
    FOREIGN KEY(MAJOR_CODE) REFERENCES MAJOR(MAJOR_CODE)
    );


INSERT INTO MAJOR VALUES(1,'경영정보','3층 인문실');
INSERT INTO MAJOR VALUES(2,'소프트웨어공학','3층 인문실');
INSERT INTO MAJOR VALUES(3,'디자인','4층 과학실');
INSERT INTO MAJOR VALUES(4,'경제','4층 과학실');
    
SELECT * FROM MAJOR;

INSERT INTO STUDENT VALUES('A01','김길동',100,1);
INSERT INTO STUDENT VALUES('A02','문길동',90,2);
INSERT INTO STUDENT VALUES('A03','홍길동',95,1);

SELECT * FROM STUDENT;
