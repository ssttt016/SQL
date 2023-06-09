Rem Copyright (c) 1990 by Oracle Corporation
Rem NAME
REM    UTLSAMPL.SQL
Rem  FUNCTION
Rem  NOTES
Rem  MODIFIED
Rem	gdudey	   06/28/95 -  Modified for desktop seed database
Rem	glumpkin   10/21/92 -  Renamed from SQLBLD.SQL
Rem	blinden   07/27/92 -  Added primary and foreign keys to EMP and DEPT
Rem	rlim	   04/29/91 -	      change char to varchar2
Rem	mmoore	   04/08/91 -	      use unlimited tablespace priv
Rem	pritto	   04/04/91 -	      change SYSDATE to 13-JUL-87
REM MENDELS 12/07/90 - BUG 30123;
REM ADD TO_DATE CALLS SO LANGUAGE INDEPENDENT

Rem
Rem $Header: utlsampl.sql 7020100.1 94/09/23 22:14:24 cli Generic<base> $ sqlbld.sql
Rem
SET TERMOUT OFF
SET ECHO OFF

Rem CONGDON    Invoked in RDBMS at build time.	 29-DEC-1988
Rem OATES:     Created: 16-Feb-83

/*
 * SCOTT 계정 생성 및 암호 TIGER 지정
 */
GRANT CONNECT, RESOURCE, UNLIMITED TABLESPACE TO test IDENTIFIED BY test;

ALTER USER test DEFAULT TABLESPACE USERS;
ALTER USER test TEMPORARY TABLESPACE TEMP;

--ALTER USER test ACCOUNT UNLOCK;


CONNECT test/test;


GRANT unlimited tablespace TO test;


DROP TABLE DEPT;


SELECT * FROM DEPT;

CREATE TABLE DEPT (
	DEPTNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY,
	DNAME VARCHAR2(14),
	LOC VARCHAR2(13)
);


INSERT INTO DEPT VALUES (
	10,
	'ACCOUNTING',
	'NEW YORK'
);

INSERT INTO DEPT VALUES (
	20,
	'RESEARCH',
	'DALLAS'
);


INSERT INTO DEPT VALUES (
	30,
	'SALES',
	'CHICAGO'
);

INSERT INTO DEPT VALUES (
	40,
	'OPERATIONS',
	'BOSTON'
);


SELECT * FROM DEPT;

DROP TABLE EMP;

CREATE TABLE EMP (
	EMPNO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4),
	HIREDATE DATE,
	SAL NUMBER(7, 2),
	COMM NUMBER(7, 2),
	DEPTNO NUMBER(2) CONSTRAINT FK_DEPTNO REFERENCES DEPT
);

SELECT * FROM EMP;

INSERT INTO EMP VALUES (
	7369,
	'SMITH',
	'CLERK',
	7902,
	TO_DATE('17-12-1980', 'dd-mm-yyyy'),
	800,
	NULL,
	20
);

INSERT INTO EMP VALUES (
	7499,
	'ALLEN',
	'SALESMAN',
	7698,
	TO_DATE('20-2-1981', 'dd-mm-yyyy'),
	1600,
	300,
	30
);

INSERT INTO EMP VALUES (
	7521,
	'WARD',
	'SALESMAN',
	7698,
	TO_DATE('22-2-1981', 'dd-mm-yyyy'),
	1250,
	500,
	30
);

INSERT INTO EMP VALUES (
	7566,
	'JONES',
	'MANAGER',
	7839,
	TO_DATE('2-4-1981', 'dd-mm-yyyy'),
	2975,
	NULL,
	20
);

INSERT INTO EMP VALUES (
	7654,
	'MARTIN',
	'SALESMAN',
	7698,
	TO_DATE('28-9-1981', 'dd-mm-yyyy'),
	1250,
	1400,
	30
);

INSERT INTO EMP VALUES (
	7698,
	'BLAKE',
	'MANAGER',
	7839,
	TO_DATE('1-5-1981', 'dd-mm-yyyy'),
	2850,
	NULL,
	30
);

INSERT INTO EMP VALUES (
	7782,
	'CLARK',
	'MANAGER',
	7839,
	TO_DATE('9-6-1981', 'dd-mm-yyyy'),
	2450,
	NULL,
	10
);

INSERT INTO EMP VALUES (
	7788,
	'SCOTT',
	'ANALYST',
	7566,
	TO_DATE('13-7-1987', 'dd-mm-yyyy')-85,
	3000,
	NULL,
	20
);

INSERT INTO EMP VALUES (
	7839,
	'KING',
	'PRESIDENT',
	NULL,
	TO_DATE('17-11-1981', 'dd-mm-yyyy'),
	5000,
	NULL,
	10
);

INSERT INTO EMP VALUES (
	7844,
	'TURNER',
	'SALESMAN',
	7698,
	TO_DATE('8-9-1981', 'dd-mm-yyyy'),
	1500,
	0,
	30
);

INSERT INTO EMP VALUES (
	7876,
	'ADAMS',
	'CLERK',
	7788,
	TO_DATE('13-7-1987', 'dd-mm-yyyy')-51,
	1100,
	NULL,
	20
);

INSERT INTO EMP VALUES (
	7900,
	'JAMES',
	'CLERK',
	7698,
	TO_DATE('3-12-1981', 'dd-mm-yyyy'),
	950,
	NULL,
	30
);

INSERT INTO EMP VALUES (
	7902,
	'FORD',
	'ANALYST',
	7566,
	TO_DATE('3-12-1981', 'dd-mm-yyyy'),
	3000,
	NULL,
	20
);

INSERT INTO EMP VALUES (
	7934,
	'MILLER',
	'CLERK',
	7782,
	TO_DATE('23-1-1982', 'dd-mm-yyyy'),
	1300,
	NULL,
	10
);

SELECT * FROM EMP;


DROP TABLE BONUS;

CREATE TABLE BONUS (
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	SAL NUMBER,
	COMM NUMBER
);



DROP TABLE SALGRADE;

CREATE TABLE SALGRADE (
	GRADE NUMBER,
	LOSAL NUMBER,
	HISAL NUMBER
);

INSERT INTO SALGRADE VALUES (
	1,
	700,
	1200
);

INSERT INTO SALGRADE VALUES (
	2,
	1201,
	1400
);

INSERT INTO SALGRADE VALUES (
	3,
	1401,
	2000
);

INSERT INTO SALGRADE VALUES (
	4,
	2001,
	3000
);

INSERT INTO SALGRADE VALUES (
	5,
	3001,
	9999
);

COMMIT;

SET TERMOUT ON

SET ECHO ON

-- 생성 끝

SELECT a.EMPNO,
a.JOB,
a.MGR
FROM EMP a;

SELECT *
FROM v$sqlfn_metadata v
WHERE v.name = 'NVL'
;

SELECT ename,
UPPER(ename) AS upper1,
LOWER(ename) AS lower1
FROM EMP
;



SELECT 
FROM emp
WHERE upper(ename) = UPPER('ScoTT') 
;


SELECT  empno, ename,
CONCAT(empno,ename) ,
CONCAT(empno, ' ') 
FROM emp
WHERE ename = UPPER('smith') 
;






SELECT a.EMPNO , a.ENAME , a.MGR , a.SAL, a.COMM, a.DEPTNO
FROM EMP a
ORDER BY DEPTNO DESC, ENAME ASC;



SELECT '010-1234-5678' AS mobile_phone,
REPLACE ('010-1234-5678','-','') AS REPLACE
FROM dual;

SELECT lpad('ORA_1234_XE', 20) AS lpad_20,
rpad('ORA_1234_XE', 20) AS rpad_20
FROM dual
; 


SELECT SYSDATE AS now,
sysdate -1 AS yesterd,
SYSDATE + 10 AS ten_days_from
FROM DUAL
;

SELECT ADD_MONTHS(SYSDATE, :MONTH)
FROM dual
;


SELECT SYSDATE AS now,
NEXT_DAY(SYSDATE, '월요일')  AS n_d,
LAST_DAY(SYSDATE) AS l_date
FROM dual
;

SELECT TO_CHAR(SYSDATE, 'yyyy/mm/dd hh24') 
FROM dual 
; -- 24시간 표시

SELECT TO_CHAR(SYSDATE, 'dd hh24:mi:ss') 
FROM dual 
;  --시분초까지 표시 