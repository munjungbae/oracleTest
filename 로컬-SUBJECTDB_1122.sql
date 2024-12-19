--학과 테이블 작성 (01-컴퓨터학과 / 02-교육학과 / 03-신문방송학과 / 04-인터넷비즈니스과 / 05-기술경영과)
create table subject(
    no number,                  --sequence, --pk
    num varchar2(2) not null,   --학과번호 01, 02, 03, 04, 05
    name varchar2(24) not null  --학과이름
);
ALTER TABLE SUBJECT ADD CONSTRAINT SUBJECT_NO_PK PRIMARY KEY(NO);
ALTER TABLE SUBJECT ADD CONSTRAINT SUBJECT_NUM_UK UNIQUE(NUM);
--SUBJECT 시퀀스 생성
CREATE SEQUENCE SUBJECT_SEQ
START WITH 1
INCREMENT BY 1;

--학생 테이블 작성
create table student(
    no number,                      --sequence --pk
    num varchar2(8) not null,       --학번(년도학과번호)
    name varchar2(12) not null,     --이름
    id varchar2(12) not null,       --ID
    passwd varchar2(12) not null,   --PASSWORD
    s_num varchar2(2),     --학과번호(SUBJECT) --FK
    birthday varchar2(8) not null,  --생년월일
    phone varchar2(15) not null,    --전화번호
    address varchar2(80) not null,  --주소
    email varchar2(40) not null,    --이메일
    sdate date default sysdate      --등록일
);
ALTER TABLE STUDENT ADD CONSTRAINT STUDENT_NO_PK PRIMARY KEY(NO);
ALTER TABLE STUDENT ADD CONSTRAINT STUDENT_NUM_UK UNIQUE(NUM);
ALTER TABLE STUDENT ADD CONSTRAINT STUDENT_ID_UK UNIQUE(ID);
ALTER TABLE STUDENT ADD CONSTRAINT STUDENT_SUBJECT_NUM_FK FOREIGN KEY(S_NUM) REFERENCES SUBJECT(num) ON DELETE SET NULL;

ALTER TABLE STUDENT MODIFY s_num CHAR(10);


--INNER JOIN
SELECT ST.NO, ST.NUM, ST.NAME, ID, PASSWD, S_NUM, SJ.NAME AS S_NAME, BIRTHDAY, PHONE, ADDRESS, EMAIL, SDATE FROM STUDENT ST INNER JOIN SUBJECT SJ ON st.s_num = sj.num;



--STUDENT 시퀀스 생성
CREATE SEQUENCE STUDENT_SEQ
START WITH 1
INCREMENT BY 1;


--LESSON 테이블 생성
create table LESSON( 
    no number,                  --pk sesqunece
    abbre varchar2(2) not null, --과목 요약
    name varchar2(50) not null  --과목 이름
);
ALTER TABLE LESSON ADD CONSTRAINT LESSON_NO_PK PRIMARY KEY(NO);
ALTER TABLE LESSON ADD CONSTRAINT LESSON_ABBRE_UK UNIQUE(ABBRE);
--LESSON 시퀀스 생성
CREATE SEQUENCE LESSON_SEQ
START WITH 1
INCREMENT BY 1;

drop table lesson;

DROP TABLE TRAINEE;
---수강 테이블 (TRAINEE) 생성
create table trainee( 
    no number,                      --pk seq
    s_num varchar2(8),     --STUDENT(FK) 학생 번호   
    abbre varchar2(2),     --LESSON(FK) 과목 요약
    section varchar2(20) not null,  --전공
    regdate date default sysdate      --수강신청 일
);
ALTER TABLE TRAINEE ADD CONSTRAINT TRAINEE_NO_PK PRIMARY KEY(NO);
ALTER TABLE TRAINEE ADD CONSTRAINT TRAINEE_STUDENT_NUM_FK FOREIGN KEY(S_NUM) REFERENCES STUDENT(num) ON DELETE SET NULL;
ALTER TABLE TRAINEE ADD CONSTRAINT TRAINEE_LESSON_ABBRE_FK FOREIGN KEY(abbre) REFERENCES LESSON(abbre) ON DELETE SET NULL;

alter table trainee drop constraint trainee_lesson_abbre_fk;

drop table trainee;

--TRAINEE 시퀀스 생성
create sequence trainee_seq 
start with 1 
increment by 1;

--동일 학과 개수.
--LPAD(COUNT(*)+1,4,'0') 는 COUNT 왼쪽 빈공간 4 개안에 '0'을 삽입
SELECT LPAD(COUNT(*)+1,4,'0') AS TOTAL_CNT FROM STUDENT WHERE S_NUM = 01;


SELECT T.NO, T.SECTION, S.NUM, S.NAME as sname, L.ABBRE, L.NAME as lname
FROM TRAINEE T 
INNER JOIN STUDENT S 
ON T.S_NUM = S.NUM
INNER JOIN LESSON L ON T.ABBRE = L.ABBRE
ORDER BY T.NO;

select LPAD(count(*)+1,4,'0') as total_count from student where s_num = 1;
--공공데이터 (전통시장 정보)
create table LANDPRICE(
    nodeno NUMBER,
    gpslati NUMBER,
    gpslong NUMBER,
    nodeid VARCHAR2(20) NOT NULL,
    nodenm VARCHAR2(50)
);
ALTER TABLE LANDPRICE ADD CONSTRAINT LANDPRICE_NODENO_PK PRIMARY KEY(NODENO);
ALTER TABLE LANDPRICE ADD CONSTRAINT LANDPRICE_NODEID_UK UNIQUE(NODEID);