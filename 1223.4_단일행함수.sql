-- 2019.12.20 ~ 12.23 ������ �Լ� (�ݴ븻 : �������Լ�=�׷��Լ�)

SELECT ENAME, TO_CHAR(HIREDATE, 'YY-MM-DD DY"����" AM HH:MI:SS') 
FROM EMP;

SELECT SUM(SAL) FROM EMP; -- EMP���̺��� SAL���� �� -> �׷��Լ�(�������Լ�)��.
SELECT DEPTNO, SUM(SAL) FROM EMP GROUP BY DEPTNO;

-- ������ �Լ��� ���� : ���ڰ����Լ�, ����ó���Լ�, ��¥�����Լ�, ����ȯ�Լ�, NULL, DECODE�Լ�.....
------------------------------------------------------------------------------------------
-- (1) ���ڰ����Լ�
------------------------------------------------------------------------------------------
SELECT ABS(-9) FROM EMP;
-- �ƹ� �ǹ̾��� 1��¥�� ���̺� : DUAL
SELECT * FROM DUAL;
SELECT ABS(-9) FROM DUAL;

-- �����Լ� 
SELECT FLOOR(34.5678) FROM DUAL; -- �Ҽ��� ���ϸ� ����

SELECT FLOOR(34.5678*10)/10 FROM DUAL;

SELECT TRUNC(34.5678,2) FROM DUAL; -- ���� �Ҽ��� ����

SELECT TRUNC(156.54, -1) FROM DUAL; -- ���̳ʽ��� ������������ ����

SELECT TRUNC(156.54, -2) FROM DUAL; -- ���̳ʽ��� ������������ ����

-- �̸� SAL(�����ڸ� �������� ���)
SELECT ENAME, TRUNC(SAL, -2) FROM EMP;

-- �ݿø��Լ� 
SELECT ROUND(34.5678) FROM DUAL; -- �Ҽ������� �ݿø�
SELECT ROUND(34.5678, 1) FROM DUAL; -- �Ҽ��� ���ڸ��������� �ݿø�
SELECT ROUND(34.5678, 3) FROM DUAL; -- ���ϴ� �Ҽ����ڸ����� �ݿø�
SELECT ROUND(34.5678, -1) FROM DUAL; 
-- �̸� SAL(�����ڸ� �ݿø����� ���)
SELECT ENAME, ROUND(SAL,-3) FROM EMP;
-- ��¥�� ���밡��

-- �ø��Լ�
SELECT CEIL(34.5678) FROM DUAL; -- �Ҽ������� �ø�
SELECT FLOOR(10/4) FROM DUAL;

SELECT POWER(3,2) FROM DUAL; -- 3�� 2��

SELECT MOD(9,2) FROM DUAL; -- ���������ϱ�
-- Ȧ���޿� �Ի��� �������� ��� �ʵ� ���
SELECT * FROM EMP
WHERE MOD(TO_CHAR(HIREDATE, 'MM'), 2) = 1;

------------------------------------------------------------------------------------------
-- (2) ���ڰ����Լ�
------------------------------------------------------------------------------------------
SELECT UPPER('abcABC') FROM DUAL; -- �빮�ڷ�
SELECT LOWER('ABCabc') FROM DUAL; -- �ҹ��ڷ�

-- ù��°���ڸ� �빮��, �������� �ҹ���
SELECT INITCAP('abcabC') FROM DUAL;

-- JOB�� MANAGER�� ������ ��� �ʵ�
SELECT * FROM EMP WHERE UPPER(JOB) = 'MANAGER';
SELECT * FROM EMP WHERE LOWER(JOB) = 'manager';

SELECT EMPNO, INITCAP(ENAME), INITCAP(JOB) FROM EMP;

-- CONCAT(A,B)
SELECT CONCAT('ABC','DEF') FROM DUAL;

SELECT CONCAT(CONCAT('ABC','DEF'),'GHI') FROM DUAL;

-- XXX�� JOB�̴�
SELECT CONCAT(CONCAT(ENAME, '�� '), CONCAT(JOB,'�̴�')) TITLE FROM EMP;

-- SUBSTR(STR, ������ ��ġ, ������ ����) ù��° ��ġ�� 1
SELECT SUBSTR('welcome to Oracle', 3,2) FROM DUAL;
SELECT SUBSTR('welcome to Oracle', -2,2) FROM DUAL; -- �Ӽ��ϰ�� ���ڳ��������� ����

-- �츮 �ý��ۿ����� ��¥ ���� : 81/01/02
-- SUBSTR�Լ��� �̿��ؼ� ¦�� ���ڿ� �Ի��� ������ ��� �ʵ�
SELECT * FROM EMP
WHERE MOD(SUBSTR(HIREDATE,-2,2),2)=0;

SELECT SUBSTR('�ȳ��ϼ��� �ݰ����ϴ�',3,2) FROM DUAL;

SELECT SUBSTRB('�����ͺ��̽�',4,6) FROM DUAL;


-- 9���� �Ի��� ����� ��� �ǵ带 ���
-- like, substr(), to_char

SELECT * FROM EMP
WHERE HIREDATE LIKE '__/09/__';

SELECT * FROM EMP
WHERE SUBSTR(HIREDATE, 4,2) = '09';

SELECT * FROM EMP
WHERE TO_CHAR(HIREDATE, 'MM') = '09';

SELECT * FROM EMP
WHERE TO_CHAR(HIREDATE, 'MM') = 9;

SELECT SUBSTR('ABCD',2,3) FROM DUAL; -- 2��° ��ġ���� 3����

SELECT SUBSTR('ABCD',2,3) FROM DUAL; -- 2��° BYTE ��ġ���� 3BYTE ��������

SELECT SUBSTR('����Ŭ���' , 2,3) FROM DUAL; -- 2��° ��ġ���� 3����
-- 2��° BYTE ��ġ���� 3BYTE �������� ����Ŭ�ͽ������������� �ѱ��� 3����Ʈ���
-- ����Ŭ ���Ĵٵ�� �ѱ��� 2����Ʈ�� ���
SELECT SUBSTRB('����Ŭ���' , 4,6) FROM DUAL; 

-- LENGTH(����):������ ���̼�, LENGTHB(����):������ BYTE��
SELECT LENGTH('ABCD'), LENGTHB('ABCD') FROM DUAL;

SELECT LENGTH('����Ŭ'), LENGTHB('����Ŭ') FROM DUAL;

-- INSTR(STR, �O������, (������ġ)): (������ġ����)STR���� �O�� ������ ��ġ�� ��ȯ
-- INSTR(STR, �O������, (������ġ), K): (������ġ����)STR���� K��° ������ �O�� ������ ��ġ�� ��ȯ
SELECT INSTR('ABCABCABCABC','B') FROM DUAL;

SELECT INSTR('ABCABCABCABC','B',3) FROM DUAL;

SELECT INSTR('ABCABCABCABC','B',3,2) FROM DUAL; -- 3��° ��ġ���� 2��° ������ 'B'�� �O�´�

-- 9���� �Ի��� ������ ��� �ʵ� ���
SELECT * FROM EMP WHERE INSTR(HIREDATE, '09') = 4;

-- LPAD(����,10,'*') ���ڸ� 10�ڸ� Ȯ���ϰ� ���� ���ڸ��� *�� ä���
SELECT LPAD('ORACLE', 20, '#') FROM DUAL;

-- RPAD((����,10,'*') ���ڸ� 10�ڸ� Ȯ���ϰ� ������ ���ڸ��� *�� ä���
SELECT RPAD('ORACLE', 20, '#') FROM DUAL;

SELECT ENAME, LPAD(SAL,6,'*') FROM EMP;

-- TRIM, LTRIM, RTRIM
SELECT TRIM('     ORACLE DB     ') TITLE FROM DUAL;

SELECT LTRIM('     ORACLE DB     ') TITLE FROM DUAL;

SELECT RTRIM('     ORACLE DB     ') TITLE FROM DUAL;

SELECT TRIM('a' FROM 'aaaORACLE DBaaa') FROM DUAL;

SELECT REPLACE('abcabc','a','999')FROM DUAL;


-- 83�⵵ �Ի��� ������ ��� �ʵ� ����ϱ�
SELECT * FROM EMP WHERE SUBSTR(HIREDATE,1,2)='83';
SELECT * FROM EMP WHERE INSTR(HIREDATE, '83')=1;
SELECT * FROM EMP WHERE TO_CHAR(HIREDATE, 'YY') = '83';
SELECT * FROM EMP WHERE HIREDATE LIKE '83%';
-- �̸��� E�� ������ ����� ��� �ʵ� ����ϱ�
SELECT * FROM EMP WHERE ENAME LIKE '%E';
SELECT * FROM EMP WHERE SUBSTR(ENAME,-1,1)='E';
SELECT * FROM EMP WHERE INSTR(ENAME, 'E', LENGTH(ENAME))=LENGTH(ENAME);
-- �̸��� E�� ������ ����� �̸�(***E) ����ϱ�
SELECT LPAD(SUBSTR(ENAME,-1,1), LENGTH(ENAME),'*') FROM EMP
WHERE ENAME LIKE '%E';
-- ���, �̸�(S****), ��å, �Ի���(81/09/**)
SELECT EMPNO, RPAD(SUBSTR(ENAME,1,1), LENGTH(ENAME),'*'), JOB, RPAD(SUBSTR(HIREDATE,1,6), LENGTH(HIREDATE),'*')
FROM EMP;

SELECT EMPNO, RPAD(SUBSTR(ENAME,1,1), LENGTH(ENAME),'*'), JOB, 
TO_CHAR(HIREDATE, 'YY/MM/**')
FROM EMP;

-- ���, �̸� ��å�� ���(��å�� �̸��� ���ڿ� ����ŭ�� ǥ��)
SELECT EMPNO, ENAME, SUBSTR(JOB, 1, LENGTH(ENAME)) FROM EMP;

-- 82�� 12���� �Ի��� �������� ��� �ʵ带 ���
SELECT * FROM EMP
WHERE HIREDATE LIKE '82/12/%';

SELECT * FROM EMP
WHERE HIREDATE BETWEEN '82/12/01' AND '82/12/31';

SELECT * FROM EMP
WHERE SUBSTR(HIREDATE, 1, 6) = '82/12/';

SELECT * FROM EMP
WHERE INSTR(HIREDATE, '82/12/') = 1;

-- �̸��� ����° ���ڰ� R�� ����� �̸��� ���
SELECT * FROM EMP
WHERE ENAME LIKE '__R%';

SELECT * FROM EMP
WHERE SUBSTR(ENAME, 3,1)='R';

SELECT * FROM EMP
WHERE INSTR(ENAME, 'R',3)=3;

------------------------------------------------------------------------------------------
-- (3) ��¥���� ������ �Լ�
------------------------------------------------------------------------------------------
SELECT SYSDATE "��������" FROM DUAL;

SELECT TO_CHAR(SYSDATE,'YY-MM-DD DY"����" HH24:MI:SS') FROM DUAL;

SELECT SYSDATE-1 "����", SYSDATE "����", SYSDATE+1 "����" FROM DUAL;

SELECT TO_CHAR(SYSDATE+14, 'YY-MM-DD HH24"��"') FROM DUAL;

-- �̸�, �Ի���, �ٹ�����
SELECT ENAME, HIREDATE, FLOOR(SYSDATE-HIREDATE) "�ٹ�����" FROM EMP;
SELECT ENAME, HIREDATE, TRUNC(SYSDATE-HIREDATE) "�ٹ�����" FROM EMP;

SELECT ENAME, HIREDATE, TRUNC((SYSDATE-HIREDATE)/365) "�ٹ����" FROM EMP;

-- MONTHS_BETWEEN(Ư����¥, Ư����¥):�� ��¥���� ������
SELECT ENAME, HIREDATE, TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) "�ٹ��޼�" FROM EMP;

-- ADD_MONTHS(Ư����¥, N) : Ư����¥���� N���� ��
-- �̸�, �Ի���, �����Ⱓ��������(�Ի���6����)
SELECT ENAME, HIREDATE, ADD_MONTHS(HIREDATE,6) FROM EMP;

-- NEXT_DAY(Ư����¥, '��') Ư����¥�� ó�� �����ϴ� ��
SELECT SYSDATE, NEXT_DAY(SYSDATE,'��') FROM DUAL;

-- �̸�, �Ի��� �Ի��� �´� ù �ָ�
SELECT ENAME, HIREDATE, NEXT_DAY(HIREDATE, '��') FROM EMP;

-- LAST_DAY(Ư����¥) : Ư����¥�� ���� ����
SELECT ENAME, HIREDATE, LAST_DAY(HIREDATE) "���޳�" FROM EMP;

SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- ROUND(�ݿø�), TRUNC(����) YEAR, MONTH, DAY, ����
SELECT ROUND(SYSDATE, 'YEAR') FROM DUAL; -- YEAR�ݿø� ��� : ����� 1�� 1��

SELECT TRUNC(SYSDATE, 'YEAR') FROM DUAL; -- YEAR���� ��� : 1�� 1��

SELECT ROUND(SYSDATE, 'MONTH') FROM DUAL; -- MONTH�ݿø� ��� : ����� 1��

SELECT TRUNC(SYSDATE, 'MONTH') FROM DUAL; -- MONTH ���� ��� : �ش� ���� 1��

SELECT ROUND(SYSDATE, 'DAY') FROM DUAL; -- DAY �ݿø���� : �ش� ���ڿ��� ����� �Ͽ���

SELECT ROUND(TO_DATE('19/12/26'), 'DAY') FROM DUAL;

SELECT TRUNC(TO_DATE('19/12/26'), 'DAY') FROM DUAL; -- DAY ���� ��� : ���� �Ͽ���
SELECT TRUNC(SYSDATE, 'DAY') FROM DUAL;

SELECT TO_CHAR(ROUND(SYSDATE), 'YY-MM-DD HH24:MI:SS') FROM DUAL; -- DEFAULT �ݿø� ��� : 0��0��0��

SELECT TO_CHAR(TRUNC(SYSDATE), 'YY-MM-DD HH24:MI:SS') FROM DUAL;

-- ENAME, �Ի���, �Ի��ϴ��� 1��
SELECT ENAME, HIREDATE, TRUNC(HIREDATE,'MONTH') "�Ի��Ѵ�" FROM EMP;

-- �̸�, �Ի���, ���޳�(����)
SELECT ENAME, HIREDATE, LAST_DAY(HIREDATE) "���޳�" FROM EMP;
-- �̸�, �Ի���, ���޳�(25��)
SELECT ENAME, HIREDATE, ROUND(TO_DATE(HIREDATE)-9,'MONTH')+24 FROM EMP; 
SELECT ENAME, HIREDATE, ROUND(HIREDATE-9,'MONTH')+24 FROM EMP; 
SELECT ROUND(TO_DATE('191224','YYMMDD')-9,'MONTH')+24 FROM DUAL;

-- �̸�, �Ի���, ���޳�(17��)
SELECT ENAME, HIREDATE, ROUND(HIREDATE-1, 'MONTH')+16 FROM EMP; 

-- �̸� ,�Ի���, ����, �̶����� ���� ������
SELECT ENAME, HIREDATE, SAL, SAL*12*TRUNC((SYSDATE-HIREDATE)/365) FROM EMP;

SELECT ENAME, HIREDATE, SAL, TRUNC((SYSDATE-HIREDATE)/365) FROM EMP;

SELECT ENAME, HIREDATE, SAL, SAL*TRUNC(MONTHS_BETWEEN(SYSDATE,HIREDATE)) FROM EMP;

SELECT ENAME, HIREDATE, SAL, NVL(COMM,0),
SAL*TRUNC(MONTHS_BETWEEN(SYSDATE,HIREDATE))+NVL(COMM,0) * TRUNC((SYSDATE-HIREDATE)/365) 
FROM EMP;


------------------------------------------------------------------------------------------
-- (4) ����ȯ �Լ�
------------------------------------------------------------------------------------------
-- TO_CHAR(��¥, ����) : ��¥�� ���ڷ�
-- YY(�⵵) MM(��) MON(���̸�) DD(��) DY(����) AM(����/����) HH(12�ð�) HH24(24�ð�����) MI(��) SS(��)
-- ���ϳ��� ���ĺ��̳� Ư������ ��� ���� �ܷ����� ��� "" �ȿ�
SELECT ENAME, SAL, TO_CHAR(HIREDATE, 'YY/MON/DD DY AM HH:MI:SS') FROM EMP;
SELECT TO_CHAR(SYSDATE, 'YY"��"MM"��"DD"��" DY AM HH"��"MI"��"SS"��"') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MM-DD') FROM DUAL;

-- TO_CHAR(����, ����) : ���ڸ� ���ڷ�
-- ���Ͽ� �ü��ִ°� : 0(�ڸ����׻� ��Ÿ����), 
--                    9(�ڸ���, �ڸ����� ���� ������ ä���� �ʴ´�)
--                    L(���� ��ȭ����ǥ��)
--                    $($ ��ȭ����)
--                    , (õ�������� �޸�ǥ��)

SELECT ENAME, SAL, TO_CHAR(SAL, 'L000,000.0') FROM EMP;
SELECT ENAME, SAL, TO_CHAR(SAL, '$999,999.9') FROM EMP;

-- TO_DATE(����, ����) : ���ڸ� ��¥������
-- DATE_FORMAT �� �𸦶� 81��5��1�Ϻ��� 83��5��1�ϻ��̿� �Ի��� �������� ����ʵ�
SELECT * FROM EMP
WHERE HIREDATE BETWEEN '81/05/01' AND '83/05/01';

SELECT * FROM EMP
WHERE HIREDATE BETWEEN TO_DATE('19810501','YYYYMMDD') AND TO_DATE('19830501','YYYYMMDD');

-- 2019,8,1 ���� ���ñ��� ��¥ ���
SELECT CEIL(SYSDATE - TO_DATE('20190801','YYYYMMDD')) FROM DUAL;

-- TO_NUMBER(����, ����) : ���ڸ� ���ڷ� '9,876' -> 9876
SELECT TO_NUMBER('1,000', '9,999')+1000 FROM DUAL;


------------------------------------------------------------------------------------------
-- (5) NULL ���� �Լ� = NVL(���ϼ��ִµ�����,�δ�Ż���Ұ�)
------------------------------------------------------------------------------------------
-- ����̸�, ����� �̸�(MGR�� ���̸� 'CEO'��� ���)
SELECT W.ENAME ����̸�, NVL(M.ENAME,'CEO') ����̸�
FROM EMP W, EMP M
WHERE W.MGR=M.EMPNO(+);

-- ����̸�, MGR(MGR�� ���̸� 'CEO')
SELECT ENAME, NVL(TO_CHAR(MGR,'9999'),'CEO') FROM EMP;

------------------------------------------------------------------------------------------
-- (6) DECODE(������, ��1, ���1, ��2, ���2, ��3, ���3....... ��N, ���N
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

-- ������ SAL�� �̿��ؼ� ������ SAL�� JOB������ 'ANALYST'10%�λ� 'SALESMAN' 20%�λ�, 'MANAGER" 30%�λ�, 'CLERK' 40%�λ� �׿� ��������
-- ���, �̸�, ������ SAL, ������SAL

SELECT EMPNO, ENAME, JOB, SAL, CASE JOB WHEN 'ANALYST' THEN SAL*1.1
                                        WHEN 'SALESMAN' THEN SAL*1.2
                                        WHEN 'MANAGER' THEN SAL*1.3
                                        WHEN 'CLERK' THEN SAL*1.4 
                                        ELSE SAL END AS "������SAL" 
FROM EMP;

SELECT EMPNO, ENAME, JOB, SAL, DECODE(JOB, 'ANALYST', SAL*1.1, 'SALESMAN', SAL*1.2, 
                                           'MANAGER', SAL*1.3, 'CLERAK', SAL*1.4,SAL) AS "�λ���SAL"
FROM EMP;

-- �Ի��� �⵵��
SELECT TO_CHAR(HIREDATE, 'YYYY') FROM EMP; -- ���ڿ� '1980'

SELECT ENAME, EXTRACT(YEAR FROM HIREDATE) FROM EMP; --�⵵(1980)�� ����

SELECT ENAME, EXTRACT(MONTH FROM HIREDATE) FROM EMP;

------------------------------------------------------------------------------------------
-- (7) �׿�
------------------------------------------------------------------------------------------
-- LEVEL, START, WITH, CONNECT BY PRIOR
SELECT LEVEL, LPAD(' ', LEVEL*2)||ENAME, MGR FROM EMP
WHERE ENAME != 'SCOTT'
    START WITH MGR IS NULL
    CONNECT BY PRIOR EMPNO = MGR; -- �������� �Ʒ������� ��������

--<�� ��������>
-- 1. ���� ��¥�� ����ϰ� TITLE�� ��Current Date���� ����ϴ� SELECT ������ ����Ͻÿ�.
SELECT TO_CHAR(SYSDATE,'YY-MM-DD DY"����"') "Current Date" 
FROM DUAL;

-- 2. EMP ���̺��� ���� �޿��� 15%�� ������ �޿��� ����Ͽ�, �����ȣ,�̸�,����,�޿�,������ �޿�(New Salary),������(Increase)�� ����ϴ� SELECT ������ ����Ͻÿ�.
SELECT EMPNO, ENAME, JOB, SAL, SAL*1.5 AS "New Salary", (SAL*1.5) - SAL AS "Increase" 
FROM EMP;

-- 3. EMP ���̺��� �̸�, �Ի���, �Ի��Ϸκ��� 6���� �� ���ƿ��� ������ ���Ͽ� ����ϴ� SELECT ������ ����Ͻÿ�.
SELECT ENAME, HIREDATE, NEXT_DAY(ADD_MONTHS(HIREDATE,6), '��')
FROM EMP;

-- 4. EMP ���̺��� �̸�, �Ի���, �Ի��Ϸκ��� ��������� ������, �޿�, �Ի��Ϻ��� ��������� ���� �޿��� �Ѱ踦 ����ϴ� SELECT ������ ����Ͻÿ�.
SELECT ENAME, HIREDATE, TRUNC(MONTHS_BETWEEN(SYSDATE,HIREDATE)) AS "WORK MONTH", TRUNC(MONTHS_BETWEEN(SYSDATE,HIREDATE))*SAL AS "TOTAL SAL"  
FROM EMP;

-- 5. EMP ���̺��� ��� ����� �̸��� �޿�(15�ڸ��� ��� ������ �� ���� ��*���� ��ġ)�� ����ϴ� SELECT ������ ����Ͻÿ�.
SELECT ENAME, LPAD(SAL, 15, '*')
FROM EMP;

-- 6. EMP ���̺��� ��� ����� ������ �̸�,����,�Ի���,�Ի��� ������ ����ϴ� SELECT ������ ����Ͻÿ�.
SELECT ENAME, JOB, HIREDATE, TO_CHAR(HIREDATE,'DY"����"') AS ����
FROM EMP;

-- 7. EMP ���̺��� �̸��� ���̰� 6�� �̻��� ����� ������ �̸�,�̸��� ���ڼ�,������ ����ϴ� SELECT ������ ����Ͻÿ�.
SELECT ENAME, LENGTH(ENAME) AS "COUNT", JOB
FROM EMP
WHERE LENGTH(ENAME)>=6;

-- 8. EMP ���̺��� ��� ����� ������ �̸�, ����, �޿�, ���ʽ�, �޿�+���ʽ��� ����ϴ� SELECT ������ ����Ͻÿ�.
SELECT ENAME, JOB, SAL, NVL(COMM,0), SAL+NVL(COMM,0)
FROM EMP;

-- 9.��� ���̺��� ������� 2��° ���ں��� 3���� ���ڸ� �����Ͻÿ�. 
SELECT SUBSTR(ENAME, 2,3)
FROM EMP;

-- 10. ��� ���̺��� �Ի����� 12���� ����� ���, �����, �Ի����� �˻��Ͻÿ�. 
SELECT EMPNO, ENAME, HIREDATE
FROM EMP
WHERE SUBSTR(HIREDATE, 4,2) = '12';

-- 11. ������ ���� ����� �˻��� �� �ִ� SQL ������ �ۼ��Ͻÿ�
-- EMPNO		ENAME		�޿�
-- 7369		SMITH		*******800
-- 7499		ALLEN		******1600
-- 7521		WARD		******1250
-- ����.
SELECT EMPNO, ENAME, LPAD(SAL,10,'*')AS �޿�
FROM EMP;

-- 12. ������ ���� ����� �˻��� �� �ִ� SQL ������ �ۼ��Ͻÿ�
-- EMPNO	 ENAME 	�Ի���
-- 7369	  SMITH		1980-12-17
-- ��.
SELECT EMPNO, ENAME, TO_CHAR(HIREDATE,'YYYY-MM-DD') AS �Ի���
FROM EMP;

-- 13. ��� ���̺��� �޿��� ���� ���, �̸�, �޿�, ����� �˻��ϴ� SQL ������ �ۼ� �Ͻ� ��. �޿��� 0~1000 E / 1001~2000 D / 2001~3000 C / 3001~4000 B / 4001~5000 A

--------�޿���- 0~999 E / 1000~1999 D / 2000~2999 C / 3000~3999 B / 4000�̻� A
SELECT EMPNO, ENAME, SAL, CASE WHEN SAL<=999 THEN 'E' 
                               WHEN SAL <= 1999 THEN 'D'
                               WHEN SAL <= 2999 THEN 'C'
                               WHEN SAL <= 3999 THEN 'B'
                               WHEN SAL >= 4000 THEN 'A'
                               END AS ���
FROM EMP;
SELECT EMPNO, ENAME, SAL,
       CASE
          WHEN SAL BETWEEN 0 AND 999 THEN 'E'
          WHEN SAL BETWEEN 1000 AND 1999 THEN 'D'
          WHEN SAL BETWEEN 2000 AND 2999 THEN 'C'
          WHEN SAL BETWEEN 3000 AND 3999 THEN 'B'
          ELSE 'A'
       END ���
FROM EMP;


-- 14. ��� ���̺��� �μ� ��ȣ�� 20�� ����� ���, �̸�, ����, �޿��� ����Ͻÿ�.(�޿��� �տ� $�� �����ϰ�3�ڸ����� ,�� ����Ѵ�)
SELECT EMPNO, ENAME, JOB, TO_CHAR(SAL, '$9,999,999') AS �޿�
FROM EMP
WHERE DEPTNO IN (20);






















