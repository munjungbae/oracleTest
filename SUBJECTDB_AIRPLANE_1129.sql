--항공편 테이블 제작

CREATE TABLE CUSTOMER(
NO CHAR(7),                      --PK
NAME VARCHAR2(20) NOT NULL,      --이름
BIRTH VARCHAR(20),                      --생일
REGIST DATE NOT NULL,            --등록날짜 SYSDATE 
RIGHT NUMBER(1) NOT NULL,                 --권한
ID VARCHAR2(20) NOT NULL,
PW VARCHAR2(20) NOT NULL,
COUNT NUMBER(3) DEFAULT 0           --예매 합계  
);
ALTER TABLE CUSTOMER ADD CONSTRAINT CUSTOMER_NO_PK PRIMARY KEY(NO);
ALTER TABLE CUSTOMER ADD CONSTRAINT CUSTOMER_ID_UQ UNIQUE(ID);
--ALTER TABLE CUSTOMER ADD CONSTRAINT CUSTOMER_GRADE_NO_FK FOREIGN KEY(GRADE_NO) REFERENCES GRADE(NO) ON DELETE SET NULL;


CREATE TABLE PLANE(
NO CHAR(5),                  --PK
NAME VARCHAR2(10) NOT NULL,  --기종
ROWX NUMBER(2) NOT NULL,     --좌석의 행 개수
COLY NUMBER(2) NOT NULL,     --좌석의 열 개수
SEATS NUMBER(3)              --총 좌석 개수 트리거로 생성
);
ALTER TABLE PLANE ADD CONSTRAINT PLANE_NO_PK PRIMARY KEY(NO);


CREATE TABLE SEATS( --비행기 기종별 좌석정보 
NO CHAR(6),                  --PK   
PLANE_NO CHAR(5),            --비행기 기종 NO  FK
ROWX VARCHAR2(2) NOT NULL,   --행 코드 01~99
COLY VARCHAR2(2) NOT NULL    --열 코드 A...Z 
);
ALTER TABLE SEATS ADD CONSTRAINT SEATS_NO_PK PRIMARY KEY(NO);
ALTER TABLE SEATS ADD CONSTRAINT SEATS_PLANE_NO_FK FOREIGN KEY(PLANE_NO) REFERENCES PLANE(NO) ON DELETE CASCADE;



CREATE TABLE COUNTRY(
NO CHAR(5),                      --PK
NAME VARCHAR(15) NOT NULL,       --이름
DISTANCE NUMBER(5) NOT NULL,     --거리
HOUR NUMBER(4, 2) NOT NULL          --소요시간
);
ALTER TABLE COUNTRY ADD CONSTRAINT COUNTRY_NO_PK PRIMARY KEY(NO);
ALTER TABLE COUNTRY ADD CONSTRAINT COUNTRY_NAME_UK UNIQUE(NAME);
DROP TABLE COUNTRY;

SELECT * FROM COUNTRY;

DELETE FROM COUNTRY WHERE NO = '0001';

INSERT INTO COUNTRY VALUES ('00001', '0001', 200, 4.5);
INSERT INTO COUNTRY VALUES ('00002', '0002', 200, 3);




CREATE TABLE FLIGHT(        --항공편
NO CHAR(5),                              --PK
PLANE_NO CHAR(5) NOT NULL,               --비행기 기종 NO FK
DEPARTURE_COUNTRY_NO CHAR(5) DEFAULT TO_CHAR(1,'FM00000'), --DEFALUT KOREA,   --출발 국가
ARRIVAL_COUNTRY_NO CHAR(5) NOT NULL,     --도착 국가
PRICE NUMBER(8),                         --가격
DEPARTURE_HOUR DATE NOT NULL,            --출발 시간
ARRIVAL_HOUR DATE                       --도착 시간
);
ALTER TABLE FLIGHT MODIFY ARRIVAL_HOUR DATE NULL;
ALTER TABLE FLIGHT MODIFY ARRIVAL_COUNTRY_NO VARCHAR(15);
TO_CHAR(?,'0000');

SELECT * FROM FLIGHT;
SELECT * FROM COUNTRY;

DELETE FROM FLIGHT;
DELETE FROM COUNTRY;



COMMIT;
select * from user_constraints where table_name = 'FLIGHT';
SELECT TO_CHAR(DEPARTURE_HOUR, 'MM-DD-YY HH24:MI:SS') FROM FLIGHT;

insert into flight(no,plane_no,arrival_country_no,departure_hour) values(TO_CHAR(2,'FM00000'),TO_CHAR(2,'FM00000'),TO_CHAR(2,'FM00000'),TO_DATE('24-11-24 10:26:31','YY-MM-DD HH24:MI:SS'));

UPDATE FLIGHT SET PLANE_NO = TO_CHAR(2,'0000'), ARRIVAL_COUNTRY_NO = '0002', DEPARTURE_HOUR = 1 WHERE NO = TO_CHAR(3,'0000');
UPDATE FLIGHT SET PLANE_NO = TO_CHAR(2,'FM00000'), ARRIVAL_COUNTRY_NO = TO_CHAR(1,'FM00000'), DEPARTURE_HOUR = TO_DATE('24-11-24 10:26:31','YY-MM-DD HH24:MI:SS') WHERE NO = TO_CHAR(2,'FM00000');
UPDATE FLIGHT SET PLANE_NO = TO_CHAR(2,'0000'), ARRIVAL_COUNTRY_NO = '0001', DEPARTURE_HOUR = 1 WHERE NO = TO_CHAR(3,'0000');

ALTER TABLE FLIGHT ADD CONSTRAINT FLIGHT_NO_PK PRIMARY KEY(NO);
ALTER TABLE FLIGHT ADD CONSTRAINT FLIGHT_PLANE_NO_FK FOREIGN KEY(PLANE_NO) REFERENCES PLANE(NO) ON DELETE CASCADE;
ALTER TABLE FLIGHT ADD CONSTRAINT FLIGHT_DEPARTURE_COUNTRY_NO_FK FOREIGN KEY(DEPARTURE_COUNTRY_NO) REFERENCES COUNTRY(NO) ON DELETE SET NULL;
ALTER TABLE FLIGHT ADD CONSTRAINT FLIGHT_ARRIVAL_COUNTRY_NO_FK FOREIGN KEY(ARRIVAL_COUNTRY_NO) REFERENCES COUNTRY(NO) ON DELETE SET NULL;


ALTER TABLE FLIGHT UPDATE CONSTRAINT FLIGHT_DEPARTURE_COUNTRY_NO_FK FOREIGN KEY(DEPARTURE_COUNTRY_NO) REFERENCES COUNTRY(NO) ON DELETE SET NULL;
COMMIT;
--항공편 시퀀스
CREATE SEQUENCE FLIGHT_SEQ
START WITH 1
INCREMENT BY 1;

--시간대비 가격 자동 계산 트리거
CREATE OR REPLACE  TRIGGER FLIGHT_PRICE_TIRRGER
BEFORE INSERT ON FLIGHT
FOR EACH ROW
DECLARE
    SHOUR NUMBER(4.2);
BEGIN
    SELECT HOUR INTO SHOUR FROM COUNTRY C WHERE C.NO = :NEW.ARRIVAL_COUNTRY_NO;
    :NEW.PRICE := SHOUR * 150000;
END;
/

DROP TRIGGER FLIGHT_PRICE_TIRRGER;

--시간대비 가격 자동 계산 트리거(UPDATE 용)
CREATE OR REPLACE TRIGGER FLIGHT_PRICE_TIRRGER2
BEFORE UPDATE ON FLIGHT
FOR EACH ROW
DECLARE
    SHOUR NUMBER(4.2);
BEGIN
    SELECT HOUR INTO SHOUR FROM COUNTRY C WHERE C.NO = :NEW.ARRIVAL_COUNTRY_NO;
    :NEW.PRICE := SHOUR * 150000;
END;
/

DROP TRIGGER FLIGHT_PRICE_TIRRGER2;

--시간대비 도착시간 자동 계산 트리거
CREATE OR REPLACE TRIGGER FLIGHT_ARRIVAL_TIRRGER
BEFORE INSERT ON FLIGHT
FOR EACH ROW
DECLARE
    SHOUR COUNTRY.HOUR%TYPE;
BEGIN
    SELECT HOUR INTO SHOUR FROM COUNTRY C WHERE C.NO = :NEW.ARRIVAL_COUNTRY_NO;
    :NEW.ARRIVAL_HOUR := TO_DATE(:NEW.DEPARTURE_HOUR + (INTERVAL '5' HOUR));
END;
/

--시간대비 도착시간 자동 계산 트리거(UPDATE 용) 
DROP TRIGGER FLIGHT_ARRIVAL_TIRRGER;

CREATE OR REPLACE TRIGGER FLIGHT_ARRIVAL_TIRRGER2
BEFORE UPDATE ON FLIGHT
FOR EACH ROW
DECLARE
    SHOUR NUMBER(5);
BEGIN
    SELECT HOUR INTO SHOUR FROM COUNTRY C WHERE C.NO = :NEW.ARRIVAL_COUNTRY_NO;
    :NEW.ARRIVAL_HOUR := TO_DATE(:NEW.DEPARTURE_HOUR + (INTERVAL '5' HOUR));
END;
/

DROP TRIGGER FLIGHT_ARRIVAL_TIRRGER2;

DROP TABLE BOOKING;
CREATE TABLE BOOKING(
NO CHAR(7),                --PK
GROUP_NO CHAR(6) NOT NULL,          --예매 그룹 NO
CUSTOMER_NO CHAR(7) NOT NULL,       --고객 NO FK
FLIGHT_NO CHAR(5) NOT NULL,         --항공편 NO FK
CODE CHAR(20),                      --CODE NO-CUSTOMER_NO-FLIGHT_NO 로 생성 TRIGGER
SEAT VARCHAR2(4) NOT NULL,          --좌석
SEATS_NO CHAR(6),                   --입력된 좌석에 맞춰서 좌석번호 가져오게. FK TRGGER
BOOKING_DATE DATE NOT NULL          --예매 날짜
);

SELECT * FROM BOOKING;
ALTER TABLE BOOKING ADD CONSTRAINT BOOKING_NO_PK PRIMARY KEY(NO);
ALTER TABLE BOOKING ADD CONSTRAINT BOOKING_SEATS_NO_FK FOREIGN KEY(SEATS_NO) REFERENCES SEATS(NO) ON DELETE CASCADE;
ALTER TABLE BOOKING ADD CONSTRAINT BOOKING_CUSTOMER_NO_FK FOREIGN KEY(CUSTOMER_NO) REFERENCES CUSTOMER(NO) ON DELETE CASCADE;
ALTER TABLE BOOKING ADD CONSTRAINT BOOKING_FLIGHT_NO_FK FOREIGN KEY(FLIGHT_NO) REFERENCES FLIGHT(NO) ON DELETE CASCADE;
