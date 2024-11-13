--시퀀스 생성 (주석처리는 생략가능)
CREATE SEQUENCE EMP_SEQ
START WITH 1
INCREMENT BY 1
-- MINVALUE 1
MAXVALUE 100000;
-- NOCYCLE
-- CACHE 2;

--
SELECT * FROM USER_SEQUENCES;

CREATE TABLE EMP01
AS
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE 
FROM EMPLOYEES
WHERE 1=0;

SELECT * FROM EMP01;
DROP TABLE EMP01;

--시퀀스 삽입(EMP_SEQ.NEXTVAL -> 현재 시퀀스의 다음 값을 반환)
--INSERT INTO EMP01(컬럼1,컬럼2,컬럼3) VALUES (시퀀스명, 시퀀스를 삽입 할 컬럼을 제외한 나머지 컬럼값)
INSERT INTO EMP01 VALUES(EMP_SEQ.NEXTVAL, 'MJB', SYSDATE);
SELECT * FROM EMP01;

--현재 시퀀스 값 반환 (EMP_SEQ.CURRVAL)
SELECT EMP_SEQ.CURRVAL
FROM DUAL;



--예제1 1-1.DEPT02 테이블을 구조만 복사
--복사 후 기본값이 10이고 10씩 증가하는 시퀀스 생성 (최대값은 30)
CREATE TABLE DEPT02
AS
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID
FROM DEPARTMENTS
WHERE 1=0;

--예제
CREATE SEQUENCE DEPT_SEQ
START WITH 10
INCREMENT BY 10
MAXVALUE 30;
--시퀀스를 이용한 값 삽입 
INSERT INTO DEPT02 VALUES(DEPT_SEQ.NEXTVAL, '헬로과', 1);
INSERT INTO DEPT02 VALUES(DEPT_SEQ.NEXTVAL, 'GUN무과', 2);
INSERT INTO DEPT02 VALUES(DEPT_SEQ.NEXTVAL, 'WEST무과', 3);
INSERT INTO DEPT02 VALUES(DEPT_SEQ.NEXTVAL, '교육과', 4);

SELECT * FROM USER_SEQUENCES;

--시퀀스 수정하기(30이 최대이므로 최대값을 100으로 설정)
ALTER SEQUENCE DEPT_SEQ
MAXVALUE 100;

SELECT * FROM DEPT02;

--시퀀스 삭제
DROP SEQUENCE DEPT_SEQ;

--데이터 딕셔너리에서 인덱스 확인하기
SELECT * FROM USER_INDEXES WHERE TABLE_NAME = 'EMPLOYEES';

SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 100;

DROP TABLE EMP10;

CREATE TABLE EMP10
AS
SELECT * FROM EMPLOYEES WHERE 1=1;

SELECT * FROM EMP10 WHERE EMPLOYEE_ID = 100;

--인덱스 걸린거 확인하기
SELECT * FROM USER_IND_COLUMNS WHERE TABLE_NAME = 'EMP10';

--인덱스 생성하기
CREATE UNIQUE INDEX EMP10_EMPLOYEE_ID_IX
ON EMP10(EMPLOYEE_ID);

--인덱스 삭제하기
DROP INDEX EMP10_EMPLOYEE_ID_IX;