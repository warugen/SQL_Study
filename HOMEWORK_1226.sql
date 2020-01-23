-- 1. ������̺��� ���� ���� �Ի��� ����� �̸�, �޿�, �Ի���
SELECT ENAME, SAL, HIREDATE
FROM EMP
WHERE HIREDATE = (SELECT MIN(HIREDATE) FROM EMP);

-- 2. ȸ�翡�� ���� �޿��� ���� ����� �̸�, �޿�
SELECT ENAME, SAL
FROM EMP
WHERE SAL = (SELECT MIN(SAL) FROM EMP);

-- 3. ȸ�� ��պ��� �޿��� ���� �޴� ����� �̸�, �޿�, �μ��ڵ�
SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL > (SELECT AVG(SAL) FROM EMP);

-- 4. ȸ�� ��� ������ �޿��� �޴� ����� �̸�, �޿�, �μ���
SELECT ENAME, SAL, DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO AND SAL < (SELECT AVG(SAL) FROM EMP);

-- 5. SCOTT���� ���� �Ի��� ����� �̸�, �޿�, �Ի���, �޿� ���
SELECT ENAME, SAL, HIREDATE, GRADE
FROM EMP E, SALGRADE S
WHERE SAL BETWEEN LOSAL AND HISAL 
AND HIREDATE < (SELECT HIREDATE FROM EMP WHERE ENAME='SCOTT');

-- 6. 5���� �μ��� �߰��ϰ� �޿��� ū �� ����
SELECT ENAME, SAL, HIREDATE, GRADE, DNAME
FROM EMP E, SALGRADE S, DEPT D
WHERE E.DEPTNO=D.DEPTNO 
AND SAL BETWEEN LOSAL AND HISAL 
AND HIREDATE < (SELECT HIREDATE FROM EMP WHERE ENAME='SCOTT')
ORDER BY SAL DESC;

-- 7. ������̺��� BLAKE ���� �޿��� ���� ������� ���, �̸�, �޿��� �˻�
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > (SELECT SAL FROM EMP WHERE ENAME = 'BLAKE');

-- 8. ������̺��� MILLER���� �ʰ� �Ի��� ����� ���, �̸�, �Ի����� �˻��Ͻÿ�
SELECT EMPNO, ENAME, HIREDATE
FROM EMP
WHERE HIREDATE > (SELECT HIREDATE FROM EMP WHERE ENAME = 'MILLER');

-- 9. ������̺��� �����ü ��� �޿����� �޿��� ���� ������� ���, �̸�, �޿��� �˻�
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > (SELECT AVG(SAL) FROM EMP);

-- 10. ������̺��� CLARK�� ���� �μ���, ����� 7698�� ������ �޿����� ���� �޿��� �޴� ������� ���, �̸�, �޿� �˻�
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL > (SELECT SAL 
             FROM EMP 
             WHERE EMPNO = 7698)
AND DEPTNO = (SELECT DEPTNO 
              FROM EMP 
              WHERE ENAME = 'CLARK');
              

-- 11. �����ȭ. ������̺��� CLARK�� ���� �μ����̸�, ����� 7698�� ������ �޿����� ���� �޿��� �޴� 
-- ������� ���, �̸�, �޿� �˻�
SELECT EMPNO, ENAME, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND SAL > (SELECT SAL 
             FROM EMP 
             WHERE EMPNO = 7698)
AND DNAME = (SELECT DNAME 
             FROM EMP E, DEPT D
             WHERE E.DEPTNO=D.DEPTNO 
             AND ENAME = 'CLARK');

-- 12. ��� ���̺��� BLAKE�� ���� �μ��� �ִ� ��� ����� �̸��� �Ի����ڸ� ����ϴ� SELECT���� �ۼ��Ͻÿ�.
SELECT ENAME, HIREDATE
FROM EMP
WHERE DEPTNO = (SELECT DEPTNO FROM EMP WHERE ENAME = 'BLAKE');


-- 13. ��� ���̺��� ��� �޿� �̻��� �޴� ��� �������� ���ؼ� 
-- ������ ��ȣ�� �̸��� ����ϴ� SELECT���� �ۼ��Ͻÿ�. (�� �޿��� ���� ������ ����Ͽ���.)
SELECT EMPNO, ENAME
FROM EMP
WHERE SAL > (SELECT AVG(SAL) FROM EMP)
ORDER BY SAL DESC;

-- ���⼭���ʹ� �����༭������, ������ �����༭������
-- 14. ��� ���̺��� �̸��� ��T���� �ִ� ����� �ٹ��ϴ� �μ����� �ٹ��ϴ� ��� �������� ���� 
-- ��� ��ȣ,�̸�,�޿��� ����ϴ� SELECT���� �ۼ��Ͻÿ�. �� �����ȣ ������ ����Ͽ���.
SELECT EMPNO, ENAME, SAL 
FROM EMP
WHERE DEPTNO IN ( SELECT E.DEPTNO FROM EMP E, DEPT D WHERE E.DEPTNO=D.DEPTNO AND ENAME LIKE '%T%')
ORDER BY EMPNO;


-- 15. ��� ���̺��� �μ� ��ġ�� Dallas�� ��� �������� ���� �̸�,����,�޿��� ����ϴ� SELECT���� �ۼ��Ͻÿ�.
SELECT ENAME, JOB, SAL
FROM EMP
WHERE DEPTNO IN (SELECT E.DEPTNO FROM EMP E, DEPT D WHERE E.DEPTNO=D.DEPTNO AND LOC = 'DALLAS');


-- 16. EMP ���̺��� King���� �����ϴ� ��� ����� �̸��� �޿��� ����ϴ� SELECT���� �ۼ��Ͻÿ�.
SELECT ENAME, SAL
FROM EMP
WHERE MGR IN (SELECT EMPNO FROM EMP WHERE ENAME = 'KING');

SELECT ENAME, SAL
FROM EMP W
WHERE EXISTS (SELECT * FROM EMP M WHERE M.EMPNO=W.MGR AND ENAME = 'KING');

-- 17. ��� ���̺��� SALES�μ� ����� �̸�,������ ����ϴ� SELECT���� �ۼ��Ͻÿ�.
SELECT ENAME, JOB
FROM EMP
WHERE DEPTNO IN (SELECT DEPTNO FROM DEPT WHERE DNAME = 'SALES');

-- 18. ��� ���̺��� ������ �μ� 30�� ���� ���޺��� ���� ����� ����ϴ� SELECT���� �ۼ��Ͻÿ�.
SELECT * 
FROM EMP
WHERE SAL > ANY (SELECT MIN(SAL) FROM EMP WHERE DEPTNO=30);

-- 19. ��� ���̺��� �μ� 10���� �μ� 30�� ����� ���� ������ �ð� �ִ� ����� �̸��� ������ ����ϴ� SELECT���� �ۼ��Ͻÿ�.
SELECT ENAME, JOB
FROM EMP
WHERE JOB IN ( SELECT JOB FROM EMP WHERE DEPTNO = 30)
AND DEPTNO = 10;

-- 20. ��� ���̺��� FORD�� ������ ���޵� ���� ����� ��� ������ ����ϴ� SELECT���� �ۼ��Ͻÿ�.
SELECT *
FROM EMP
WHERE (JOB, SAL) IN (SELECT JOB, SAL FROM EMP WHERE ENAME = 'FORD')
AND ENAME <> 'FORD';

-- 21. ��� ���̺��� �̸��� JONES�� ������ JOB�� ���ų� ������ FORD�̻��� ����� ������ 
-- �̸�,����,�μ���ȣ,�޿��� ����ϴ� SELECT���� �ۼ�. ��, ������ ���ĺ� ��, ������ ���� ������ ����Ͽ���.
SELECT ENAME, JOB, DEPTNO, SAL
FROM EMP
WHERE JOB IN (SELECT JOB FROM EMP WHERE ENAME='JONES')
OR SAL IN (SELECT SAL FROM EMP WHERE ENAME = 'FORD')
ORDER BY JOB, SAL DESC;

-- 22. ��� ���̺��� SCOTT �Ǵ� WARD�� ������ ���� ����� ������ �̸�,����,�޿��� ����ϴ� SELECT���� �ۼ��Ͻÿ�.
SELECT ENAME, JOB, SAL
FROM EMP
WHERE SAL IN ( SELECT SAL FROM EMP WHERE ENAME = 'SCOTT' OR ENAME = 'WARD')
AND ENAME NOT IN ('SCOTT','WARD');

-- 23. ��� ���̺��� CHICAGO���� �ٹ��ϴ� ����� ���� ������ �ϴ� ������� �̸�,������ ����ϴ� SELECT���� �ۼ��Ͻÿ�.
SELECT ENAME, JOB
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO
AND DNAME IN (SELECT DNAME FROM DEPT WHERE LOC = 'CHICAGO');
-- �����(����)
SELECT ENAME, JOB 
FROM EMP 
WHERE JOB IN (SELECT JOB FROM EMP E, DEPT D
              WHERE E.DEPTNO=D.DEPTNO 
              AND LOC='CHICAGO');

-- 24. ��� ���̺��� �μ����� ������ ��� ���޺��� ���� ����� �����ȣ,�̸�,�޿��� ����ϴ� SELECT���� �ۼ��Ͻÿ�.
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > ALL (SELECT AVG(SAL) FROM EMP GROUP BY DEPTNO);

-- �����(����)
SELECT EMPNO, ENAME, SAL
FROM EMP E
WHERE SAL > (SELECT AVG(SAL) FROM EMP WHERE DEPTNO=E.DEPTNO);

-- 25. ��� ���̺��� �������� ������ ��� ���޺��� ���� ����� �μ���ȣ,�̸�,�޿��� ����ϴ� SELECT���� �ۼ��Ͻÿ�.
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL < ALL (SELECT AVG(SAL) FROM EMP GROUP BY JOB);

-- �����(����)
SELECT EMPNO, ENAME, SAL
FROM EMP E
WHERE SAL < (SELECT AVG(SAL) FROM EMP WHERE JOB = E.JOB);

-- 26 ��� ���̺��� ��� �Ѹ� �̻����κ��� ���� ���� �� �ִ� ����� 
-- ����,�̸�,�����ȣ,�μ���ȣ�� ���(��, �μ���ȣ ������ �������� ����)
SELECT JOB, ENAME, EMPNO, DEPTNO
FROM EMP MANAGER
WHERE EXISTS(SELECT EMPNO FROM EMP WHERE MANAGER.EMPNO=MGR);

SELECT JOB, ENAME, EMPNO, DEPTNO
FROM EMP 
WHERE EMPNO IN ( SELECT DISTINCT MGR FROM EMP);

-- 27. ��� ���̺��� ���� ����� �����ȣ,�̸�,����,�μ���ȣ�� ����ϴ� SELECT���� �ۼ��Ͻÿ�.
SELECT JOB, ENAME, EMPNO, DEPTNO
FROM EMP MANAGER
WHERE NOT EXISTS(SELECT EMPNO FROM EMP WHERE MANAGER.EMPNO=MGR);

SELECT JOB, ENAME, EMPNO, DEPTNO
FROM EMP 
WHERE EMPNO NOT IN ( SELECT DISTINCT MGR FROM EMP WHERE MGR IS NOT NULL);