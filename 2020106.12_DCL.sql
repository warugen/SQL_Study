
------------------------------------------------------------------------------------------
-- DCL (CREATE USER, ALTER USER, GRANT, REVOKE, DROP USER) -DBA ������ �������� ����
------------------------------------------------------------------------------------------

CREATE USER HONG IDENTIFIED BY HONG; -- ����ڻ��� �� ��й�ȣ ����
ALTER USER HONG IDENTIFIED BY TIGER; -- ��й�ȣ ����

SELECT * FROM EMPV1;

GRANT CREATE SESSION TO HONG; -- �α����� �����ϰ� ����� ����

-- ������ GRANT(���Ѻο�)���� �ʰ� ���Ѱ�ü�� ���� �ѹ��� ������ �ִ°� ����
CREATE ROLE ROLLEX1; -- ROLLEX1 ���Ѱ�ü ����

-- ROLLEX1�� �Ҽ��ִ� ���Ѻο�(�α���, ���̺����, �����)
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW TO ROLLEX1; 

GRANT ROLLEX1 TO HONG; -- HONG���� ROLLEX1������ �ο�

GRANT SELECT ON EMPV1 TO HONG; -- HONG�� SCOTT�� ������ �ִ� EMPV1 ���̺��� SELECT

SHOW USER;

GRANT ALL ON EMPV1 TO HONG; -- HONG���� SCOTT.EMPV1�� �������� �ش�

SELECT * FROM EMPV1;

SELECT * FROM EMP;

GRANT ALL ON SALGRADE TO HONG;

REVOKE ALL ON SALGRADE FROM HONG; -- SALGRADE�� ���� ������ ��Ż

GRANT SELECT ON SALGRADE TO HONG;

-- HONG�� ���� ���������Ѵ�
DROP USER HONG CASCADE; -- HONG����� ����

































