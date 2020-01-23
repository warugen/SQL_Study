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
WHERE E.DEPTNO=D.DEPTNO AND COMM IS NOT NULL AND COMM <> 0;

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
WHERE E1.MGR = E2.EMPNO(+) AND E2.MGR=E3.EMPNO(+);

SELECT E1.ENAME AS �����, '��'||E2.ENAME AS ���, '��'||E3.ENAME AS "����� ���"
FROM EMP E1, EMP E2, EMP E3
WHERE E1.MGR = E2.EMPNO(+) AND E2.MGR=E3.EMPNO(+);