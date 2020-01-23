
------------------------------------------------------------------------------------------
-- DCL (CREATE USER, ALTER USER, GRANT, REVOKE, DROP USER) -DBA 권한이 있을때만 가능
------------------------------------------------------------------------------------------

CREATE USER HONG IDENTIFIED BY HONG; -- 사용자생성 및 비밀번호 설정
ALTER USER HONG IDENTIFIED BY TIGER; -- 비밀번호 변경

SELECT * FROM EMPV1;

GRANT CREATE SESSION TO HONG; -- 로그인이 가능하게 만드는 세션

-- 여러번 GRANT(권한부여)하지 않고 권한객체를 만들어서 한번에 권한을 주는게 목적
CREATE ROLE ROLLEX1; -- ROLLEX1 권한객체 생성

-- ROLLEX1가 할수있는 권한부여(로그인, 테이블생성, 뷰생성)
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW TO ROLLEX1; 

GRANT ROLLEX1 TO HONG; -- HONG에게 ROLLEX1권한을 부여

GRANT SELECT ON EMPV1 TO HONG; -- HONG은 SCOTT이 가지고 있는 EMPV1 테이블을 SELECT

SHOW USER;

GRANT ALL ON EMPV1 TO HONG; -- HONG에게 SCOTT.EMPV1의 모든권한을 준다

SELECT * FROM EMPV1;

SELECT * FROM EMP;

GRANT ALL ON SALGRADE TO HONG;

REVOKE ALL ON SALGRADE FROM HONG; -- SALGRADE에 대한 모든권한 박탈

GRANT SELECT ON SALGRADE TO HONG;

-- HONG을 먼저 접속해재한다
DROP USER HONG CASCADE; -- HONG사용자 삭제

































