-- SELECT �� (12-19)
-- scott�� ������ �ִ� ��� ���̺�
select * from tab; 
-- emp���̺��� ��� �ʵ�(��), ��� ����Ÿ(��)
select * from emp; 
 -- EMP���̺��� ����
DESC EMP;
-- DEPT���̺��� ����
DESC DEPT;

select * from dept;

select empno, ename from emp WHERE sal>2000;

SELECT EMPNO AS �����ȣ, ENAME AS �̸�, SAL AS �޿�, JOB AS �۾� FROM EMP;

SELECT EMPNO "�����ȣ", ENAME "�̸�", SAL "�޿�", JOB "�۾�" FROM EMP;

SELECT EMPNO NO, ENAME NAME, SAL SALARY, JOB J FROM EMP;

SELECT EMPNO NUM, ENAME NAME, SAL SALARY, JOB J FROM EMP;

SELECT EMPNO, ENAME, DEPTNO FROM EMP;
-- WHERE ������ �񱳿����ڸ� ���
SELECT * FROM EMP;
-- SAL�� 3000�� ������ ���, �̸� �޿� �ʵ带 ���(TITLE:���, �̸�, �޿�)
SELECT EMPNO AS ���, ename AS �̸�, sal AS �޿�
FROM EMP
WHERE SAL = 3000;
-- SAL�� 3000�� �ƴ� ������ EMPNO, ENAME, SAL, COMM �ʵ带 ���
SELECT EMPNO, ENAME, SAL, COMM
FROM EMP
WHERE SAL <> 3000; -- WHERE SAL ^= 3000 , WHERE SAL != 3000

-- DEPTNO�� 10�� ����� ��� �ʵ带 ���
SELECT *
FROM EMP
WHERE DEPTNO = 10;

-- ENAME�� "FORD"�� ������ ��� �ʵ�
SELECT *
FROM EMP
WHERE ENAME = 'FORD'; -- ���ڴ� ''�� �Ѵ�

SELECT *
FROM EMP
WHERE ENAME = 'ford'; -- ���ڴ� ��ҹ��� �����Ѵ�.

-- SAL�� 2000�̻� 3000�̸��� ������ ����ʵ�
SELECT *
FROM EMP
WHERE SAL >=2000 AND SAL < 3000;

SELECT *
FROM EMP
WHERE ENAME < 'FP'; --ENAME�� 'FP'���Ϸ� �����ϴ� ���

-- �񱳿����� ��¥�� ����
-- �Ի����� 82(82/01/01)�� ������ �Ի��� ������ ��� �ʵ带 ���
SELECT * FROM EMP
WHERE HIREDATE < '82/01/01';
-- 82�⵵�� �Ի��� ������ ��� �ʵ�
SELECT * FROM EMP
WHERE HIREDATE >= '82/01/01' AND HIREDATE <= '82/12/31';

-- �μ��� 10�̰ų� JOB�� 'MANAGER'�� ������ �̸�, �޿� �ʵ�
SELECT ENAME, SAL, JOB FROM EMP 
WHERE DEPTNO = 10 OR JOB = 'MANAGER';

-- 10�� �μ��� �ƴ� ��� ������ ��� �ʵ�
SELECT * FROM EMP
WHERE DEPTNO <> 10;

-- SAL�� 2000�̻��� ������ �̸��� ������ ���(COMM�� ����)
SELECT ENAME, SAL*12 AS ���� FROM EMP
WHERE SAL >= 2000;

-- �����, �����޿�, �ø�����(10%�λ�)�� ��� �������� ����
SELECT ENAME, SAL, SAL*1.1 AS �ø��޿� FROM EMP;

-- SAL(����), ����(SAL*12+COMM) ��� ����� �̸�, ����, ��, ���� �ʵ带 ���
SELECT ENAME AS �̸�, SAL AS ����, COMM AS ��, SAL*12+COMM AS ���� 
FROM EMP; -- ������꿡 NULL���� ������ ����� NULL�� ���´�.
-- NVL(NULL�ϼ��ִ� �ʵ�, 0) ù��°�Ű������� �ι�° �Ű������� Ÿ���� ��ġ���Ѿ��Ѵ�
SELECT ENAME, SAL, NVL(COMM,0)AS �󿩱�, SAL*12+NVL(COMM,0) AS ���� FROM EMP;

SELECT ENAME, NVL(MGR,'�ְ�濵��') FROME EMP; -- Ÿ�� ����ġ�� ����ȵ�

SELECT ENAME, NVL(MGR, 9999) FROM EMP;

-- �������� : AND, OR
-- ||(���� ������) : ���̳� ���ڸ� ����
SELECT ENAME || ' ' || JOB FROM EMP;

-- "SMITH IS CLERK" ( ENAME IS JOB) ��µǰ� TITLE�� EMPLOYEES��� ��� ���� LIST
SELECT ENAME || ' IS ' || JOB AS "EMPLOYEES" FROM EMP;

-- SMITH�� ������ ??? �̴� ���
SELECT ENAME || '�� ������ ' || (SAL*12+NVL(COMM, 0)) || '�̴�' AS "SALARY" FROM EMP;

-- EMP ���̺��� JOB���� ���
SELECT DISTINCT JOB FROM EMP; -- DISTINCT�� �ߺ�����

SELECT DISTINCT DEPTNO FROM EMP;

SELECT DISTINCT JOB, DEPTNO FROM EMP;

--1. emp ���̺��� ���� ���
DESC EMP;

--2. emp ���̺��� ��� ������ ��� 
SELECT * FROM EMP;

--3. ������(scott)���� ��밡���� ���̺� ���
SELECT * FROM TAB;

--4. emp ���̺��� ���, �̸�, �޿�, ����, �Ի��� ���
SELECT EMPNO AS ���, ENAME AS �̸�, SAL AS �޿�, JOB AS ����, HIREDATE AS �Ի��� FROM EMP;

--5. emp ���̺��� �޿��� 2000�̸��� ����� ���, �̸�, �޿� ���
SELECT EMPNO AS ���, ENAME AS �̸�, SAL AS �޿� FROM EMP
WHERE SAL < 2000;

--6. �Ի����� 81/02���Ŀ� �Ի��� ����� ���, �̸�, ����, �Ի��� ���
SELECT EMPNO AS ���, ENAME AS �̸�, JOB AS ����, HIREDATE AS �Ի��� FROM EMP
WHERE HIREDATE >= '81/02/01';

--7. ������ SALESMAN�� ����� ��� �ڷ� ���
SELECT * FROM EMP
WHERE JOB = 'SALESMAN';

--8. ������ CLERK�� �ƴ� ����� ��� �ڷ� ���
SELECT * FROM EMP
WHERE JOB != 'CLERK';

--9. �޿��� 1500�̻��̰� 3000������ ����� ���, �̸�, �޿� ���
SELECT EMPNO AS ���, ENAME AS �̸�, SAL AS �޿� FROM EMP
WHERE SAL >= 1500 AND SAL <= 3000;

--10. �μ��ڵ尡 10���̰ų� 30�� ����� ���, �̸�, ����, �μ��ڵ� ���
SELECT EMPNO AS ���, ENAME AS �̸�, JOB AS ����, DEPTNO AS �μ��ڵ� FROM EMP
WHERE DEPTNO = 10 OR DEPTNO = 30;

--11. ������ SALESMAN�̰ų� �޿��� 3000�̻��� ����� ���, �̸�, ����, --�μ��ڵ� ���
SELECT EMPNO AS ���, ENAME AS �̸�, JOB AS ����, DEPTNO AS �μ��ڵ� FROM EMP
WHERE JOB='SALESMAN' OR SAL >= 3000;

--12. �޿��� 2500�̻��̰� ������ MANAGER�� ����� ���, �̸�, ����, �޿� ���
SELECT EMPNO AS ���, ENAME AS �̸�, JOB AS ����, SAL AS �޿� FROM EMP
WHERE SAL >=2500 AND JOB='MANAGER';

--13.��ename�� XXX �����̰� ������ XX�١� ��Ÿ�Ϸ� ��� ���
SELECT ENAME || '�� ' || JOB || '�����̰� ������ '|| 
(SAL*12+NVL(COMM, 0)) || '�̴�' AS TITLE FROM EMP;

-- SQL ������
-- BEETWEEN A AND B : A ���� B���� (A,B����)
SELECT * FROM EMP
WHERE SAL BETWEEN 1500 AND 3000;    -- A�� �������� �;��Ѵ�.

-- �ʵ�� IN (LIST, ...., LIST2)
-- �μ��ڵ尡 10���̰ų� 30�� ����� ���, �̸�, ����, �μ��ڵ� ���
SELECT EMPNO AS ���, ENAME AS �̸�, JOB AS ����, DEPTNO AS �μ��ڵ� FROM EMP
WHERE DEPTNO IN(10,30);

-- �ʵ� LIKE ���� (���ϵ�ī��(%):0�� �̻��� ����, ���ϵ�ī��(_):1�� �̻��� ����)
-- �̸��� M���� �����ϴ� ����� ��� �ʵ����
SELECT * FROM EMP
WHERE ENAME LIKE 'M%';

-- �̸��� N�� �ִ� ����� ��� �ʵ����
SELECT * FROM EMP
WHERE ENAME LIKE '%N%';

-- 82�⵵�� �Ի��� ����� EMPNO, ENAME, JOB, SAL, HIREDATE, DEPTNO
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE, DEPTNO FROM EMP
WHERE HIREDATE LIKE '82%';

-- 2���� �Ի��� ���
SELECT * FROM EMP
WHERE HIREDATE LIKE '__/02/__';

-- IS NULL
-- ��(COMM)�� NULL�� ������ ��� ���
SELECT * FROM EMP
WHERE COMM IS NULL;

-- NOT �ʵ� BETWEEN A AND B
-- NOT �ʵ� IN(LIST1,....LIST2)
-- NOT �ʵ� LIKE ����
-- (NOT) �ʵ� IS (NOT) NULL

-- ���� ORDER BY �ʵ� (ASC|DESC) �⺻�� ������������
-- �޿��� ���� ������� ���
SELECT * FROM EMP
ORDER BY SAL DESC;

-- �Ի� ������� ������� ���
SELECT * FROM EMP
ORDER BY HIREDATE;

-- �̸������ ���� ���
SELECT * FROM EMP
ORDER BY ENAME;

-- ����(SAL*12+COMM)�� ���� ������� ���
SELECT ENAME, SAL, (SAL*12+NVL(COMM,0)) AS ���� FROM EMP
ORDER BY ���� DESC;

-- ������ 2000 �̻��� ������ �̸�, ������ ���(���������� �������� ����)
SELECT ENAME, (SAL*12+NVL(COMM,0)) AS ���� FROM EMP
WHERE (SAL*12+NVL(COMM,0)) >= 2000
ORDER BY ����;

-- SQL�ؼ� ���� FROM -> WHERE -> SELECT -> ORDER BY


-- ���� ��������
-- 1. EMP ���̺��� sal�� 3000�̻��� ����� empno, ename, job, sal�� ���
SELECT EMPNO, ENAME, JOB, SAL FROM EMP
WHERE SAL >= 3000;

-- 2. EMP ���̺��� empno�� 7788�� ����� ename�� deptno�� ���
SELECT ENAME, DEPTNO FROM EMP
WHERE EMPNO IN(7788);

-- 3. ������ 24000�̻��� ���, �̸�, �޿� ��� (�޿�������)
SELECT EMPNO AS ���, ENAME AS �̸�, SAL AS �޿� FROM EMP
WHERE (SAL*12+NVL(COMM,0)) >= 24000
ORDER BY SAL;

-- 4. EMP ���̺��� hiredate�� 1981�� 2�� 20�� 1981�� 5�� 1�� ���̿� �Ի��� ����� 
-- ename,job,hiredate�� ����ϴ� SELECT ������ �ۼ� (�� hiredate ������ ���)
SELECT ENAME, JOB, HIREDATE FROM EMP
WHERE HIREDATE BETWEEN '81/02/20' AND '81/05/01'
ORDER BY HIREDATE;

SELECT ENAME, JOB, HIREDATE FROM EMP
WHERE HIREDATE >= '81/02/20' AND HIREDATE <= '81/05/01'
ORDER BY HIREDATE;

SELECT ENAME, JOB, HIREDATE FROM EMP
WHERE HIREDATE BETWEEN TO_DATE('1981/02/20','YYYY/MM/DD') 
    AND TO_DATE('1981/05/01', 'YYYY/MM/DD')
ORDER BY HIREDATE;

-- 5. EMP ���̺��� deptno�� 10,20�� ����� ��� ������ ��� (�� ename������ ����)
SELECT * FROM EMP
WHERE DEPTNO IN(10,20)
ORDER BY ENAME;

-- 6. EMP ���̺��� sal�� 1500�̻��̰� deptno�� 10,30�� ����� 
-- ename�� sal�� ���(�� HEADING�� employee�� Monthly Salary�� ���)
SELECT ENAME AS "EMPLOYYE", SAL AS "Monthly Salary" FROM EMP
WHERE SAL >=1500 AND DEPTNO IN(10,30);

-- 7. EMP ���̺��� hiredate�� 1982���� ����� ��� ������ ���
SELECT * FROM EMP
WHERE HIREDATE LIKE '82%';

-- TO_CHAR(��¥���ʵ�, 'YYYY/MM/DD') -> 'YYYY/MM/DD'��Ÿ���� ���������� ��ȯ
-- TO_DATE('1981/01/01','YYYY/MM/DD') -> ���ڸ� ��¥������ ��ȯ�ϴ� �Լ�
SELECT * FROM EMP
WHERE TO_CHAR(HIREDATE, 'YYYY/MM/DD') LIKE '1982%';

-- 8. �̸��� ù�ڰ� C����  P�� �����ϴ� ����� �̸�, �޿� �̸��� ����
SELECT ENAME, SAL FROM EMP
WHERE ENAME BETWEEN 'C' AND 'Q' AND ENAME !='Q'
ORDER BY ENAME; -- 'P'�� �ϸ� P�� �����ϴ� ����� �˻��ȵȴ�.���ϵ�ī��(%,_)�˻��� LIKE���� ���δ�

-- 9. EMP ���̺��� comm�� sal���� 10%�� ���� ��� ����� ���Ͽ� 
-- �̸�, �޿�, �󿩱��� ����ϴ� SELECT ���� �ۼ�
SELECT ENAME, SAL, NVL(COMM,0) FROM EMP
WHERE NVL(COMM,0) > SAL*1.1;

-- 10. EMP ���̺��� job�� CLERK�̰ų� ANALYST�̰� sal�� 
-- 1000,3000,5000�� �ƴ� ��� ����� ������ ���
SELECT * FROM EMP
WHERE JOB IN('CLERK','ANALYST') AND SAL NOT IN (1000,3000,5000);

-- 11. EMP ���̺��� ename�� L�� �� �ڰ� �ְ� deptno�� 30�̰ų� 
-- �Ǵ� mgr�� 7782�� ����� ��� ������ ����ϴ� SELECT ���� �ۼ��Ͽ���.
SELECT * FROM EMP
WHERE ENAME LIKE '%L%L%' AND (DEPTNO IN(30) OR MGR IN(7782));

-- 12. ��� ���̺��� �Ի����� 81�⵵�� ������ ���,�����, �Ի���, ����, �޿��� ���
SELECT EMPNO, ENAME, HIREDATE, JOB, SAL FROM EMP
WHERE HIREDATE LIKE '81%';

SELECT EMPNO, ENAME, HIREDATE, JOB, SAL FROM EMP
WHERE TO_CHAR(HIREDATE,'YYMMDD') BETWEEN '810101' AND '811231';

-- 13. ��� ���̺��� �Ի�����81���̰� ������ 'SALESMAN'�� �ƴ� ������ 
-- ���, �����, �Ի���, ����, �޿��� �˻��Ͻÿ�.
SELECT EMPNO, ENAME, HIREDATE, JOB, SAL FROM EMP
WHERE HIREDATE LIKE '81%' AND JOB NOT IN('SALESMAN');

SELECT EMPNO, ENAME, HIREDATE, JOB, SAL FROM EMP
WHERE TO_CHAR(HIREDATE,'YY') = '81' AND JOB NOT IN('SALESMAN');

-- 14. ��� ���̺��� ���, �����, �Ի���, ����, �޿��� �޿��� ���� ������ �����ϰ�, 
-- �޿��� ������ �Ի����� ���� ������� �����Ͻÿ�.
SELECT EMPNO, ENAME, HIREDATE, JOB, SAL FROM EMP
ORDER BY SAL DESC, HIREDATE ASC;

-- 15. ��� ���̺��� ������� �� ��° ���ĺ��� 'N'�� ����� ���, ������� �˻��Ͻÿ�
SELECT EMPNO, ENAME FROM EMP
WHERE ENAME LIKE '__N%';

-- 16. ��� ���̺�������(SAL*12)�� 35000 �̻��� ���, �����, ������ �˻� �Ͻÿ�.
SELECT EMPNO, ENAME, SAL FROM EMP
WHERE SAL*12 >= 35000;

ALTER SESSION SET NLS_DATE_FORMAT = 'YY/MM/DD' -- DATE�� ������





























