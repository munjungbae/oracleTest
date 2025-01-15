CREATE TABLE aopboard (
    board_no NUMBER,
    title    VARCHAR2(100) NOT NULL,
    content  VARCHAR2(1000) NULL,
    writer   VARCHAR2(50) NOT NULL,
    reg_date DATE DEFAULT sysdate,
    PRIMARY KEY ( board_no )
);

CREATE SEQUENCE aopboard_seq START WITH 1 INCREMENT BY 1;