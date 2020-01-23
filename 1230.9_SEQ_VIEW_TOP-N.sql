------------------------------------------------------------------------------------------
-- SEQUENCE : ������ȣ �ڵ� ���� ��ü (PRIMARY KEY���� ������ȣ ������ �ʿ��Ҷ�)
------------------------------------------------------------------------------------------

-- ������ȣ(PK), ģ���̸�, ��ȭ, ����������
-- 1 ȫ�浿 010-9999-9999 19/12/30
-- 2 ��浿 NULL 19/12/30
DROP SEQUENCE FRIEND_SEQNO;
CREATE SEQUENCE FRIEND_SEQNO
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 9999
    NOCYCLE -- 9999�� ������ ���̻� ��������� �ʴ´�.
    --CYCLE : 9999�� ������ �ٽ� 1���� ���������.
    NOCACHE;    -- ĳ�ø޸𸮿� �̸� �������� �ʴ´�.
    
DROP TABLE FRIEND;
CREATE TABLE FRIEND (
    NUM NUMBER(4) PRIMARY KEY,
    NAME VARCHAR2(50),
    TEL VARCHAR2(30) UNIQUE,
    LAST_MODIFIED DATE DEFAULT SYSDATE);

INSERT INTO FRIEND (NUM, NAME, TEL, LAST_MODIFIED) VALUES( FRIEND_SEQNO.NEXTVAL, 'ȫ�浿', '010-9999-9999', SYSDATE);
INSERT INTO FRIEND (NUM, NAME, TEL, LAST_MODIFIED) VALUES( FRIEND_SEQNO.NEXTVAL, '��浿', NULL, SYSDATE);

SELECT * FROM FRIEND;

SELECT FRIEND_SEQNO.CURRVAL FROM DUAL; -- ���� �������� Ȯ���ϱ�

-- 1~4 ������ ���� ������ ���̺��� �����ϱ� ���� ���̺� �����ϴ� SQL���� �ۼ�.
/*  
[ customer ���̺� ] - cno�� ��Ű, phone�� �ٸ������ �ٸ��� �Էµǵ��� ������
		      joindate�� �Է����� ������ ���糯¥�� �Է�
  cno    cname   joindate    phone         point  levelno
   1   ȫ�浿   17/10/17  010-9999-9999     300     1
   2   ��ö��   16/09/06  010-9999-9888    NULL     2
   3   ȫ���   16/09/07  010-9999-7777      50     3
[ cus_level ���̺� ] - levelno�� ��Ű, levelname�� NOT NULL ����.
       levelno     levelname
   	1            VVIP
   	2             VIP           
   	3            NORMAL
   	4            BLACK
���Ǩ� CUSTOMER ���̺��� ���� ��, ���̺��� �����ϰ� ���̺��� �����Ͻÿ� */
DROP TABLE CUSTOMER;
DROP TABLE CUS_LEVEL;
/*
���Ǩ� CUSTOMER ���̺��� �ʵ庰�� ������ ���������� ��Ų��.
	CNO : ��Ű
	CNAME : NULL���� �Է��� �� ����
	JOINDATE : �Է����� ���� ��, �⺻������ ���糯¥�� �Էµȴ�
	PHONE : ��� �����ʹ� PHONE ���� ��� �ٸ��� �Էµȴ�
	LEVELNO : CUS_LEVEL ���̺��� LEVELNO �ʵ带 �����ϴ� �ܷ�Ű */
CREATE TABLE CUS_LEVEL (
    LEVELNO NUMBER(1) PRIMARY KEY,
    LEVELNAME VARCHAR2(20) NOT NULL
    );
    
INSERT INTO CUS_LEVEL VALUES(1,'VVIP');
INSERT INTO CUS_LEVEL VALUES(2,'VIP');
INSERT INTO CUS_LEVEL VALUES(3,'NORMAL');
INSERT INTO CUS_LEVEL VALUES(4,'BLACK');

DROP SEQUENCE CUS_SQ;
CREATE SEQUENCE CUS_SQ
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 9999
    NOCYCLE
    NOCACHE;

CREATE TABLE CUSTOMER (
    CNO NUMBER(4) PRIMARY KEY,
    CNAME VARCHAR2(10) NOT NULL,
    JOINDATE DATE DEFAULT SYSDATE,
    PHONE VARCHAR2(20) UNIQUE,
    POINT NUMBER(4),
    LEVELNO NUMBER(1) REFERENCES CUS_LEVEL(LEVELNO)
    );

INSERT INTO CUSTOMER VALUES (CUS_SQ.NEXTVAL, 'ȫ�浿', TO_DATE('20171017', 'YYYYMMDD'), '010-9999-9999', 300, 1);
INSERT INTO CUSTOMER VALUES (CUS_SQ.NEXTVAL, '��ö��', TO_DATE('20160906', 'YYYYMMDD'), '010-9999-9888', NULL, 2);
INSERT INTO CUSTOMER VALUES (CUS_SQ.NEXTVAL, 'ȫ���', TO_DATE('20160907', 'YYYYMMDD'), '010-9999-7777', 50, 3);
/*
���Ǩ� CUS_LEVEL ���̺��� �ʵ庰�� ������ ���������� ��Ų��
	LEVELNO : ��Ű
	LEVELNAME : NULL���� �Է��� �� ����
���Ǩ� CUSTOMER ���̺��� CNO��ȣ�� ������(CUS_SQ)�� ������ �� �ڵ����� ��ȣ�� �Էµǵ��� �Ѵ�
���Ǩ� �� ���̺�ó�� ������ �Է�

5. ���� ���� �ΰ��� ���̺��� �̿��Ͽ� �Ʒ��� ���� ����ϴ� SQL���� �ۼ��Ͻÿ�
  cno    cname   joindate    phone         point  levelname
   1   ȫ�浿   2017-10-17  010-9999-9999     300     VVIP
   2   ��ö��   2016-09-06  010-9999-9888    NULL     VIP
   3   ȫ���   2016-09-07  010-9999-7777      50     NORMAL
*/   
   

SELECT CNO, CNAME, TO_CHAR(JOINDATE,'YY-MM-DD'), PHONE, NVL(POINT,0), LEVELNAME 
FROM CUSTOMER C, CUS_LEVEL L
WHERE C.LEVELNO = L.LEVELNO;

------------------------------------------------------------------------------------------
-- VIEW(������ ���̺�)
------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW EMPV0
    AS SELECT EMPNO, ENAME, JOB, DEPTNO FROM EMP; -- �ܼ���

SELECT * FROM EMPV0 WHERE DEPTNO = 20;

CREATE OR REPLACE VIEW EMPV0
    AS SELECT EMPNO, ENAME, JOB, DNAME FROM EMP E, DEPT D
        WHERE E.DEPTNO=D.DEPTNO; -- ���պ�

SELECT * FROM EMPV0;

-- �μ���ȣ�� 30�� �μ������鸸 EMPV1 �����
CREATE OR REPLACE VIEW EMPV1
    AS SELECT * FROM EMP WHERE DEPTNO=30;

SELECT * FROM EMPV1;

INSERT INTO EMPV1 VALUES(1111,'ȫ',NULL,NULL,SYSDATE,NULL,NULL,40);

SELECT * FROM EMP;

CREATE OR REPLACE VIEW EMPV1
    AS SELECT * FROM EMP WHERE DEPTNO=30 WITH CHECK OPTION; -- 30�� �μ��� ������ W/R����

INSERT INTO EMPV1 VALUES(1112,'ȫ',NULL,NULL,SYSDATE,NULL,NULL,40); -- ����Ұ�
INSERT INTO EMPV1 VALUES(1112,'ȫ',NULL,NULL,SYSDATE,NULL,NULL,30); -- ���డ��

CREATE OR REPLACE VIEW EMPV2
    AS SELECT * FROM EMP WHERE DEPTNO=30 WITH READ ONLY; -- SELECT�� ����

INSERT INTO EMPV2 VALUES(1113,'ȫ',NULL,NULL,SYSDATE,NULL,NULL,30); -- ����Ұ�

-- INSERT �Ұ����� ���
CREATE OR REPLACE VIEW EMPV3
    AS SELECT ENAME, SAL, COMM FROM EMP;

SELECT * FROM EMPV3;
INSERT INTO EMPV3 VALUES('ȫ',9000,5000);

CREATE OR REPLACE VIEW SALV1
    AS SELECT EMPNO, ENAME, SAL*12 AS YEARSAL FROM EMP WHERE DEPTNO=10;

SELECT * FROM SALV1 WHERE YEARSAL > 20000;

CREATE OR REPLACE VIEW SALV1 (ID, NAME, YEARSAL)
    AS SELECT EMPNO, ENAME, SAL*12 FROM EMP WHERE DEPTNO=10;

INSERT INTO SALV1 VALUES(119,'ȫ',12000); -- ����Ұ�
SELECT * FROM SALV1;

CREATE OR REPLACE VIEW DEPTV1 (DEPTNO, MINSAL, MAXSAL, AVGSAL)
    AS SELECT DEPTNO, MIN(SAL), MAX(SAL), AVG(SAL) FROM EMP GROUP BY DEPTNO;

SELECT * FROM DEPTV1;

CREATE OR REPLACE VIEW JOBLIST
    AS SELECT DISTINCT JOB, DEPTNO FROM EMP;

SELECT * FROM JOBLIST;

------------------------------------------------------------------------------------------
-- inline VIEW : FROM ���� ��������
------------------------------------------------------------------------------------------
-- �޿��� 2000�� �ʰ��ϴ� ����� ��� �޿����
SELECT AVG(SAL) FROM (SELECT SAL FROM EMP WHERE SAL>2000);

-- �̸�, �޿�, �μ���ȣ, �ش����� �μ��޿���ձ޿�
SELECT ENAME, SAL, DEPTNO, (SELECT AVG(SAL) FROM EMP WHERE DEPTNO=E.DEPTNO)
FROM EMP E;

DELETE FROM EMP WHERE DEPTNO=40;
COMMIT;

SELECT E.ENAME, E.SAL, E.DEPTNO, S.AVGSAL
FROM EMP E, (SELECT DEPTNO, AVG(SAL) AVGSAL FROM EMP GROUP BY DEPTNO) S
WHERE E.DEPTNO=S.DEPTNO;

-- �̸�, �޿�, �μ���ȣ, �μ���ձ޿� (�μ���պ��� ���� �޴� ����� ���)
SELECT DEPTNO, AVG(SAL) AVGSAL FROM EMP GROUP BY DEPTNO;

SELECT E.ENAME, E.SAL, S.DEPTNO, AVGSAL
FROM EMP E, (SELECT DEPTNO, AVG(SAL) AVGSAL FROM EMP GROUP BY DEPTNO) S
WHERE E.DEPTNO=S.DEPTNO 
AND E.SAL > S.AVGSAL;

------------------------------------------------------------------------------------------
-- TOP N ����
------------------------------------------------------------------------------------------
SELECT ROWNUM, ENAME, SAL FROM EMP; -- ROWNUM: EMP���̺��� ������ ����
-- SAL���, ENAME, SAL
SELECT ROWNUM, ENAME, SAL FROM EMP ORDER BY SAL DESC; -- ����� �ƴ�

SELECT ROWNUM, ENAME, SAL FROM (SELECT * FROM EMP ORDER BY SAL)
WHERE ROWNUM < 6; -- 1����� 5�����

SELECT ROWNUM, ENAME, SAL FROM (SELECT * FROM EMP ORDER BY SAL)
WHERE ROWNUM BETWEEN 6 AND 10; -- 6����� 10�����(X)

SELECT RN, ENAME, SAL FROM (SELECT ROWNUM RN, A.* FROM (SELECT * FROM EMP ORDER BY SAL) A)
WHERE RN BETWEEN 6 AND 10; -- 6����� 10�����(O)

SELECT RANK() OVER(ORDER BY SAL) RANK, ENAME, SAL FROM EMP; -- ��ũ�Լ��� ������� �Ұ�
SELECT DENSE_RANK() OVER(ORDER BY SAL) RANK, ENAME, SAL FROM EMP;
SELECT ROW_NUMBER() OVER(ORDER BY SAL) RANK, ENAME, SAL FROM EMP;


-- 1. �μ���� ������� ����ϴ� �뵵�� ��, DNAME_ENAME_VU �� �ۼ��Ͻÿ�
CREATE OR REPLACE VIEW DNAME_ENAME_VU
    AS SELECT DNAME, ENAME FROM EMP E, DEPT D WHERE E.DEPTNO=D.DEPTNO;

SELECT * FROM DNAME_ENAME_VU;

-- 2. ������ ���ӻ������ ����ϴ� �뵵�� ��,  WORKER_MANAGER_VU�� �ۼ��Ͻÿ�
CREATE OR REPLACE VIEW WORKER_MANAGER_VU
    AS SELECT W.ENAME, M.ENAME AS ���ӻ�� FROM EMP W, EMP M WHERE W.MGR=M.EMPNO;

SELECT * FROM WORKER_MANAGER_VU;

-- 3. �μ��� �޿��հ� ����� ����Ͻÿ�(�μ���ȣ, �޿��հ�, ���)
SELECT DEPTNO, SUMSAL, ROWNUM ��� FROM(SELECT DEPTNO, SUM(SAL) SUMSAL FROM EMP GROUP BY DEPTNO ORDER BY SUM(SAL) DESC);

-- 4. ������̺��� ���, �����, �Ի����� �Ի����� �ֽſ��� ������ ��� ������ �����Ͻÿ�
SELECT EMPNO, ENAME, HIREDATE FROM EMP ORDER BY HIREDATE DESC;

-- 5. ������̺��� ���, �����, �Ի����� �Ի����� �ֽſ��� ������ ��� 5���� ����Ͻÿ�
SELECT EMPNO, ENAME, HIREDATE FROM (SELECT ROWNUM RN, A.* FROM EMP A ORDER BY HIREDATE DESC)
WHERE RN < 6;

-- 6. ��� ���̺��� ���, �����, �Ի����� �ֽź��� ������ ������ 6��°�� ���� ������� 10��° ������� ���
SELECT RN, EMPNO, ENAME, HIREDATE 
    FROM (SELECT ROWNUM RN, EMPNO, ENAME, HIREDATE FROM 
            (SELECT * FROM EMP ORDER BY HIREDATE DESC))
WHERE RN BETWEEN 6 AND 10;































