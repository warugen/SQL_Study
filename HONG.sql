SHOW USER; -- 현재 어떤 유저로 접속중인지 확인

SELECT * FROM TAB; -- HONG이 가지고있는 테이블은 X

SELECT * FROM SCOTT.EMPV1;

INSERT INTO SCOTT.EMPV1 (EMPNO, ENAME, DEPTNO) VALUES(1111,'김',30);

SELECT * FROM SCOTT.EMPV1;

COMMIT;

SELECT * FROM SCOTT.SALGRADE;

INSERT INTO SCOTT.SALGRADE VALUES(6,9999,9999);

--REVOKE한후
INSERT INTO SCOTT.SALGRADE VALUES(7,9999,9999);
