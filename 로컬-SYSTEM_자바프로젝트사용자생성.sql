CREATE TABLESPACE FIRSTDATA
DATAFILE 'C:\oraclexe\oradata\XE\first01.dbf' size 10M;
--용량 부족 시 테이블 스페이스 확장하기
ALTER TABLESPACE FIRSTDATA
ADD DATAFILE 'C:\oraclexe\oradata\XE\first02.dbf' size 10M;
--용량 부족 시 테이블 스페이스 용량을 확장하기
ALTER DATABASE 
DATAFILE 'C:\oraclexe\oradata\XE\first02.dbf' resize 20M;
--용량 부족 시 자동으로 1M 확장하고 최대 20M 확장하도록 변경
ALTER DATABASE
DATAFILE 'C:\oraclexe\oradata\XE\first01.dbf'
AUTOEXTEND ON
NEXT 1M
MAXSIZE 20M;
--자바 프로젝트를 위한 사용자 계정 및 테이블 스페이스(JAVADATA), 파일명(APP_DATA.DBF) 생성;
CREATE TABLESPACE javadata
DATAFILE 'C:\oraclexe\oradata\XE\app_data.dbf' size 20M
AUTOEXTEND ON
NEXT 3M
MAXSIZE 500M;

--6.자바 프로젝트 사용자 계정 생성하기
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
DROP USER javauser CASCADE;
CREATE USER javauser IDENTIFIED BY 123456
    DEFAULT TABLESPACE javadata
    TEMPORARY TABLESPACE TEMP;
GRANT connect, resource, dba to javauser;

--7. 접속기능 설정
