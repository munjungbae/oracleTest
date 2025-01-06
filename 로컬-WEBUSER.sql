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

alter table MEMBER add constraint MEMBER_ID_PK primary key(ID



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

UPDATE USERS SET ID = 'ster12390', PASS = '1234', NAME = '문정배' WHERE ID = 'ster123900';
SELECT * FROM USERS ORDER BY NO;

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

------------------학생 관리 프로그램
CREATE table STUDENT(
 ID VARCHAR2(12) NOT NULL,
 PASS VARCHAR2(12) NOT NULL,
 NAME VARCHAR2(10) NOT NULL,
 PHONE1 VARCHAR2(3) NOT NULL,
 PHONE2 VARCHAR2(4) NOT NULL,
 PHONE3 VARCHAR2(4) NOT NULL,
 EMAIL VARCHAR2(30) NOT NULL,
 ZIPCODE VARCHAR2(7) NOT NULL,
 ADDRESS1 VARCHAR2(120) NOT NULL,
 ADDRESS2 VARCHAR2(50) NOT NULL
);
ALTER TABLE STUDENT ADD CONSTRAINT STUDENT_PK PRIMARY KEY(ID);
ALTER TABLE STUDENT ADD CONSTRAINT STUDENT_PK unique KEY(zipcode);
select * from student;
select * from board;

create table zipcode (
 seq NUMBER(10) not null,
 zipcode VARCHAR2(50),
 sido VARCHAR2(50),
 gugun VARCHAR2(50),
 dong VARCHAR2(50),
 bunji VARCHAR2(50)
);
ALTER TABLE zipcode ADD CONSTRAINT PK_ZIPCODE PRIMARY KEY(seq);
ALTER TABLE zipcode ADD CONSTRAINT ZIPCODE_FK foreign KEY(zipcode) references Student (zipcode);
SELECT * FROM ZIPCODE;
alter table zipcode modify bunji varchar2(100);

-----------------답변형 게시판
CREATE TABLE BOARD (
"NUM" NUMBER(7,0),
WRITER VARCHAR2(12) NOT NULL ENABLE,
EMAIL VARCHAR2(30) NOT NULL ENABLE,
SUBJECT VARCHAR2(50) NOT NULL ENABLE,
PASS VARCHAR2(10) NOT NULL ENABLE,
READCOUNT NUMBER(5,0) DEFAULT 0,
"REF" NUMBER(5,0) DEFAULT 0,
STEP NUMBER(3,0) DEFAULT 0,
"DEPTH" NUMBER(3,0) DEFAULT 0,
REGDATE TIMESTAMP (6) DEFAULT SYSDATE,
"CONTENT" VARCHAR2(4000) NOT NULL ENABLE,
IP VARCHAR2(20) NOT NULL ENABLE
 );
ALTER TABLE BOARD ADD CONSTRAINT BOARD_PK PRIMARY KEY (NUM) ENABLE;
select * from board;
CREATE SEQUENCE board_seq -- 시퀀스이름
 START WITH 1 -- 시작을 1로 설정
 INCREMENT BY 1 -- 증가값을 1씩 증가
 NOMAXVALUE -- 최대값이 무한대..
 NOCACHE
 NOCYCLE;

select * from board;
select max(num) as NUM from board;
select * from student;
delete from student;
commit;
DELETE FROM STUDENT WHERE ID = 'asdf' and PASS = 'asdf';
rollback;
select count(*) as count from board where num = 29 and pass = 'asdf';
---모델2로 만든 보드 
CREATE TABLE BOARD2 (
"NUM" NUMBER(7,0),
WRITER VARCHAR2(12) NOT NULL ENABLE,
EMAIL VARCHAR2(30) NOT NULL ENABLE,
SUBJECT VARCHAR2(50) NOT NULL ENABLE,
PASS VARCHAR2(10) NOT NULL ENABLE,
READCOUNT NUMBER(5,0) DEFAULT 0,
"REF" NUMBER(5,0) DEFAULT 0,
STEP NUMBER(3,0) DEFAULT 0,
"DEPTH" NUMBER(3,0) DEFAULT 0,
REGDATE TIMESTAMP (6) DEFAULT SYSDATE,
"CONTENT" VARCHAR2(4000) NOT NULL ENABLE,
IP VARCHAR2(20) NOT NULL ENABLE
 );
 ALTER TABLE BOARD2 ADD CONSTRAINT BOARD2_PK PRIMARY KEY (NUM) ENABLE;
CREATE SEQUENCE board2_seq -- 시퀀스이름
 START WITH 1 -- 시작을 1로 설정
 INCREMENT BY 1 -- 증가값을 1씩 증가
 NOMAXVALUE -- 최대값이 무한대..
 NOCACHE
 NOCYCLE;
 
CREATE TABLE TICKET (
"NO" NUMBER(10),
"DATE" TIMESTAMP(6) DEFAULT SYSDATE,
TITLE VARCHAR2(50) NOT NULL,
PRICE NUMBER(10) NOT NULL
);

CREATE SEQUENCE TICKET_seq -- 시퀀스이름
 START WITH 1 -- 시작을 1로 설정
 INCREMENT BY 1 -- 증가값을 1씩 증가
 NOMAXVALUE -- 최대값이 무한대..
 NOCACHE
 NOCYCLE;

insert into ticket(NO,TITLE,PRICE) values(TICKET_SEQ.NEXTVAL,'먹이주기 체험', 19000);
insert into ticket(NO,TITLE,PRICE) values(TICKET_SEQ.NEXTVAL,'맹수 생태 설명회', 15000);
insert into ticket(NO,TITLE,PRICE) values(TICKET_SEQ.NEXTVAL,'동물원 두드림 교육', 15000);
insert into ticket(NO,TITLE,PRICE) values(TICKET_SEQ.NEXTVAL,'일일 훈련사 체험', 25000);
SELECT * FROM TICKET;

CREATE TABLE basket (
"ID" VARCHAR2(12) NOT NULL,
"NAME" VARCHAR2(10) NOT NULL,
EMAIL VARCHAR2(30) NOT NULL,
"DATE" TIMESTAMP(6) DEFAULT SYSDATE,
TITLE VARCHAR2(50) NOT NULL,
PRICE NUMBER(10) NOT NULL,
"COUNT" NUMBER (10) NOT NULL
);
select * from student;
SELECT * FROM BASKET;
alter table basket add constraint basket_id_fk  foreign key(id) references student (id);
alter table basket MODIFY COUNT NUMBER(10) NOT NULL; 

SELECT * FROM BASKET WHERE ID = 'asdf'ORDER BY "DATE" DESC;
delete from basket;
rollback;
commit;