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

select * from visit;

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