
------------------------------------------------------------------------------------------
-- VI. SUB QUERY
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
-- ������ ��������
------------------------------------------------------------------------------------------
-- SCOTT�� �ٹ��ϴ� �μ��̸�
SELECT DNAME FROM DEPT D, EMP E
WHERE E.DEPTNO=D.DEPTNO AND ENAME='SCOTT';

SELECT DNAME FROM DEPT
WHERE DEPTNO = (SELECT DEPTNO FROM EMP WHERE ENAME='SCOTT');

-- �������� ���� : �����༭������, �����༭������
-- JOB�� 'MANAGER'�� ����� �μ��̸�
SELECT DEPTNO FROM EMP WHERE JOB='MANAGER';

SELECT DNAME FROM DEPT
WHERE DEPTNO IN (SELECT DEPTNO FROM EMP WHERE JOB='MANAGER');

-- ������ ��������
SELECT MAX(SAL) FROM EMP; -- �ְ�޿� SAL
-- �ְ�ݾ� SAL�� �޴� ����� �̸�, �ְ�ݾ�SAL
SELECT ENAME, SAL FROM EMP WHERE SAL = (SELECT MAX(SAL) FROM EMP);

-- SCOTT�� ���� �μ��� �ٹ��ϴ� ����� �̸�
SELECT ENAME 
FROM EMP 
WHERE DEPTNO = (SELECT DEPTNO FROM EMP WHERE ENAME='SCOTT') AND ENAME != 'SCOTT';

-- SCOTT�� ���� �ٹ����� �ٹ��ϴ� ����� �̸�
INSERT INTO DEPT VALUES (50,'IT','DALLAS');
SELECT * FROM DEPT;
INSERT INTO EMP VALUES (9999,'ȫ�浿',NULL,NULL,NULL,9000,NULL,50);
SELECT * FROM EMP;


SELECT LOC FROM DEPT D, EMP E
WHERE D.DEPTNO=E.DEPTNO AND ENAME = 'SCOTT';

SELECT ENAME FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO AND LOC = (SELECT LOC 
                                   FROM DEPT D, EMP E
                                   WHERE D.DEPTNO=E.DEPTNO AND ENAME = 'SCOTT') 
                                   AND ENAME <> 'SCOTT';

ROLLBACK;

-- SCOTT�� ���� JOB�� ���� ������� ��� ���� ���
SELECT JOB FROM EMP WHERE ENAME = 'SCOTT';

SELECT * FROM EMP
WHERE JOB = (SELECT JOB FROM EMP WHERE ENAME = 'SCOTT') AND ENAME <> 'SCOTT';

-- SCOTT�� �޿��� �����ϰų� �� ���� �޴� ����� �̸��� �޿��� ���
SELECT SAL FROM EMP WHERE ENAME = 'SCOTT';

SELECT ENAME, SAL
FROM EMP
WHERE SAL >= (SELECT SAL FROM EMP WHERE ENAME = 'SCOTT') AND ENAME <> 'SCOTT';

-- ���ӻ���� KING�� ����� �̸��� �޿�
SELECT EMPNO FROM EMP WHERE ENAME='KING';

SELECT ENAME, SAL
FROM EMP
WHERE MGR=(SELECT EMPNO FROM EMP WHERE ENAME='KING');

-- ��ձ޿� ���ϸ� �޴� ������ ���, �̸�, �޿�
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL < (SELECT AVG(SAL) FROM EMP);

-- �μ��� �ִ� �޿��� �� �ִ� �޿��� �޴� ����� �̸�, �׻���� �޿�
SELECT DEPTNO, MAX(SAL)
FROM EMP 
GROUP BY DEPTNO;

SELECT DEPTNO, SAL, ENAME FROM EMP
WHERE (DEPTNO,SAL) 
    IN (SELECT DEPTNO, MAX(SAL)
        FROM EMP 
        GROUP BY DEPTNO);

-- ����������༭������
-- SCOTT�� JOB�� ���� �μ���ȣ�� ���� ����� ��� �ʵ带 ���
SELECT * FROM EMP
WHERE (JOB, DEPTNO) = (SELECT JOB, DEPTNO FROM EMP WHERE ENAME = 'SCOTT');


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


------------------------------------------------------------------------------------------
-- �����༭������ : ���������� �������� ������ IN, NOT IN, ANY=SOME, ALL, EXIST
------------------------------------------------------------------------------------------
-- �μ���ȣ, DEPTNO ���� �ִ�޿�, �� �ִ�޿��� �޴� ����� �̸�
SELECT DEPTNO, MAX(SAL) FROM EMP GROUP BY DEPTNO; -- ��������

SELECT DEPTNO, SAL, ENAME 
FROM EMP
WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL) FROM EMP GROUP BY DEPTNO);

-- �Ի�⺰ �ּ� �޿��� �޴� ���
SELECT TO_CHAR(HIREDATE, 'YY'), MIN(SAL) FROM EMP GROUP BY TO_CHAR(HIREDATE, 'YY'); -- ��������

SELECT TO_CHAR(HIREDATE, 'YY') AS "YEAR", SAL, ENAME
FROM EMP
WHERE (TO_CHAR(HIREDATE, 'YY'), SAL) 
    IN (SELECT TO_CHAR(HIREDATE, 'YY'), MIN(SAL) 
        FROM EMP 
        GROUP BY TO_CHAR(HIREDATE, 'YY'))
ORDER BY TO_CHAR(HIREDATE, 'YY');

-- �޿��� 3000�̻� �޴� ����� �Ҽӵ� �μ��� ������ �μ����� �ٹ��ϴ� ������� ����ʵ�
SELECT DEPTNO FROM EMP WHERE SAL >= 3000;

SELECT *
FROM EMP
WHERE DEPTNO IN (SELECT DEPTNO FROM EMP WHERE SAL >= 3000);

-- �μ����� �Ի����� ���� ���� ����� �μ���ȣ, �̸�, �Ի����� ���
SELECT DEPTNO, MAX(HIREDATE)
FROM EMP
GROUP BY DEPTNO;

SELECT DEPTNO, ENAME, HIREDATE
FROM EMP
WHERE (DEPTNO,HIREDATE) IN 
                    (SELECT DEPTNO, MAX(HIREDATE)
                    FROM EMP
                    GROUP BY DEPTNO)
ORDER BY DEPTNO;

-- JOB�� ���� ���� ������ �޴� ����� �̸�, JOB, ����
SELECT JOB, MIN(SAL)
FROM EMP
GROUP BY JOB;

SELECT ENAME, JOB, SAL
FROM EMP
WHERE (JOB, SAL) IN (SELECT JOB, MIN(SAL)
FROM EMP
GROUP BY JOB)
ORDER BY JOB;


-- 30�� �μ� ����� �޿��� ���� ���� ������� �� �޿��� �޴� ����� �̸�, �޿�
SELECT SAL
FROM EMP
WHERE DEPTNO = 30;
-- ������
SELECT ENAME, SAL
FROM EMP
WHERE SAL > ALL (SELECT SAL
                FROM EMP
                WHERE DEPTNO = 30);
-- ������
SELECT ENAME, SAL
FROM EMP
WHERE SAL > (SELECT MAX(SAL)
            FROM EMP
            WHERE DEPTNO = 30);

-- 30�� �μ� ��� �޿��� �� ���� ���� �� ���� ���� �޿��� �޴� ����� �̸�, �޿�
SELECT SAL
FROM EMP
WHERE DEPTNO = 30;

-- ������
SELECT ENAME, SAL FROM EMP
WHERE SAL > ANY (SELECT SAL FROM EMP WHERE DEPTNO=30);
-- ������
SELECT ENAME, SAL FROM EMP
WHERE SAL > (SELECT MIN(SAL) FROM EMP WHERE DEPTNO=30);

-- ���Ӻ��ϰ� �ִ� ������ �����ȣ, �̸�, �޿� ���
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE EMPNO IN (SELECT MGR FROM EMP);

-- EXISTS����غ���
SELECT EMPNO, ENAME, SAL FROM EMP MANAGER
WHERE EXISTS (SELECT EMPNO FROM EMP WORKER WHERE WORKER.MGR = MANAGER.EMPNO);

SELECT EMPNO, ENAME, SAL FROM EMP MANAGER
WHERE EXISTS (SELECT EMPNO FROM EMP WHERE MGR=MANAGER.EMPNO);

-- ���, �̸�, �μ���ȣ, SAL, �ش����� �μ� ���(SELECT���� ��������)
SELECT EMPNO, ENAME, DEPTNO, SAL, (SELECT AVG(SAL) FROM EMP WHERE DEPTNO=E.DEPTNO) AS ���
FROM EMP E;

-- ���Ӻ��ϰ� ���� ������ �����ȣ, �̸�, �޿� ���
-- SELF JOIN �̿�
SELECT M.*
FROM EMP E, EMP M
WHERE E.MGR(+)=M.EMPNO
AND E.MGR IS NULL;

-- IN ������ �̿�
SELECT * FROM EMP MANAGER
WHERE EMPNO NOT IN (SELECT MGR FROM EMP WOKER WHERE WOKER.MGR=MANAGER.EMPNO);

SELECT * FROM EMP MANAGER
WHERE EMPNO NOT IN (SELECT MGR FROM EMP WOKER WHERE WOKER.MGR IS NOT NULL);

-- EXISTS �̿�
SELECT * FROM EMP MANAGER
WHERE NOT EXISTS ( SELECT * FROM EMP WORKER WHERE WORKER.MGR= MANAGER.EMPNO);

-- źź ������
-- �μ����� ���� �޿��� ���� �޴� ����� ����(��� ��ȣ, ����̸�, �޿�, �μ���ȣ)�� ���(IN ������ �̿�)
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL) FROM EMP GROUP BY DEPTNO);
	 
-- ����(JOB)�� MANAGER�� ����� ���� �μ��� �μ� ��ȣ�� �μ���� ������ ���(IN)
SELECT D.DEPTNO, DNAME, LOC
FROM DEPT D
WHERE D.DEPTNO IN (SELECT DEPTNO FROM EMP WHERE JOB='MANAGER');
	
-- 	������ 3000�̻��� ����� �� ���� ����� ����� �ش� ��޺� �ְ� ������ �޴� ������� 
-- ���, �̸�, ����, �Ի���, �޿�, �޿������ ���
SELECT EMPNO, ENAME, JOB, HIREDATE, SAL, GRADE
FROM EMP, SALGRADE
WHERE SAL BETWEEN LOSAL AND HISAL
AND EMPNO IN (SELECT EMPNO FROM EMP WHERE SAL >=3000);
-- ����Թ��� --
SELECT EMPNO, ENAME, JOB, HIREDATE, SAL, GRADE
FROM EMP, SALGRADE
WHERE SAL BETWEEN LOSAL AND HISAL
AND (GRADE, SAL) IN (SELECT GRADE, MAX(SAL) FROM EMP, SALGRADE WHERE SAL BETWEEN LOSAL AND HISAL AND SAL >= 3000 GROUP BY GRADE);

	
-- 	�����ȭ : �Ի��� �б⺰�� ���� ���� ������ �޴� ������� �б�, ���, �̸�, JOB, �����, �Ի���, �޿�, �󿩸� ����ϼ���
SELECT HIREDATE, CEIL(EXTRACT(MONTH FROM HIREDATE)/3) || '�б�' AS QUARTER FROM EMP;
SELECT HIREDATE, CEIL(TO_CHAR(HIREDATE,'MM')/3) || '�б�' AS QUARTER FROM EMP;

-- ��������(�б⺰ ������� ����)
SELECT CEIL(EXTRACT(MONTH FROM HIREDATE)/3) || '�б�', MAX(SAL) FROM EMP
GROUP BY CEIL(EXTRACT(MONTH FROM HIREDATE)/3);

-- ��������
SELECT CEIL(EXTRACT(MONTH FROM HIREDATE)/3) || '�б�' AS QUARTER, EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM
FROM EMP
WHERE (CEIL(EXTRACT(MONTH FROM HIREDATE)/3) ,SAL) IN (SELECT CEIL(EXTRACT(MONTH FROM HIREDATE)/3), MAX(SAL) 
                                                      FROM EMP
                                                      GROUP BY CEIL(EXTRACT(MONTH FROM HIREDATE)/3))
ORDER BY QUARTER;
	
-- 	SALESMAN ��� ����� ���� �޿��� ���� �޴� ������� �̸��� �޿��� ����(��� ����)�� ����ϵ� ���� ����� ������� �ʴ´�.(ALL�̿�)
SELECT JOB, SAL, ENAME FROM EMP WHERE JOB='SALESMAN';

SELECT ENAME, SAL, JOB
FROM EMP
WHERE SAL > ALL (SELECT SAL FROM EMP WHERE JOB='SALESMAN')
AND JOB <> 'SALEMAN';

SELECT ENAME, SAL, JOB FROM EMP
WHERE SAL > (SELECT MAX(SAL) FROM EMP WHERE JOB='SALESMAN')
AND JOB <> 'SALEMAN';
	
-- 	SALESMAN �Ϻ� � �� ������� �޿��� ���� �޴� ������� �̸��� �޿��� ����(��� ����)�� ����ϵ� ���� ����� �����ؼ� ���(ANY)
SELECT ENAME, SAL, JOB
FROM EMP
WHERE SAL > ANY (SELECT SAL FROM EMP WHERE JOB='SALESMAN')
	
-- 	������ 3000�̸��� ��� �߿� ���� �ֱٿ� �Ի��� ����� �����ȣ�� �̸�, ����, �Ի����� ���
SELECT EMPNO, ENAME, SAL, HIREDATE
FROM EMP 
WHERE SAL < 3000;

SELECT EMPNO, ENAME, SAL, HIREDATE
FROM EMP
WHERE HIREDATE IN (SELECT MAX(HIREDATE) FROM EMP WHERE SAL < 3000);
	
-- ������ ��SALESMAN���� ����� �޴� �޿��� �ּ� �޿����� ���� �޴� ������� �̸�, �޿�, ����, �μ���ȣ�� ����ϵ� 
-- �μ���ȣ�� 20���� ����� �����Ѵ�(ANY ������ �̿�)
SELECT MIN(SAL)
FROM EMP
WHERE JOB = 'SALESMAN';

SELECT ENAME, SAL, JOB, DEPTNO
FROM EMP
WHERE SAL > ANY (SELECT MIN(SAL)
                 FROM EMP
                 WHERE JOB = 'SALESMAN')
AND DEPTNO <> 20;


-- ���⼭���ʹ� �����༭������, ������ �����༭������
-- 14. ��� ���̺��� �̸��� ��T���� �ִ� ����� �ٹ��ϴ� �μ����� �ٹ��ϴ� ��� �������� ���� 
-- ��� ��ȣ,�̸�,�޿��� ����ϴ� SELECT���� �ۼ��Ͻÿ�. �� �����ȣ ������ ����Ͽ���.
SELECT E.EMPNO FROM EMP E, DEPT D WHERE E.DEPTNO=D.DEPTNO AND ENAME LIKE '%T%';

SELECT EMPNO, ENAME, SAL 
FROM EMP
WHERE EMPNO IN ( SELECT E.EMPNO FROM EMP E, DEPT D WHERE E.DEPTNO=D.DEPTNO AND ENAME LIKE '%T%');


-- 15. ��� ���̺��� �μ� ��ġ�� Dallas�� ��� �������� ���� �̸�,����,�޿��� ����ϴ� SELECT���� �ۼ��Ͻÿ�.
SELECT E.EMPNO FROM EMP E, DEPT D WHERE E.DEPTNO=D.DEPTNO AND LOC = 'DALLAS';

SELECT ENAME, JOB, SAL
FROM EMP
WHERE EMPNO IN (SELECT E.EMPNO FROM EMP E, DEPT D WHERE E.DEPTNO=D.DEPTNO AND LOC = 'DALLAS');


-- 16. EMP ���̺��� King���� �����ϴ� ��� ����� �̸��� �޿��� ����ϴ� SELECT���� �ۼ��Ͻÿ�.
SELECT ENAME, SAL
FROM EMP
WHERE MGR IN (SELECT EMPNO FROM EMP WHERE ENAME = 'KING');

-- 17. ��� ���̺��� SALES�μ� ����� �̸�,������ ����ϴ� SELECT���� �ۼ��Ͻÿ�.
SELECT DEPTNO FROM DEPT WHERE DNAME = 'SALES';

SELECT ENAME, JOB
FROM EMP
WHERE DEPTNO IN (SELECT DEPTNO FROM DEPT WHERE DNAME = 'SALES');

-- 18. ��� ���̺��� ������ �μ� 30�� ���� ���޺��� ���� ����� ����ϴ� SELECT���� �ۼ��Ͻÿ�.
SELECT MIN(SAL) FROM EMP WHERE DEPTNO=30;

SELECT * 
FROM EMP
WHERE SAL > ALL (SELECT MIN(SAL) FROM EMP WHERE DEPTNO=30);

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
WHERE SAL IN ( SELECT SAL FROM EMP WHERE ENAME = 'SCOTT' OR ENAME = 'WARD');

-- 23. ��� ���̺��� CHICAGO���� �ٹ��ϴ� ����� ���� ������ �ϴ� ������� �̸�,������ ����ϴ� SELECT���� �ۼ��Ͻÿ�.
SELECT ENAME, JOB
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO
AND DNAME IN (SELECT DNAME FROM DEPT WHERE LOC = 'CHICAGO');

-- 24. ��� ���̺��� �μ����� ������ ��� ���޺��� ���� ����� �����ȣ,�̸�,�޿��� ����ϴ� SELECT���� �ۼ��Ͻÿ�.
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > ALL (SELECT AVG(SAL) FROM EMP GROUP BY DEPTNO);

-- 25. ��� ���̺��� �������� ������ ��� ���޺��� ���� ����� �μ���ȣ,�̸�,�޿��� ����ϴ� SELECT���� �ۼ��Ͻÿ�.
SELECT AVG(SAL) FROM EMP GROUP BY JOB;
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL < ALL (SELECT AVG(SAL) FROM EMP GROUP BY JOB);

-- 26 ��� ���̺��� ��� �Ѹ� �̻����κ��� ���� ���� �� �ִ� ����� 
-- ����,�̸�,�����ȣ,�μ���ȣ�� ���(��, �μ���ȣ ������ �������� ����)
SELECT JOB, ENAME, EMPNO, DEPTNO
FROM EMP MANAGER
WHERE EXISTS(SELECT EMPNO FROM EMP WHERE MANAGER.EMPNO=MGR);

-- 27. ��� ���̺��� ���� ����� �����ȣ,�̸�,����,�μ���ȣ�� ����ϴ� SELECT���� �ۼ��Ͻÿ�.
SELECT JOB, ENAME, EMPNO, DEPTNO
FROM EMP MANAGER
WHERE NOT EXISTS(SELECT EMPNO FROM EMP WHERE MANAGER.EMPNO=MGR);




