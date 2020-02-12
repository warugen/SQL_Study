------------------------------------------------------------------------------------------
-- 조회속도를 높이기 위한 인덱스
------------------------------------------------------------------------------------------

DROP TABLE EMP01;

CREATE TABLE EMP01
    AS SELECT * FROM EMP;

SELECT COUNT(*) FROM EMP01;

INSERT INTO EMP01 SELECT * FROM EMP01;

DESC EMP01;

INSERT INTO EMP01 (EMPNO, ENAME) VALUES (1111,'HONG');

INSERT INTO EMP01 SELECT * FROM EMP01;

SELECT TO_CHAR(COUNT(*) , '999,999') FROM EMP01;

SELECT * FROM USER_INDEXES; -- 만들어진 인덱스 확인하기 EMP01과 관련된 인덱스 없는것을 확인

SELECT * FROM EMP01 WHERE ENAME = 'HONG'; -- 0.007초

CREATE INDEX IDX_EMP01_ENAME ON EMP01(ENAME); -- 인덱스 생성

SELECT * FROM EMP01 WHERE ENAME = 'HONG'; -- 0.003초

DROP INDEX IDX_EMP01_ENAME; -- 인덱스 삭제

-- 인덱스를 생성한다음 데이터를 삽입하면 다시 인덱스 트리를 만들기때문에 시간이 오래걸린다.
