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
SELECT ENAME, JOB, HIREDATE, TO_CHAR(HIREDATE,'DAY') AS ����
FROM EMP;
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
SELECT ENAME, SUBSTR(ENAME, 2,3)
FROM EMP;

-- 10. ��� ���̺��� �Ի����� 12���� ����� ���, �����, �Ի����� �˻��Ͻÿ�. 
SELECT EMPNO, ENAME, HIREDATE
FROM EMP
WHERE SUBSTR(HIREDATE, 4,2) = '12';

SELECT EMPNO, ENAME, HIREDATE
FROM EMP
WHERE EXTRACT(MONTH FROM HIREDATE)=12;

SELECT EMPNO, ENAME, HIREDATE
FROM EMP
WHERE TO_CHAR(HIREDATE,'MM')='12';

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
SELECT EMPNO, ENAME, SAL, CASE WHEN SAL >=   0 AND SAL <=  999 THEN 'E' 
                               WHEN SAL >=1000 AND SAL <= 1999 THEN 'D'
                               WHEN SAL >=2000 AND SAL <= 2999 THEN 'C'
                               WHEN SAL >=3000 AND SAL <= 3999 THEN 'B'
                               WHEN SAL >= 4000 THEN 'A'
                          END AS ���
FROM EMP;

SELECT EMPNO, ENAME, SAL,
       CASE
          WHEN SAL BETWEEN    0 AND 999 THEN 'E'
          WHEN SAL BETWEEN 1000 AND 1999 THEN 'D'
          WHEN SAL BETWEEN 2000 AND 2999 THEN 'C'
          WHEN SAL BETWEEN 3000 AND 3999 THEN 'B'
          ELSE 'A'
       END ���
FROM EMP;

SELECT EMPNO, ENAME, SAL,
        CASE TRUNC(SAL/1000) WHEN 0 THEN 'E'
                                 WHEN 1 THEN 'D'
                                 WHEN 2 THEN 'C'
                                 WHEN 3 THEN 'B'
        ELSE 'A' END ���
FROM EMP;

-- 14. ��� ���̺��� �μ� ��ȣ�� 20�� ����� ���, �̸�, ����, �޿��� ����Ͻÿ�.(�޿��� �տ� $�� �����ϰ�3�ڸ����� ,�� ����Ѵ�)
SELECT EMPNO, ENAME, JOB, TO_CHAR(SAL, '$9,999,999') AS �޿�
FROM EMP
WHERE DEPTNO IN (20);
