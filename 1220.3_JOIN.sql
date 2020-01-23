-- 2019.12.20_3��. JOIN

SELECT * FROM EMP; -- �������
SELECT * FROM DEPT; -- �μ�����

SELECT * FROM EMP
WHERE ENAME = 'SMITH';

SELECT * FROM DEPT;

-- CROSS JOIN �� ��� ����
SELECT * FROM EMP,DEPT
    WHERE ENAME = 'SMITH';

-- EQUI JOIN(���� ����) 2���� ���̺� ������ �ʵ尡 �ִ°��
SELECT * FROM EMP, DEPT
    WHERE ENAME = 'SMITH' AND EMP.DEPTNO = DEPT.DEPTNO;

SELECT * FROM EMP, DEPT
    WHERE EMP.DEPTNO = DEPT.DEPTNO;

-- ���̺� ������ �ָ� ���� ��� ����ؾ��Ѵ�.    
SELECT E.*, D.DNAME FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO;
    
SELECT E.*, DNAME FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO;

-- ���, �̸�, �μ���ȣ, �μ��̸�, �ٹ���
SELECT * FROM EMP;
SELECT * FROM DEPT;

SELECT EMPNO, ENAME, E.DEPTNO, DNAME, LOC FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

-- ���, �̸� ,�޿�, �μ���ȣ(�μ��ڵ�), �μ���
SELECT EMPNO, ENAME, SAL, E.DEPTNO, DNAME FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

-- �̸�, ����, �޿� �μ���, �ٹ��� �޿��� 2000�̻�
SELECT ENAME, JOB, SAL, DNAME, LOC FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO AND SAL >=2000;
    
-- �̸�, ����, �μ���, �ٹ��� �ٹ����� CHICAGO�� ���
SELECT ENAME, JOB, DNAME, LOC FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO AND LOC IN('CHICAGO');

-- �̸� ,����, �ٹ��� DEPTNO�� 10 �Ǵ� 20�ΰ�� �޿��� ����
SELECT ENAME, JOB, LOC FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO AND D.DEPTNO IN (10, 20)
ORDER BY SAL;

-- �̸�, �޿�, COMM, ����(��Ī), �μ���, �ٹ���. ����=(SAL+COMM)*12 �� COMM�� NULL�̸� 0
SELECT ENAME, SAL, NVL(COMM,0), SAL*12+NVL(COMM,0) AS ����, DNAME, LOC FROM EMP E, DEPT D
WHERE E.DEPTNO= D.DEPTNO;

-- ������ JOB�� SALESMAN�̰ų� MANAGER�� ������� ������ ū ������� ���
SELECT ENAME, SAL, NVL(COMM,0), SAL*12+NVL(COMM,0) AS ����, DNAME, LOC 
    FROM EMP E, DEPT D
    WHERE E.DEPTNO= D.DEPTNO AND JOB IN('SALESMAN','MANAGER')
    ORDER BY ���� DESC;

-- �̐j, �޿�, �Ի���, �μ��ڵ�(��ȣ), �μ���. COMM�� NULL �̰� �޿��� 1200�̻��ΰ��
-- �μ���� ����. �μ����� ������ �޿�ū��
SELECT ENAME, SAL, HIREDATE, E.DEPTNO, DNAME
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO AND COMM IS NULL AND SAL >=1200
    ORDER BY DNAME ASC, SAL DESC;

-- ���忡�� �ٹ��ϴ� ����� �̸��� �޿��� ����Ͻÿ�
SELECT ENAME, SAL  FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO AND LOC IN ('NEW YORK');

-- ACCOUNTING �μ� �Ҽ� ����� �̸��� �Ի����� ����Ͻÿ�
SELECT ENAME, HIREDATE FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO AND DNAME IN ('ACCOUNTING');

-- ������ MANAGER�� ����� �̸�, �μ����� ����Ͻÿ�
SELECT ENAME, DNAME FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO AND JOB IN ('MANAGER');

-- Comm�� null�� �ƴ� ����� �̸�, �޿�, �μ��ڵ�, �ٹ����� ����Ͻÿ�.
SELECT ENAME, SAL, E.DEPTNO, LOC FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO AND COMM IS NOT NULL;

-----------------------------------------------------------------------
-- NON EQUI JOIN (������ �ʵ尡 ���� 2���� ���̺��� JOIN)
-----------------------------------------------------------------------
SELECT * FROM EMP;
SELECT * FROM SALGRADE; -- �޿� ��� ���� ���̺�

SELECT ENAME, SAL, SALGRADE.* FROM EMP, SALGRADE
WHERE ENAME = 'SMITH' AND SAL BETWEEN LOSAL AND HISAL;

SELECT ENAME, SAL, GRADE||'���' AS GRADE FROM EMP, SALGRADE
WHERE SAL BETWEEN LOSAL AND HISAL;

-- Comm�� null�� �ƴ� ����� �̸�, �޿�, ���, �μ���ȣ, �μ��̸�, �ٹ����� ����Ͻÿ�.
SELECT ENAME, SAL, GRADE, E.DEPTNO, DNAME, LOC FROM EMP E, DEPT D, SALGRADE S
WHERE E.DEPTNO = D.DEPTNO AND SAL BETWEEN LOSAL AND HISAL AND COMM IS NOT NULL;

-- �̸�, �޿�, �Ի���, �޿����
SELECT ENAME, SAL, HIREDATE, GRADE FROM EMP, SALGRADE
WHERE SAL BETWEEN LOSAL AND HISAL
ORDER BY GRADE DESC, SAL DESC;

-- �̸�, �޿�, �Ի���, �޿����, �μ���, �ٹ���
SELECT ENAME, SAL, HIREDATE, GRADE, DNAME, LOC FROM EMP E, DEPT D, SALGRADE
WHERE E.DEPTNO=D.DEPTNO AND SAL BETWEEN LOSAL AND HISAL
ORDER BY GRADE DESC;

-- �̸�, �޿�, ���, �μ��ڵ�, �ٹ���. �� comm �� null�ƴ� ���
SELECT ENAME, SAL, GRADE, E.DEPTNO, LOC FROM EMP E, DEPT D, SALGRADE
WHERE E.DEPTNO=D.DEPTNO AND SAL BETWEEN LOSAL AND HISAL AND COMM IS NOT NULL;

-- �̸�, �޿�, �޿����, ����, �μ���, �μ��� ���, �μ��� ������ ������. ����=(sal+comm)*12 comm�� null�̸� 0
SELECT ENAME, SAL, GRADE, (SAL+NVL(COMM,0))*12 AS ����, DNAME
FROM EMP E, DEPT D, SALGRADE
WHERE E.DEPTNO=D.DEPTNO AND SAL BETWEEN LOSAL AND HISAL
ORDER BY DNAME, ����;

-- �̸�, ����, �޿�, ���, �μ��ڵ�, �μ��� ���. �޿��� 1000~3000����. 
-- �������� : �μ���, �μ������� ������, ���������� �޿� ū��
SELECT ENAME, JOB, SAL, GRADE, E.DEPTNO, DNAME
FROM EMP E, DEPT D, SALGRADE
WHERE E.DEPTNO=D.DEPTNO AND SAL BETWEEN LOSAL AND HISAL AND SAL BETWEEN 1000 AND 3000
ORDER BY DNAME, JOB, SAL DESC;

-- �̸�, �޿�, ���, �Ի���, �ٹ���. 81�⿡ �Ի��� ���. ��� ū��
SELECT ENAME, SAL, GRADE, TO_CHAR(HIREDATE, 'YYYY"��" MM"��" DD"��" DY"����" HH24:MI:SS')AS �Ի���, LOC FROM EMP E, DEPT D, SALGRADE
WHERE E.DEPTNO = D.DEPTNO 
AND SAL BETWEEN LOSAL AND HISAL 
AND TO_CHAR(HIREDATE,'YYYY') = '1981'
ORDER BY GRADE DESC;

----------------------------------------------------------------------------------------
-- (4) SELF JOIN : �����̺��� ���� JOIN
----------------------------------------------------------------------------------------
SELECT EMPNO, ENAME, MGR FROM EMP; -- MGR : �� ���ӻ���� ���

SELECT WORK.EMPNO, WORK.ENAME, WORK.MGR, MANAGER.EMPNO, MANAGER.ENAME
FROM EMP WORK, EMP MANAGER
WHERE WORK.ENAME = 'SMITH' AND WORK.MGR = MANAGER.EMPNO;

SELECT WORK.EMPNO, WORK.ENAME AS ���, MANAGER.ENAME AS ���ӻ��
FROM EMP WORK, EMP MANAGER
WHERE WORK.MGR = MANAGER.EMPNO
ORDER BY EMPNO;


SELECT W.ENAME || '�� ���� ' || M.ENAME||'�̴�'
FROM EMP W, EMP M
WHERE W.MGR= M.EMPNO;

-- �Ŵ����� KING�� ������� �̸��� ������ ����Ͻÿ�.
SELECT W.ENAME, W.JOB FROM EMP W, EMP M
WHERE W.MGR=M.EMPNO AND M.ENAME = 'KING';

-- SCOTT�� ������ �μ���ȣ���� �ٹ��ϴ� ����� �̸��� ����Ͻÿ�
SELECT M.ENAME FROM EMP E, EMP M
WHERE E.ENAME = 'SCOTT' AND E.DEPTNO=M.DEPTNO AND M.ENAME <> 'SCOTT';

-- SCOTT�� ������ �ٹ������� �ٹ��ϴ� ����� �̸��� ����Ͻÿ�
-- ���̺� 4�� �̿� 1�ܰ�
SELECT E1.ENAME, E1.DEPTNO, D1.DNAME, E2.ENAME, E2.DEPTNO, D2.DNAME
FROM EMP E1,DEPT D1, EMP E2, DEPT D2
WHERE E1.DEPTNO = D1.DEPTNO AND E2.DEPTNO=D2.DEPTNO -- EQUI JOIN����
AND E1.ENAME = 'SCOTT' 
AND D1.LOC = D2.LOC; -- SELF JOIN ����

-- ���̺� 4�� �̿� �����ܰ�
SELECT E2.ENAME, E2.DEPTNO, D2.DNAME, D1.LOC
FROM EMP E1,DEPT D1, EMP E2, DEPT D2
WHERE E1.DEPTNO = D1.DEPTNO AND E2.DEPTNO=D2.DEPTNO -- EQUI JOIN����
AND E1.ENAME = 'SCOTT' 
AND D1.LOC = D2.LOC
AND E2.ENAME <> 'SCOTT'; -- SELF JOIN ����

------ TEST ------
SELECT * FROM EMP;
INSERT INTO DEPT VALUES (50,'IT','DALLAS');
SELECT * FROM DEPT;
INSERT INTO EMP VALUES(9999,'ȫ�浿','MANAGER',7902,'19/12/20',1000,NULL,50);
ROLLBACK;
------ TEST ------

----------------------------------------------------------------------------------------
-- (5) OUTER JOIN : ���� ���ǿ� �������� �ʴ� ���� ��Ÿ���� �ϴ� ����
----------------------------------------------------------------------------------------
SELECT W.ENAME AS "����", W.MGR, M.EMPNO, M.ENAME AS "���ӻ��"
FROM EMP W, EMP M
WHERE W.MGR=M.EMPNO(+);

-- XX�� �Ŵ����� YY�Դϴ�.(������ '����'����)
SELECT W.ENAME || '�� �Ŵ����� ' || NVL(M.ENAME, '����') || '�Դϴ�.'
FROM EMP W, EMP M
WHERE W.MGR=M.EMPNO(+);

-- ���� ����� ����Ʈ
SELECT M.ENAME FROM EMP W, EMP M WHERE W.MGR(+)=M.EMPNO AND W.ENAME IS NULL;

-- EQUI JOIN���� �սǵ� ������
SELECT * FROM EMP;  --14�� (10,20,30)
SELECT * FROM DEPT; -- 4���μ� (10,20,30,40)
SELECT * FROM EMP, DEPT
WHERE EMP.DEPTNO(+)=DEPT.DEPTNO;

-- �ڡڡ��̸�, ����(JOB), �μ���(DNAME), �޿�(SAL) ���
-- (��,������ ���� �μ��� �Բ� ��� �μ�������, ������ �޿�ū������)
SELECT NVL(ENAME,'-'), NVL(JOB,'-'), DNAME, NVL(TO_CHAR(SAL,'9,999'),'-') 
FROM EMP E, DEPT D
WHERE E.DEPTNO(+)=D.DEPTNO
ORDER BY DNAME, SAL DESC;


-- ���� PART1
-- 1. EMP���̺��� ��� ����� ���� ������ ���ӻ����� ����Ͻÿ�. 
SELECT W.ENAME AS ���, NVL(M.ENAME,'����') AS ���ӻ�� 
FROM EMP W, EMP M
WHERE W.MGR = M.EMPNO(+);

-- 2. ��簡 �ִ� ������ ���� �����, �޿�, ��å, ���ӻ����� ����Ͻÿ�.
SELECT W.ENAME AS ���, W.SAL AS �޿�, W.JOB AS ��å, M.ENAME AS ���ӻ��
FROM EMP W, EMP M
WHERE W.MGR = M.EMPNO;

-- 3. ��簡 ���� ������ ��簡 �ִ� ������ ��ο� ���� �����, �޿�, ��å, ���ӻ����� ����Ͻÿ�.
SELECT W.ENAME AS ���, W.SAL AS �޿�, W.JOB AS ��å, NVL(M.ENAME,'����') AS ���ӻ��
FROM EMP W, EMP M
WHERE W.MGR = M.EMPNO(+);

-- 4. ��簡 �ִ� ������ ���� �����, �����, �޿�, �μ���, ���ӻ����� ����Ͻÿ�.
SELECT W.ENAME AS ���, W.SAL AS �޿�, DNAME AS �μ���, M.ENAME AS ���ӻ��
FROM EMP W, EMP M, DEPT D
WHERE W.MGR = M.EMPNO  AND W.DEPTNO = D.DEPTNO;

-- 5. ��簡 ���� ������ ��簡 �ִ� ���� ��ο� ���� ����, �޿�, �μ��ڵ�, �μ���, �ٹ���, ���ӻ����� ����Ͻÿ�. 
-- ��, ���ӻ�簡 ���� ��� ���ӻ����� ������������ ��� ����Ͻÿ�.
SELECT W.ENAME AS ���, W.SAL AS �޿�, W.DEPTNO AS �μ��ڵ�, DNAME AS �μ���, LOC AS �ٹ���, NVL(M.ENAME,'����') AS ���ӻ��
FROM EMP W, EMP M, DEPT D
WHERE W.MGR = M.EMPNO(+) AND W.DEPTNO = D.DEPTNO;

-- 6. �޿��� 2000�̻��� ����� ���� �����, �޿�, �޿����, �μ���, ���ӻ����� ����Ͻÿ�.
SELECT W.ENAME AS ���, W.SAL AS �޿�, S.GRADE AS �޿����, D.DNAME AS �μ���, M.ENAME AS ���ӻ��
FROM EMP W, EMP M, SALGRADE S, DEPT D
WHERE W.MGR=M.EMPNO AND W.DEPTNO=D.DEPTNO AND W.SAL BETWEEN S.LOSAL AND S.HISAL AND W.SAL >= 2000;

-- 7. ��簡 �ִ� ������ ��簡 ���� ���� ��ο� ���� �����, �޿�, �޿����, �μ���, ���ӻ����� 
-- �μ��� ���ĺ� ������ �����Ͽ� ����Ͻÿ�.
SELECT W.ENAME AS ���, W.SAL AS �޿�, S.GRADE AS �޿����, D.DNAME AS �μ���,NVL(M.ENAME,'����') AS ���ӻ��
FROM EMP W, EMP M, SALGRADE S, DEPT D
WHERE W.MGR=M.EMPNO(+) AND W.DEPTNO=D.DEPTNO AND W.SAL BETWEEN S.LOSAL AND S.HISAL
ORDER BY D.DNAME;

-- 8. �����, �޿�, �޿����, �μ���, ����, ���ӻ����� ����Ͻÿ�. �� ������ (SAL+COMM)*12�� ����Ѵ�.
SELECT W.ENAME AS ���, W.SAL AS �޿�, S.GRADE AS �޿����, D.DNAME AS �μ���, (W.SAL+NVL(W.COMM,0))*12 AS ���� ,NVL(M.ENAME,'����') AS ���ӻ��
FROM EMP W, EMP M, SALGRADE S, DEPT D
WHERE W.MGR=M.EMPNO AND W.DEPTNO=D.DEPTNO AND W.SAL BETWEEN S.LOSAL AND S.HISAL;

-- 9. �� 8���� �μ��� ���ĺ� ������ �����ϰ� �μ����� ������ �޿��� ū ������� ���� ��� ������ �����Ͽ� ����Ͻÿ�.
SELECT W.ENAME AS ���, W.SAL AS �޿�, S.GRADE AS �޿����, D.DNAME AS �μ���, (W.SAL+NVL(W.COMM,0))*12 AS ���� ,NVL(M.ENAME,'����') AS ���ӻ��
FROM EMP W, EMP M, SALGRADE S, DEPT D
WHERE W.MGR=M.EMPNO AND W.DEPTNO=D.DEPTNO AND W.SAL BETWEEN S.LOSAL AND S.HISAL
ORDER BY D.DNAME, W.SAL DESC;

SELECT * FROM EMP;
SELECT * FROM DEPT;
SELECT * FROM SALGRADE;

-- ���� PART2
--1.EMP ���̺��� ��� ����� ���� �̸�,�μ���ȣ,�μ����� ����ϴ� SELECT ������ �ۼ��Ͽ���.
SELECT E.ENAME AS �̸�, E.DEPTNO AS �μ���ȣ, D.DNAME AS �μ���
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO;

--2. EMP ���̺��� NEW YORK���� �ٹ��ϰ� �ִ� ����� ���Ͽ� �̸�,����,�޿�,�μ����� ����ϴ� SELECT ������ �ۼ��Ͽ���.
SELECT E.ENAME AS �̸�, E.JOB AS ����, E.SAL AS �޿�, D.DNAME AS �μ���
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO AND D.LOC IN ('NEW YORK');

--3. EMP ���̺��� ���ʽ��� �޴� ����� ���Ͽ� �̸�,�μ���,��ġ�� ����ϴ� SELECT ������ �ۼ��Ͽ���.
SELECT E.ENAME AS �̸�, D.DNAME AS �μ���, D.LOC AS ��ġ
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO AND COMM IS NOT NULL;

--4. EMP ���̺��� �̸� �� L�ڰ� �ִ� ����� ���Ͽ� �̸�,����,�μ���,��ġ�� ����ϴ� SELECT ������ �ۼ��Ͽ���.
SELECT E.ENAME AS �̸�, JOB AS ����, D.DNAME AS �μ���, D.LOC AS ��ġ
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO AND E.ENAME LIKE '%L%';

--5. ���, �����, �μ��ڵ�, �μ����� �˻��϶�. ������������ ������������
SELECT E.EMPNO AS ���, E.ENAME AS �����, E.DEPTNO AS �μ��ڵ�, D.DNAME AS �μ���
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO
ORDER BY E.ENAME;

--6. ���, �����, �޿�, �μ����� �˻��϶�. �� �޿��� 2000�̻��� ����� ���Ͽ� �޿��� �������� ������������ �����Ͻÿ�
SELECT E.EMPNO AS ���, E.ENAME AS �����, E.SAL AS �޿�, D.DNAME AS �μ���
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO AND SAL >= 2000
ORDER BY SAL DESC;

--7. ���, �����, ����, �޿�, �μ����� �˻��Ͻÿ�. �� ������ MANAGER�̸� 
-- �޿��� 2500�̻��� ����� ���Ͽ� ����� �������� ������������ �����Ͻÿ�.
SELECT E.EMPNO AS ���, E.ENAME AS �����, E.JOB AS ����, E.SAL AS �޿�, D.DNAME AS �μ���
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO AND JOB IN('MANAGER') AND SAL >= 2500
ORDER BY E.EMPNO;

--8. ���, �����, ����, �޿�, ����� �˻��Ͻÿ�. ��, �޿����� ������������ �����Ͻÿ�
SELECT E.EMPNO AS ���, E.ENAME AS �����, E.JOB AS ����, E.SAL AS �޿�, S.GRADE
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
ORDER BY E.SAL DESC;

--9. ������̺��� �����, ����� ��縦 �˻��Ͻÿ�(��簡 ���� �������� ��ü)
SELECT E.ENAME AS �����, NVL(M.ENAME,'����') AS ���
FROM EMP E, EMP M
WHERE E.MGR = M.EMPNO(+);

--10. �����, ����, ����� ������ �˻��Ͻÿ�
SELECT E1.ENAME AS �����, E2.ENAME AS ��� , E3.ENAME AS "����� ���"
FROM EMP E1, EMP E2, EMP E3
WHERE E1.MGR = E2.EMPNO AND E2.MGR=E3.EMPNO;

--11. ���� ������� ���� ��簡 ���� ��� ������ �̸��� ��µǵ��� �����Ͻÿ�
SELECT E1.ENAME AS �����, NVL(E2.ENAME,'����') AS ���, NVL(E3.ENAME,'����') AS "����� ���"
FROM EMP E1, EMP E2, EMP E3
WHERE E1.MGR = E2.EMPNO AND E2.MGR=E3.EMPNO(+);




















