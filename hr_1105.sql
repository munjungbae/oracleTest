--테이블 설계하기 (사원번호, 사원명, 급여)
-- CALSS EMP01 {
--    PUBLIC INT NUMBER;
--    PUBLIC STRING NAME;
--    PUBLIC INT SALARY;
-- }
CREATE TABLE EMP01(
--    EMPNO NUMBER(4) NOT NULL PRIMARY KEY,
--    ENAME VARCHAR2(20) NOT NULL UNIQUE,
--    SAL NUMBER(10, 2) NOT NULL
    EMPNO NUMBER(4),
    ENAME VARCHAR2(20) NOT NULL,
    SAL NUMBER(10, 2) DEFAULT 1000.0,
    CONSTRAINT EMP01_EMPNO_PK PRIMARY KEY(EMPNO), --기본키 지정
    CONSTRAINT EMP01_ENAME_UK UNIQUE(ENAME)
    )
    
INSERT INTO EMP01 VALUES(1001,'MUNJUNGBAE',2700.00);
    
SELECT ENAME FROM EMP01;
    
DELETE FROM EMP01 WHERE ENAME = 'MUNJUNGBAE'; 

SELECT * FROM EMPLOYEES;

SELECT * FROM EMPLOYEES
WHERE SALARY <= 10000 AND SALARY >= 5000;

SELECT * FROM EMPLOYEES
WHERE EMPLOYEE_ID IN(134, 201, 107);

SELECT EMPLOYEE_ID AS 직원번호, FIRST_NAME AS 이름, LAST_NAME AS 성, SALARY AS 급여
FROM EMPLOYEES
WHERE SALARY BETWEEN 2500 AND 4500;

SELECT HIRE_DATE FROM EMPLOYEES
WHERE HIRE_DATE = '03/01/01';

SELECT * FROM EMPLOYEES
WHERE FIRST_NAME = '%K';