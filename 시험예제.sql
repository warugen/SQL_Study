0-- 1.TO_DATE ������ �Լ��� �̿��Ͽ� EMP ���̺��� HIREDATE�� 1981�� 02�� 20��
-- 1981�� 5�� 1�� ���̿� �Ի��� ����� �����, ��å, �Ի����� ���� �Ի��Ϻ��� �ֱ� �Ի��� ������ �����Ͽ� ���

SELECT ENAME, JOB, HIREDATE
FROM EMP
WHERE HIREDATE BETWEEN TO_DATE('19810220','YYYYMMDD') AND TO_DATE('19810501','YYYYMMDD')
ORDER BY HIREDATE;

-- 2.EMP���̺�� DEPT���̺��� �̿��Ͽ� ����� �޿�, �μ���ȣ, �μ���, �ٹ���, ���� ������ ����Ͻÿ�
-- ��, ���ӻ�簡 ���� ��� ���ӻ����� '����'���� ��� ���
SELECT E.ENAME, E.SAL, E.DEPTNO, DNAME, LOC, NVL(M.ENAME,'����') ����
FROM EMP E, EMP M, DEPT D
WHERE E.MGR=M.EMPNO(+) AND E.DEPTNO=D.DEPTNO;

-- 3.EMP���̺��� ����� ���ĺ� L�� �ִ� ����� ���� �����, ��å, �μ���, �ٹ����� ���
SELECT ENAME, JOB, DNAME, LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO AND ENAME LIKE '%L%';

-- 4.SALGRADE���̺��� LOSAL�� ���ó�� �޿�, HISAL�� ��� �ְ� �޿��� �̿��Ͽ� EMP���̺��� ����� ���, �����, ��å, �޿�, �޿������
-- �޿��������� �������� �����Ͽ� �ٷ�
SELECT EMPNO, ENAME, JOB, SAL, GRADE
FROM EMP, SALGRADE
WHERE SAL BETWEEN LOSAL AND HISAL
ORDER BY SAL DESC;

-- 5.EMP���̺��� �μ���ȣ�� 20���� ����� ���, �����, �޿��� ����ϵ� �޿� �տ��� $�� ���̰� ���ڴ� 3�ڸ����� �޸�(,)�� �߰��Ͽ����
SELECT EMPNO, ENAME, TO_CHAR(SAL, '$99,999') 
FROM EMP
WHERE DEPTNO=20;

-- 6.������� 5�� �̻��� �μ���� ������� ����ϴ� SQL��
SELECT DNAME, COUNT(*)
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO GROUP BY DNAME HAVING COUNT(*) >=5;

-- 7.������� FORD�� ������ ��å(JOB)�� �޿�(SAL)�� ���� ����� ��� ������ ���
SELECT * FROM EMP WHERE (JOB, SAL) IN (SELECT JOB, SAL FROM EMP WHERE ENAME = 'FORD') AND ENAME != 'FORD';

-- 8.�̸�(ENAME)�� 'KING'�� ����� ���Ӻ����� �����(ENAME)�� �޿�(SAL)�� ���
SELECT ENAME, SAL
FROM EMP
WHERE MGR=(SELECT EMPNO FROM EMP WHERE ENAME='KING');

-- 9. �޿��� ������ �μ��� ��� �޿����� ���� ����鸸 ���, �����, �޿�, �μ���ȣ�� ���
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP E
WHERE SAL > (SELECT AVG(SAL) FROM EMP WHERE E.DEPTNO=DEPTNO);

-- 10. EMP���̺��� ������� 'FORD'�� ����� �����ϴ� SQL���� �ۼ�
DELETE FROM EMP WHERE ENAME = 'FORD';

-- 11.EMP ���̺��� �޿��� 3000�̻��� ����鸸 �޿��� 10% �λ��Ű�� SQL�� �ۼ� 
UPDATE EMP SET SAL = SAL *1.1 WHERE SAL>=3000;

-- 12.EMP���̺��� SCOTT����� �μ���ȣ�� 20������, ��å�� MANAGER�� �����ϴ� SQL�� �ۼ�
UPDATE EMP SET DEPTNO=20, JOB = 'MANAGER' WHERE ENAME = 'SCOTT';

-- 13.EMP���̺�� DEPT���̺��� �̿��Ͽ�, 'DALLAS'���� �ٹ��ϴ� �������� �޿��� 1000�� �λ��Ű�� SQL�� �ۼ�           
UPDATE EMP SET SAL = SAL+1000
    WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE LOC  = 'DALLAS');
    
-- 14.EMP���̺��� �ֱ� �Ի��ϼ����� 6��°�� ������� �ֱ� �Ի��� �� 10��° �������
-- ���, �����, �Ի����� ����ϴ� SQL�� �ۼ�
SELECT RN, EMPNO, ENAME, HIREDATE 
    FROM (SELECT ROWNUM RN, A.*
            FROM (SELECT * FROM EMP ORDER BY HIREDATE DESC) A)
WHERE RN BETWEEN 6 AND 10;

-- 15.�����ͺ��̽����� Ʈ������� ������ ó���� �� ������ ���Ѵ�. �����͸� �����ϱ� ���� INSERT, UPDATE, DELETE����
-- ��ɵ��� ����ʰ� ���ÿ� Ʈ������� ����Ǵµ�, �̵� INSERT,UPDATE,DELETE�۾��� ���������� �����ͺ��̽��� �ݿ�.ó���ǵ���
-- ��ɾ �ۼ��Ͻÿ�
COMMIT;
