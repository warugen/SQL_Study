------------------------------------------------------------------------------------------
-- VII. ���̺� ���� , ���̺� ��������, ���̺� ����  - DDL
------------------------------------------------------------------------------------------
--�������Է�(INSERT��), �����ͻ���(DELETE��), �����ͼ���(UPDATE��), �����Ͱ˻�(SELECT��)  -> DML

-- 1.���̺����
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

SELECT ROWNUM, EMPNO, ENAME FROM EMP; -- ���̺� ��½� ������ ����

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

-- ���������� �̿��� CREATE TABLE
DESC EMP;
-- EMP���̺�� ���� ���� ���� �����Ͱ� ����ִ� EMP02���̺����
CREATE TABLE EMP02 
    AS 
    SELECT * FROM EMP; -- SELECT ���� ����� EMP02��(������ �����͸�, ���������� ����X)

SELECT * FROM EMP02;
DESC EMP02;

-- EMP���̺��� ���, �̸�, �μ���ȣ�� EMP03���� ����
CREATE TABLE EMP03
    AS
    SELECT EMPNO, ENAME, DEPTNO FROM EMP;
    
SELECT * FROM EMP03;
DESC EMP03;

-- EMP���̺��� �̸�, �޿��� ������ EMP04 �����
CREATE TABLE EMP04
    AS
    SELECT ENAME, SAL FROM EMP;
SELECT * FROM EMP04;

-- EMP���̺��� 10�� �μ� ������ ��� ����Ÿ EMP05�� ����
CREATE TABLE EMP05
    AS
    SELECT * FROM EMP WHERE DEPTNO = 10;
SELECT * FROM EMP05;

-- EMP���̺� ������ �����ϰ� �����ʹ� ���� ���̺� EMP06�����
CREATE TABLE EMP06
    AS
    SELECT * FROM EMP WHERE 1=0;
SELECT * FROM EMP06;

-- DEPT ���̺� ������ ������ DEPT02 ���̺� ����(����������)
CREATE TABLE DEPT02
    AS
    SELECT * FROM DEPT WHERE 1=0;

SELECT * FROM DEPT02;

SELECT * FROM TAB;

------------------------------------------------------------------------------------------
-- ���̺� ���� �ٲٱ� - ALTER TABLE
------------------------------------------------------------------------------------------

-- ���ο� �ʵ� �߰� - ALTER TABLE ���̺��̸� ADD(�ʵ��̸� �� Ÿ��,....);
DESC EMP03;
ALTER TABLE EMP03 ADD (JOB VARCHAR2(10), SAL NUMBER(7,2));
ALTER TABLE EMP03 ADD (MGR NUMBER(4));

-- �����ʵ��� Ÿ�� ���� ALTER TABLE ���̺��̸� MODIFY(�����ϰ����ϴ� �ʵ� Ÿ��);
ALTER TABLE EMP03 MODIFY(EMPNO VARCHAR2(5)); -- �Ұ�(EMPNO�ʵ忡 �����͵��� �־ �Ұ���)
ALTER TABLE EMP03 MODIFY(JOB VARCHAR2(20));
ALTER TABLE EMP03 MODIFY(ENAME VARCHAR2(5)); -- �Ұ�(ENAME�ʵ忡 �̹� 6�ڸ� �����Ͱ� ����ִ�.
ALTER TABLE EMP03 MODIFY(ENAME VARCHAR2(30)); -- �ڸ����� �ø��°� ����
DESC EMP03;

-- ���� �ִ� �ʵ� ���� -- ALTER TABLE ���̺� DROP COLUMN �ʵ��
-- �������� �������ٴ� ������ ������ ���� �������� �ʴ� �ð��� �������� ������ �ϴ°�찡 �Ϲ���
ALTER TABLE EMP03 DROP COLUMN JOB;
SELECT * FROM EMP03;
ALTER TABLE EMP03 DROP COLUMN DEPTNO;

-- �������� Ư�� �ʵ带 ���� ���ϵ��� �� => ������ �ʵ� ����
ALTER TABLE EMP03 SET UNUSED(SAL); -- �������� SAL�ʵ� ���� �Ұ�
SELECT * FROM EMP03;
DESC EMP03;

ALTER TABLE EMP03 DROP UNUSED COLUMNS; -- �������� ���� �Ұ��� �ʵ���� ���������� ����


------------------------------------------------------------------------------------------
-- ���̺� ���� : DROP TABLE ���̺��̸�;
------------------------------------------------------------------------------------------
DROP TABLE EMP01;
SELECT * FROM EMP01;

SELECT * FROM EMP02;
-- ���̺��� ��� �����͸� �����ϴ� ���(DDL:��ҺҰ�)
TRUNCATE TABLE EMP02;

-- DDL ��ɾ� �����ϸ� ������ ����(�ý������̺�)������(����Ŭ�̼���)
-- ����ڴ� �����͵�ųʸ��� ����X, �˻�X. �����͵�ųʸ��並 �̿��ؼ� �˻�����
-- ������ ��ųʸ����� ���� DBA_XXX, ALL_XXX, USER_XXX
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


-- DML(�������߰�, �����ͼ���, �����ͻ���, �����Ͱ˻�)
-- ������ �߰� INSERT INTO ���̺��(�ʵ��1, �ʵ��2,....) VALUES(��1, ��2.....)
SELECT * FROM DEPT01;
INSERT INTO DEPT01(DEPTNO, DNAME, LOC) VALUES (10, 'ȸ��', '����');
SELECT * FROM DEPT;

INSERT INTO DEPT(DEPTNO, DNAME, LOC) VALUES (NULL, 'IT', '����'); -- ���ԺҰ� PRIMARY KEY ����(�ߺ���,NULL�Ұ�)

-- DEPT01�� (20,'IT',NULL) �߰�
INSERT INTO DEPT01 ( DEPTNO, DNAME, LOC) VALUES(20,'IT',NULL);
-- DEPT01�� (30,'����',NULL) �߰�
INSERT INTO DEPT01 ( DEPTNO, DNAME) VALUES(30,'����');

SELECT DEPTNO, DNAME, NVL(LOC,'�繫�Ǹ�����') FROM DEPT01;
INSERT INTO DEPT01 VALUES (40, '��ȹ','���');
SELECT * FROM DEPT01;

-- DEPT���̺��� ������ DEPT02���̺� �߰�
INSERT INTO DEPT02 SELECT * FROM DEPT WHERE DEPTNO < 40;
SELECT * FROM DEPT02;

-- ���̺� �̸� ����
RENAME EMP2 TO EMP02;
SELECT * FROM EMP02;


-- ��������
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
-- ���̺� ������ �����ϱ�
-- UPDATE ���̺� �̸� SET �ʵ��1=�����Ұ�1, �ʵ��2=�����Ұ�2 WHERE ����;
------------------------------------------------------------------------------------------

SELECT * FROM EMP01;
CREATE TABLE EMP01 AS SELECT * FROM EMP;

UPDATE EMP01 SET DEPTNO=30;

-- ��� ������ SAL�� 10% �λ��Ű�� UPDATE
UPDATE EMP01 SET SAL = SAL*1.1;

-- ��� ������ �Ի����� �������� �ٲٴ� UPDATE
UPDATE EMP01 SET HIREDATE = SYSDATE;

-- �޿��� 3000�̻��� ����� �޿��� 10%�λ��ϴ� UPDATE
UPDATE EMP01 SET SAL = SAL *1.1 WHERE SAL>=3000;

-- �ٹ����� 'DALLAS'�� ����� SAL�� 1000�λ�
UPDATE EMP01 SET SAL = SAL+1000
    WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE LOC  = 'DALLAS');
    
-- SCOTT����� �μ���ȣ�� 20���� ������ MANAGER��
UPDATE EMP01 SET DEPTNO = 20, JOB='MANAGER' WHERE ENAME ='SCOTT';

-- SMITH�� �Ի����ڸ� ���÷�, SAL�� 5000���� COMM�� 400���� ����
UPDATE EMP01 SET HIREDATE=SYSDATE, SAL=5000, COMM=400 WHERE ENAME='SMITH';

-- 20�� �μ��� �������� 40�� �μ��� ���������� ����(DEPT01)
UPDATE DEPT01 SET LOC = (SELECT LOC FROM DEPT01 WHERE DEPTNO = 40) WHERE DEPTNO=20;

-- 30�� �μ��� ������, �μ����� 40�� �μ��� ������� �μ������� ����
UPDATE DEPT01 SET DNAME=(SELECT DNAME FROM DEPT01 WHERE DEPTNO=40),
                  LOC = (SELECT LOC FROM DEPT01 WHERE DEPTNO=40) WHERE DEPTNO=30;
                  
UPDATE DEPT01 SET (DNAME, LOC) = (SELECT DNAME, LOC FROM DEPT01 WHERE DEPTNO=40)
                   WHERE DEPTNO=30;

-- ��� ����� �޿��� �Ի����� KING�� ���� ������ �����ϴ� UPDATE
SELECT SAL, HIREDATE FROM EMP01 WHERE ENAME='KING';
UPDATE EMP01 SET (SAL ,HIREDATE) = (SELECT SAL, HIREDATE FROM EMP01 WHERE ENAME='KING');

DELETE FROM DEPT01 WHERE DEPTNO=40;
INSERT INTO DEPT01 VALUES (40,'����','���');
DROP TABLE EMP01;
CREATE TABLE EMP01 AS SELECT * FROM EMP;
SELECT * FROM EMP01;
SELECT * FROM DEPT01;

------------------------------------------------------------------------------------------
-- ������ ���� DELETE FROM ���̺��̸� WHERE ����;
------------------------------------------------------------------------------------------
SELECT * FROM DEPT01;
DELETE FROM DEPT01; -- DML�� ROLLBACK (DML������ ���) �Ұ�
TRUNCATE TABLE DEPT01; -- DDL�� ROLLBACK �Ұ�
ROLLBACK;

-- EMP01���̺��� 30�� �μ� ���� ����
DELETE FROM EMP01 WHERE DEPTNO=30;

-- SAM01���̺� JOB�� NULL�� �� ����
DELETE FROM SAM01 WHERE JOB IS NULL;
SELECT * FROM SAM01;

-- EMP01���̺��� �μ����� 'SALES'�� ������ ����
DELETE FROM EMP01 WHERE DEPTNO = (SELECT DEPTNO FROM DEPT01 WHERE DNAME='SALES');


------------------------------------------------------------------------------------------
-- ��������;
------------------------------------------------------------------------------------------
SELECT * FROM EMP;
SELECT * FROM DEPT;

INSERT INTO EMP (EMPNO, ENAME, DEPTNO)  VALUES(9999,'ȫ',50);

-- �������ǿ� ���� ���̺� ����
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
    JOB VARCHAR2(9) NOT NULL, -- NOT NULL ��������
    MGR NUMBER(4),
    HIREDATE DATE DEFAULT SYSDATE,
    SAL NUMBER(7,2) CHECK (SAL >= 0), -- üũ��������
    COMM NUMBER(7,2),
    DEPTNO NUMBER(2),-- �ܷ�Ű(FOREING KEY) ��������
    PRIMARY KEY(EMPNO), --��Ű ��������
    UNIQUE(ENAME), -- ����ũ ��������
    FOREIGN KEY(DEPTNO) REFERENCES DEPT1(DEPTNO)
    );

SELECT * FROM EMP1;

INSERT INTO DEPT1 VALUES(10,'ȸ��','����');
INSERT INTO DEPT1 VALUES(20,'����','���');
UPDATE DEPT1 SET DNAME='ȸ��' WHERE DEPTNO=20; -- �ߺ��������Ƕ����� ����Ұ�
INSERT INTO DEPT1 VALUES(30,'����','�߱�');

INSERT INTO EMP1 VALUES(1000,'SMITH','MANAGER',2000,'81/01/01',800,NULL,10);
INSERT INTO EMP1 (EMPNO,ENAME,JOB,SAL,DEPTNO) VALUES(2000,'SCOTT','SALESMAN',2000,30);
INSERT INTO EMP1 (EMPNO,ENAME,JOB,HIREDATE,SAL,DEPTNO) VALUES(3000,'WARD','SALESMAN',NULL,3000,20);

DROP TABLE EMP1;
DROP TABLE DEPT1;

COMMIT; --DML������ �����ͺ��̽��� ����

-- ��������
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

INSERT INTO BOOKKIND VALUES(100,'ö��','3�� �ι���');
INSERT INTO BOOKKIND VALUES(200,'�ι�','3�� �ι���');
INSERT INTO BOOKKIND VALUES(300,'�ڿ�����','4�� ���н�');
INSERT INTO BOOKKIND VALUES(400,'IT','4�� ���н�');

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

INSERT INTO BOOK VALUES(100,'100A01','ö������ ��','��������',2017);
INSERT INTO BOOK VALUES(400,'400A01','�̰��� DB��','��������',2018);

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


INSERT INTO MAJOR VALUES(1,'�濵����','3�� �ι���');
INSERT INTO MAJOR VALUES(2,'����Ʈ�������','3�� �ι���');
INSERT INTO MAJOR VALUES(3,'������','4�� ���н�');
INSERT INTO MAJOR VALUES(4,'����','4�� ���н�');
    
SELECT * FROM MAJOR;

INSERT INTO STUDENT VALUES('A01','��浿',100,1);
INSERT INTO STUDENT VALUES('A02','���浿',90,2);
INSERT INTO STUDENT VALUES('A03','ȫ�浿',95,1);

SELECT * FROM STUDENT;



