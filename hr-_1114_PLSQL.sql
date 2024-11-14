--PL/SQL
--PL/SQL기본구성
DECLARE
    
BEGIN

EXCEPTION

END;
/

DESC EMPLOYEES;

--%TYPE 와 SELECT 문을 활용하여 값을 가져오기
DECLARE
    VEMPLOYEE_ID EMPLOYEES.EMPLOYEE_ID%TYPE;
    VFIRST_NAME EMPLOYEES.FIRST_NAME%TYPE;
BEGIN
    SELECT EMPLOYEE_ID, FIRST_NAME INTO VEMPLOYEE_ID, VFIRST_NAME
    FROM EMPLOYEES
    WHERE FIRST_NAME = 'Susan';
    
    DBMS_OUTPUT.PUT_LINE('FIRST_NAME = '||VFIRST_NAME);
    DBMS_OUTPUT.PUT_LINE('EMPLOYEE_ID = '||VEMPLOYEE_ID);
END;
/

--EMPLOYEES에 해당 된 모든 이름, 직업, 사원번호를 출력 해 주는 프로그램을 작성하시오.
DECLARE
    --배열타입
    TYPE FIRST_NAME_ARRAY_TYPE IS TABLE OF EMPLOYEES.FIRST_NAME%TYPE INDEX BY BINARY_INTEGER;
    TYPE JOB_ID_ARRAY_TYPE IS TABLE OF EMPLOYEES.JOB_ID%TYPE INDEX BY BINARY_INTEGER;
    TYPE EMPLOYEE_ID_ARRAY_TYPE IS TABLE OF EMPLOYEES.EMPLOYEE_ID%TYPE INDEX BY BINARY_INTEGER;
    
    --배열타입 변수 선언
    FIRST_NAME_ARRAY FIRST_NAME_ARRAY_TYPE;
    JOB_ID_ARRAY JOB_ID_ARRAY_TYPE;
    EMPLOYEE_ID_ARRAY EMPLOYEE_ID_ARRAY_TYPE;
    ROW_ARRAY EMPLOYEES%ROWTYPE;    
    I BINARY_INTEGER := 0;
    J BINARY_INTEGER;
BEGIN
    --향상된 FOR문을 통해 RESULT SET값을 한개씩 가져와 각 컬럼 배열에 저장한다
    FOR ROW_ARRAY IN (SELECT * FROM EMPLOYEES)LOOP
        I := I+1;
        FIRST_NAME_ARRAY(I) := ROW_ARRAY.FIRST_NAME;
        JOB_ID_ARRAY(I) := ROW_ARRAY.JOB_ID;
        EMPLOYEE_ID_ARRAY(I) := ROW_ARRAY.EMPLOYEE_ID;
    END LOOP;
    --향상된 포문을 이용하여 컬럼 배열 값에 저장 된 값을 가져와서 출력 하시오.
    FOR J IN 1..I LOOP
        DBMS_OUTPUT.PUT_LINE(FIRST_NAME_ARRAY(J) || ' / ' || JOB_ID_ARRAY(J) || ' / ' || EMPLOYEE_ID_ARRAY(J));
    END LOOP;
END;
/

--EMPLOYEES에서 'Susan' 의 이름을 갖는 사람의 사원번호, 사원명, 부서번호를 출력하라.
DECLARE
    VEMPLOYEE_ID EMPLOYEES.EMPLOYEE_ID%TYPE;
    VFIRST_NAME EMPLOYEES.FIRST_NAME%TYPE;
    VLAST_NAME EMPLOYEES.LAST_NAME%TYPE;
    VDEPARTMENT_ID EMPLOYEES.DEPARTMENT_ID%TYPE;
    
BEGIN
    SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID INTO VEMPLOYEE_ID, VFIRST_NAME, VLAST_NAME, VDEPARTMENT_ID
    FROM EMPLOYEES
    WHERE FIRST_NAME LIKE 'Susan';
    
    DBMS_OUTPUT.PUT_LINE( VEMPLOYEE_ID || ' / ' || VFIRST_NAME ||' '|| VLAST_NAME || ' / ' || VDEPARTMENT_ID );
END;
/


--레코드 타입을 활용한 EMPLOYEES 테이블에서 CEO 사원의 사원번호 ,이름 , 담당업무, 부서번호의 정보를 출력하라
DECLARE
    --레코드 타입 정의(사원번호, 이름, 담당업무, 부서번호
    TYPE EMP_RECORD_TYPE IS RECORD(
        VEMPLOYEE_ID EMPLOYEES.EMPLOYEE_ID%TYPE,
        VFIRST_NAME EMPLOYEES.FIRST_NAME%TYPE,
        VLAST_NAME EMPLOYEES.LAST_NAME%TYPE,
        VDEPARTMENT_ID EMPLOYEES.DEPARTMENT_ID%TYPE
    );
    
    EMP_RECORD EMP_RECORD_TYPE;
BEGIN
    SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID INTO EMP_RECORD
    FROM EMPLOYEES
    WHERE MANAGER_ID IS NULL;
    
    DBMS_OUTPUT.PUT_LINE('사원번호 : '||EMP_RECORD.VEMPLOYEE_ID);
    DBMS_OUTPUT.PUT_LINE('이   름 : '||EMP_RECORD.VFIRST_NAME||' '||EMP_RECORD.VLAST_NAME);
    DBMS_OUTPUT.PUT_LINE('부서번호 : '||EMP_RECORD.VDEPARTMENT_ID);
END;
/
--레코드 타입을 활용하되 ROWTYPE을 추가 사용 EMPLOYEES 테이블에서 CEO 사원의 사원번호 ,이름 , 담당업무, 부서번호의 정보를 출력하라
DECLARE
    --ROWTYPE을 사용하여 EMPLOYEES에 있는 타입을 모두 전송
    EMP_RECORD EMPLOYEES%ROWTYPE;
BEGIN
    SELECT * INTO EMP_RECORD
    FROM EMPLOYEES
    WHERE MANAGER_ID IS NULL;
    
    DBMS_OUTPUT.PUT_LINE('사원번호 : '||EMP_RECORD.EMPLOYEE_ID);
    DBMS_OUTPUT.PUT_LINE('이   름 : '||EMP_RECORD.FIRST_NAME||' '||EMP_RECORD.LAST_NAME);
    DBMS_OUTPUT.PUT_LINE('부서번호 : '||EMP_RECORD.DEPARTMENT_ID);
END;
/

--IF문을 사용하여 CEO의 연봉계산 및 사원정보 출력
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, SALARY*12+(NVL(COMMISSION_PCT,0)*SALARY) AS "연봉"
FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;

DECLARE
    EMP_RECORD EMPLOYEES%ROWTYPE;
    TOTAL_SALARY NUMBER(10,2);
BEGIN
    SELECT * INTO EMP_RECORD
    FROM EMPLOYEES WHERE MANAGER_ID IS NULL;
    
    IF(EMP_RECORD.COMMISSION_PCT IS NULL)THEN
        EMP_RECORD.COMMISSION_PCT := 0;
    END IF;
    
    TOTAL_SALARY := EMP_RECORD.SALARY * 12 + (EMP_RECORD.SALARY * EMP_RECORD.COMMISSION_PCT);
    DBMS_OUTPUT.PUT_LINE('사원번호 : '||EMP_RECORD.EMPLOYEE_ID);
    DBMS_OUTPUT.PUT_LINE('이   름 : '||EMP_RECORD.FIRST_NAME||' '||EMP_RECORD.LAST_NAME);
    DBMS_OUTPUT.PUT_LINE('전체연봉 : '||TOTAL_SALARY);
END;
/

--IF ELSE END문을 사용하여 CEO의 연봉계산 및 사원정보 출력
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, SALARY*12+(NVL(COMMISSION_PCT,0)*SALARY) AS "연봉"
FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;

DECLARE
    EMP_RECORD EMPLOYEES%ROWTYPE;
    TOTAL_SALARY NUMBER(10,2);
BEGIN
    SELECT * INTO EMP_RECORD
    FROM EMPLOYEES WHERE MANAGER_ID IS NULL;
    
    IF(EMP_RECORD.COMMISSION_PCT IS NULL)THEN
        TOTAL_SALARY := EMP_RECORD.SALARY * 12;
    ELSE
        TOTAL_SALARY := EMP_RECORD.SALARY * 12 + (EMP_RECORD.SALARY * EMP_RECORD.COMMISSION_PCT);
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사원번호 : '||EMP_RECORD.EMPLOYEE_ID);
    DBMS_OUTPUT.PUT_LINE('이   름 : '||EMP_RECORD.FIRST_NAME||' '||EMP_RECORD.LAST_NAME);
    DBMS_OUTPUT.PUT_LINE('전체연봉 : '||TOTAL_SALARY);
END;
/
























DESC EMPLOYEES;


DECLARE
    TYPE FN_TYPE IS TABLE OF EMPLOYEES.FIRST_NAME%TYPE INDEX BY BINARY_INTEGER;
    TYPE JI_TYPE IS TABLE OF EMPLOYEES.JOB_ID%TYPE INDEX BY BINARY_INTEGER;
    TYPE EI_TYPE IS TABLE OF EMPLOYEES.EMPLOYEE_ID%TYPE INDEX BY BINARY_INTEGER;
    
    FN_ARRAY FN_TYPE;
    JI_ARRAY JI_TYPE;
    EI_ARRAY EI_TYPE;
    R_ARRAY EMPLOYEES%ROWTYPE;
    I BINARY_INTEGER := 0;
    J BINARY_INTEGER := 0;
BEGIN
    FOR R_ARRAY IN (SELECT * FROM EMPLOYEES) LOOP
        I := I+1;
        FN_ARRAY(I) := R_ARRAY.FIRST_NAME;
        JI_ARRAY(I) := R_ARRAY.JOB_ID;
        EI_ARRAY(I) := R_ARRAY.EMPLOYEE_ID;
    END LOOP;
    FOR J IN 1..I LOOP
        DBMS_OUTPUT.PUT_LINE(FN_ARRAY(J) || ' / ' || JI_ARRAY(J) || ' / ' || EI_ARRAY(J));
    END LOOP;
END;
/