CREATE TABLE jdbcboard (
    board_no NUMBER,
    title    VARCHAR2(100) NOT NULL,
    content  VARCHAR2(1000) NULL,
    writer   VARCHAR2(50) NOT NULL,
    reg_date DATE DEFAULT sysdate,
    PRIMARY KEY ( board_no )
);

CREATE SEQUENCE jdbcboard_seq START WITH 1 INCREMENT BY 1;

INSERT INTO jdbcboard (
    board_no,
    title,
    content,
    writer
) VALUES ( jdbcboard_seq.NEXTVAL,
           ?,
           ?,
           ? );

SELECT
    board_no,
    title,
    content,
    writer,
    reg_date
FROM
    jdbcboard
WHERE
    board_no > 0
ORDER BY
    board_no DESC,
    reg_date DESC;

SELECT
    board_no,
    title,
    content,
    writer,
    reg_date
FROM
    jdbcboard
WHERE
    board_no = 8;

CREATE TABLE jpaboard (
    board_no NUMBER,
    title    VARCHAR2(100) NOT NULL,
    content  VARCHAR2(1000) NULL,
    writer   VARCHAR2(50) NOT NULL,
    reg_date DATE DEFAULT sysdate,
    PRIMARY KEY ( board_no )
);

CREATE SEQUENCE jpaboard_seq START WITH 1 INCREMENT BY 1;

COMMIT;

CREATE TABLE mybatisboard (
    board_no NUMBER,
    title    VARCHAR2(100) NOT NULL,
    content  VARCHAR2(500) NULL,
    writer   VARCHAR2(50) NOT NULL,
    reg_date DATE DEFAULT sysdate,
    PRIMARY KEY ( board_no )
);

CREATE SEQUENCE mybatisboard_seq START WITH 1 INCREMENT BY 1;

CREATE TABLE mybatismember (
    user_no   NUMBER,
    user_id   VARCHAR2(50) NOT NULL,
    user_pw   VARCHAR2(50) NOT NULL,
    user_name VARCHAR2(100) NOT NULL,
    coin      NUMBER(10) DEFAULT 0,
    reg_date  DATE DEFAULT sysdate,
    upd_date  DATE DEFAULT sysdate,
    enabled   CHAR(1) DEFAULT '1',
    PRIMARY KEY ( user_no )
);

CREATE TABLE mybatismember_auth (
    user_no NUMBER NOT NULL,
    auth    VARCHAR2(50) NOT NULL
);

ALTER TABLE mybatismember_auth
    ADD CONSTRAINT fk_mybatismember_auth_user_no FOREIGN KEY ( user_no )
        REFERENCES mybatismember ( user_no );

CREATE SEQUENCE mybatismember_seq START WITH 1 INCREMENT BY 1;

SELECT
    *
FROM
    mybatismember;

CREATE TABLE customer (
    "NO"   NUMBER,
    "NAME" VARCHAR2(100) NOT NULL,
    "ID"   VARCHAR(100) NOT NULL,
    pass   VARCHAR(100) NOT NULL,
    PRIMARY KEY ( "NO" )
)

CREATE SEQUENCE customer_seq START WITH 1 INCREMENT BY 1;

CREATE TABLE item (
    item_id     NUMBER(5),
    item_name   VARCHAR2(20),
    price       NUMBER(6),
    description VARCHAR2(50),
    picture_url VARCHAR2(200),
    PRIMARY KEY ( item_id )
);

CREATE SEQUENCE item_seq START WITH 1 INCREMENT BY 1;

CREATE TABLE item2 (
    item_id      NUMBER(5),
    item_name    VARCHAR2(20),
    price        NUMBER(6),
    description  VARCHAR2(50),
    picture_url  VARCHAR2(200),
    picture_url2 VARCHAR2(200),
    PRIMARY KEY ( item_id )
);

CREATE SEQUENCE item2_seq START WITH 1 INCREMENT BY 1;

CREATE TABLE item3 (
    item_id     NUMBER(5),
    item_name   VARCHAR2(50),
    price       NUMBER(10),
    description VARCHAR2(100),
    PRIMARY KEY ( item_id )
);

CREATE TABLE item_attach (
    fullname VARCHAR2(100),
    item_id  NUMBER(5) NOT NULL,
    regdate  DATE DEFAULT sysdate,
    PRIMARY KEY ( fullname )
);

ALTER TABLE item_attach
    ADD CONSTRAINT fk_item_attch FOREIGN KEY ( item_id )
        REFERENCES item3 ( item_id );

CREATE SEQUENCE item3_seq START WITH 1 INCREMENT BY 1;

SELECT
    *
FROM
    item;
