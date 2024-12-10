CREATE SEQUENCE visit_seq  -- 시퀀스이름
   START WITH 1             -- 시작을 1로 설정
   INCREMENT BY 1          -- 증가 값을 1씩 증가
   NOMAXVALUE             -- 최대 값이 무한대
   NOCACHE
   NOCYCLE;

CREATE table VISIT (
    NO         NUMBER(5,0) NOT NULL,
    WRITER     VARCHAR2(20) NOT NULL,
    MEMO     VARCHAR2(4000) NOT NULL,
    REGDATE   DATE NOT NULL
);
alter table visit add constraint VISIT_NO_PK_RIMARTKZE primary key(no);

drop table "VISIT";

select * from member;


commit;

CREATE TABLE MEMBER(
    NAME VARCHAR2(20),
    ID VARCHAR2(20),
    PWD VARCHAR(20),
    BIRTH VARCHAR2(40),
    EMAIL VARCHAR2(40)
);
CREATE SEQUENCE MEM_SEQ
START WITH 1
INCREMENT BY 1;
drop table member;
alter table MEMBER add constraint MEMBER_ID_PK primary key(ID);
SELECT * FROM MEMBER ORDER BY NAME, ID ASC;
commit;



----------------------------------------------------------------------table
CREATE table LOGIN (
    ID VARCHAR2(12) NOT NULL,
    PASS VARCHAR2(12) NOT NULL
);
ALTER TABLE LOGIN ADD CONSTRAINT LOGIN_ID_PK PRIMARY KEY(ID);

CREATE TABLE USERS(
    NO NUMBER,
    ID VARCHAR2(20),
    PASS VARCHAR2(20),
    NAME VARCHAR2(20)
    );
ALTER TABLE USERS ADD CONSTRAINT USERS_NO_PK PRIMARY KEY(NO);
ALTER TABLE USERS ADD CONSTRAINT USERS_ID_UK UNIQUE(ID);

alter table users modify NAME VARCHAR2(50);
commit;
SELECT * FROM USERS;

UPDATE USERS SET ID = 'ster12390', PASS = '1234', NAME = '문정배' WHERE ID = 'ster123900';
SELECT * FROM USERS ORDER BY NO;
commit; 
DELETE FROM USERS;
sELECT ID,PASS FROM USERS;
INSERT INTO USERS VALUES((SELECT NVL(max(no),0)+1 FROM USERS), 'ster12390', '1234', '문정배');
insert into users values((SELECT NVL(max(no),0)+1 FROM USERS), 'admin', '123456', 'admin');
CREATE TABLE ACCOUNT(
    NO NUMBER(5,0) NOT NULL,
    NAME VARCHAR2(20) NOT NULL,
    ID VARCHAR2(4000) NOT NULL,
    PWD VARCHAR2(4000) NOT NULL,
    REGDATE DATE NOT NULL
);

ALTER TABLE ACCOUNT ADD CONSTRAINT ACCOUNT_NO_PK PRIMARY KEY(NO);
ALTER TABLE ACCOUNT ADD CONSTRAINT ACCOUNT_ID_UK UNIQUE(ID);


-----------------------------TEMP_MEMBER TABLE 생성
CREATE TABLE TEMPMEMBER (
    ID VARCHAR2(20),
    PASSWD VARCHAR2(20),
    NAME VARCHAR2(20),
    MEM_NUM1 VARCHAR2(6),
    MEM_NUM2 VARCHAR2(7),
    E_MAIL VARCHAR2(30),
    PHONE VARCHAR2(30),
    ZIPCODE VARCHAR2(7),
    ADDRESS VARCHAR2(60),
    JOB VARCHAR2(30)
 );
 ALTER TABLE TEMPMEMBER ADD CONSTRAINT TM_ID_PK PRIMARY KEY(ID);
insert into tempMember values('aaaa', '1111', '홍길동', '123456', '7654321', 'hong@hanmail.net', '02-1234', '100-100', '서울', '프로그래머');
insert into tempMember values('bbbb', '2222', '동길홍', '654321', '1234567', 'hong@naver.com', '02-1234', '100-100', '서울', '프로그래머');
insert into tempMember values('cccc', '3333', '길홍동', '456123', '3214567', 'hong@gmail.com', '02-1234', '100-100', '서울', '프로그래머');
SELECT * FROM TEMPMEMBER;