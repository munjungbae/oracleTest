-- HR RESOURCE에 있는 테이블 정보
SELECT * FROM TAB;
-- EMPLOYEES 테이블 구조
DESC EMPLOYEES;
-- EMPLOYEEXS 속에 들어있는 테이블 구조
SELECT * FROM EMPLOYEES;
-- DEPARTMENTS 테이블 내 객체(레코드, 인스턴스 ...)를 확인
SELECT * FROM DEPARTMENTS;
-- DEPARTMENTS 의 구조를 보고 싶다.
DESC DEPARTMENTS;
--DEPARTMENTS_ID 와 DEPARTMENTS_NAME 을 봄
SELECT DEPARTMENT_ID AS "부서번호", DEPARTMENT_NAME AS "부서명" FROM DEPARTMENTS;
-- + ||
select '5'+5 from dual; -- +는 정수형 덧셈
select '5' || 5 from dual; -- ||는 문자열 덧셈 대신 사용
--문자열을 이용해서 필드명을 보여주기
select first_name, job_id from employees;
select first_name || '의 직급은 ' || job_id || ' 입니다' as 직급 from employees;

-- 중복되지 않게 보여주기
select job_id from employees;