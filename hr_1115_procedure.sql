-- STORED PROCEDURE
--EMPLOYEES에서 사용자 이름을 패턴으로 검색 한 뒤 해당되는 사용자 정보를 보여주는 프로시저.
CREATE OR REPLACE PROCEDURE EMP_PROC
IS
    VWORD VARCHAR2(1);
    VEMP_ROWTYPE EMPLOYEES%ROWTYPE;
    CURSOR CURSOR_NAME(VNAME EMPLOYEES.FIRST_NAME%TYPE)
    IS 
    SELECT * FROM EMPLOYEES WHERE UPPER(FIRST_NAME) LIKE UPPER('%'||VNAME||'%');
BEGIN
    -- 임의의 문자를 생성
    VWORD := DBMS_RANDOM.STRING('U',1);
    
    FOR VEMP_ROWTYPE IN CURSOR_NAME(VWORD) LOOP
        DBMS_OUTPUT.PUT_LINE(VEMP_ROWTYPE.FIRST_NAME||' / '||VEMP_ROWTYPE.SALARY);
    END LOOP;
END;
/
--프로시저 출력
EXECUTE EMP_PROC;