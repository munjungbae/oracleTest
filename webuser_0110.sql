CREATE TABLE jdbcBoard( 
    board_no NUMBER,
    title VARCHAR2(100) NOT NULL,
    content VARCHAR2(1000) NULL,
    writer VARCHAR2(50) NOT NULL,
    reg_date DATE DEFAULT SYSDATE,
    PRIMARY KEY (board_no)
);
create sequence jdbcBoard_seq
start with 1
increment by 1;

INSERT INTO JDBCBOARD(BOARD_NO, TITLE, CONTENT, WRITER) VALUES(JDBCBOARD_SEQ.NEXTVAL, ?, ?, ?);
SELECT board_no, title, content, writer, reg_date FROM jdbcBoard WHERE board_no > 0 ORDER BY board_no desc, reg_date DESC;
SELECT board_no, title, content, writer, reg_date FROM jdbcBoard WHERE board_no = 8;

CREATE TABLE jpaboard(
    board_no NUMBER,
    title VARCHAR2(100) NOT NULL,
    content VARCHAR2(1000) NULL,
    writer VARCHAR2(50) NOT NULL,
    reg_date DATE DEFAULT SYSDATE,
    PRIMARY KEY (board_no)
);

create sequence jpaboard_seq
start with 1
increment by 1;
commit;


CREATE TABLE mybatisboard
(
    board_no NUMBER,
    title VARCHAR2(100) NOT NULL,   
    content VARCHAR2(500) NULL,
    writer VARCHAR2(50) NOT NULL,
    reg_date DATE DEFAULT SYSDATE,  
    PRIMARY KEY (board_no)
);
create sequence mybatisboard_seq
start with 1
increment by 1;

CREATE TABLE mybatismember(
    user_no NUMBER,
    user_id VARCHAR2(50) NOT NULL,
    user_pw VARCHAR2(50) NOT NULL,
    user_name VARCHAR2(100) NOT NULL,
    coin NUMBER(10) DEFAULT 0,
    reg_date DATE DEFAULT SYSDATE,
    upd_date DATE DEFAULT SYSDATE,
    enabled CHAR(1) DEFAULT '1',
    PRIMARY KEY (user_no)
);
CREATE TABLE mybatismember_auth(
    user_no NUMBER NOT NULL, 
    auth VARCHAR2(50) NOT NULL
);
ALTER TABLE mybatismember_auth ADD CONSTRAINT fk_mybatismember_auth_user_no
FOREIGN KEY(user_no) REFERENCES mybatismember(user_no);

create sequence mybatismember_seq
start with 1
increment by 1;
