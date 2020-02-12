------------------------------------------------------------------------------------------
-- 트랜잭션
------------------------------------------------------------------------------------------

COMMIT;
SELECT * FROM DEPT01;
DROP TABLE DEPT01;
CREATE TABLE DEPT01 AS SELECT * FROM DEPT;

SELECT * FROM DEPT01;
DELETE FROM DEPT01 WHERE DEPTNO = 40;
COMMIT; -- 복구불가

DELETE FROM DEPT01 WHERE DEPTNO=30;
SAVEPOINT C1; -- C1시점으로 저장 

DELETE FROM DEPT01 WHERE DEPTNO=20;
SAVEPOINT C2; -- C2시점으로 저장

DELETE FROM DEPT01 WHERE DEPTNO=10;
SELECT * FROM DEPT01; -- 모든 부서 삭제

ROLLBACK TO C2;

SELECT * FROM DEPT01;
ROLLBACK TO C1;

ROLLBACK;
