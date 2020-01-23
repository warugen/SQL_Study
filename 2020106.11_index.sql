------------------------------------------------------------------------------------------
-- ��ȸ�ӵ��� ���̱� ���� �ε���
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

SELECT * FROM USER_INDEXES; -- ������� �ε��� Ȯ���ϱ� EMP01�� ���õ� �ε��� ���°��� Ȯ��

SELECT * FROM EMP01 WHERE ENAME = 'HONG'; -- 0.007��

CREATE INDEX IDX_EMP01_ENAME ON EMP01(ENAME); -- �ε��� ����

SELECT * FROM EMP01 WHERE ENAME = 'HONG'; -- 0.003��

DROP INDEX IDX_EMP01_ENAME; -- �ε��� ����

-- �ε����� �����Ѵ��� �����͸� �����ϸ� �ٽ� �ε��� Ʈ���� ����⶧���� �ð��� �����ɸ���.