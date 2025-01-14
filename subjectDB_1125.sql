CREATE TABLE STUDENT2(
	NO NUMBER(4), --PK
	NAME VARCHAR2(30) NOT NULL,
	YEAR VARCHAR2(30) NOT NULL,
	GRADE NUMBER(5,2) NOT NULL,
	BIRTH VARCHAR2(30) NOT NULL,
	PHONE VARCHAR2(40) NOT NULL,
	MNUM VARCHAR2(10) --FK
);
ALTER TABLE STUDENT2 ADD CONSTRAINT SD_NO_PK PRIMARY KEY(NO);
ALTER TABLE STUDENT2 ADD CONSTRAINT SD_MJ_NUM_FK FOREIGN KEY(MNUM) REFERENCES MAJOR(MNUM) ON DELETE SET NULL;


ALTER TABLE STUDENT2 MODIFY GRADE NUMBER(5,2);

COMMIT;

INSERT INTO STUDENT2 VALUES(STUDENT2_SEQ.NEXTVAL, '문정배', '1학년', 100, '981002', '010-6638-9944', '01');

DROP TABLE STUDENT2;

CREATE SEQUENCE STUDENT2_SEQ
START WITH 1
INCREMENT BY 1;

SELECT NO, S.NAME, YEAR, GRADE, BIRTH, PHONE, S.MNUM, M.NAME AS MAJOR FROM STUDENT2 S INNER JOIN MAJOR M ON S.MNUM = M.MNUM order by no asc;
SELECT M.MNUM AS NUM, M.NAME AS MAJOR, NO, I.NAME, GRADE FROM IMFOMATION I INNER JOIN MAJOR M ON I.MNUM = M.MNUM ORDER BY NO ASC;
--전공
CREATE TABLE MAJOR (
	MNUM VARCHAR2(10),
	NAME VARCHAR2(20) NOT NULL
);
ALTER TABLE MAJOR ADD CONSTRAINT MAJOR_MNUM_PK PRIMARY KEY(MNUM);
ALTER TABLE MAJOR ADD CONSTRAINT MAJOR_NAME_UK UNIQUE(NAME);

INSERT INTO MAJOR VALUES('01', '정보통신학과');
INSERT INTO MAJOR VALUES('02', '건축공학과');
INSERT INTO MAJOR VALUES('03', '유아교육과');
CREATE SEQUENCE MAJOR_SEQ
START WITH 1
INCREMENT BY 1;

COMMIT;

DROP SEQUENCE MAJOR_SEQ;
DROP SEQUENCE student2_SEQ;
DROP SEQUENCE class_SEQ;
DROP TABLE MAJOR;
DROP TABLE student2;
DROP TABLE class;

CREATE TABLE CLASS (
    NO NUMBER(4),
    MNUM VARCHAR2(4),
    NAME VARCHAR2(50),
    GRADE NUMBER(4)
    );
    
ALTER TABLE CLASS ADD CONSTRAINT CLASS_NO_PK PRIMARY KEY(NO);
ALTER TABLE CLASS ADD CONSTRAINT CLASS_MJ_NUM_FK FOREIGN KEY(MNUM) REFERENCES MAJOR(MNUM) ON DELETE SET NULL;    

INSERT INTO CLASS VALUES(Class_SEQ.NEXTVAL, '01', '리눅스 이해하기', '2');
COMMIT;
SELECT M.MNUM AS NUM, M.NAME AS MAJOR, C.NO, C.NAME, C.GRADE FROM CLASS C INNER JOIN MAJOR M ON C.MNUM = M.MNUM ORDER BY NO ASC;
SELECT M.MNUM AS NUM, M.NAME AS MAJOR, C.NO, C.NAME, C.GRADE FROM CLASS C INNER JOIN MAJOR M ON C.MNUM = M.MNUM WHERE C.MNUM = 01 ORDER BY NO ASC;
SELECT M.MNUM AS NUM, M.NAME AS MAJOR, NO, C.NAME AS CLASS, GRADE FROM CLASS C INNER JOIN MAJOR M ON C.MNUM = M.MNUM ORDER BY NUM, C.NO ASC;
CREATE SEQUENCE CLASS_SEQ
START WITH 1
INCREMENT BY 1;

DROP TABLE CLASS;
DROP TABLE STUDENT2;
DROP TABLE MAJOR;
SELECT NO, S.NAME AS NAME, YEAR, GRADE, BIRTH, PHONE, S.MNUM AS MNUM, M.NAME AS MAJOR FROM STUDENT2 S INNER JOIN MAJOR M ON S.MNUM = M.MNUM WHERE S.NAME = '문정배' ORDER BY NO ASC;

SELECT COUNT(*) AS COUNT FROM CLASS WHERE NAME = '리눅스 이해하기';
SELECT NO, S.NAME, YEAR, GRADE, BIRTH, PHONE, S.MNUM, M.NAME AS MAJOR FROM STUDENT2 S INNER JOIN MAJOR M ON S.MNUM = M.MNUM WHERE S.NAME = '문정배' ORDER BY NO ASC;