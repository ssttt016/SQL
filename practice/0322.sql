CREATE TABLE dept_temp AS (SELECT * FROM dept);

INSERT INTO dept_temp (deptno, dname, loc)
values(50, 'DATABASE', 'SEOUL');

INSERT INTO dept_temp (deptno, dname, loc)
values(70, 'WEB', NULL);

INSERT INTO dept_temp (deptno, dname, loc)
values(80, 'MOBILE', '');

INSERT INTO dept_temp (deptno,loc)
values(90,'INCHEON');

DELETE DEPT_TEMP WHERE DEPTNO = 50 AND LOC = 'SEOUL';

SELECT * FROM DEPT_TEMP;


CREATE TABLE EMP_TEMP
AS SELECT * 
FROM EMP 
WHERE 1<>1;

SELECT * FROM EMP_TEMP;

INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(9999,'홍길동', 'PRESIDENT', NULL, '2001/01/01', 5000,1000,10);

INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(2111,'이순신', 'MANAGER', 9999, TO_DATE('07/01/1999','MM/DD/YYYY'), 4000,NULL,20);

INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(3111,'심청이', 'MANAGER', 9999, SYSDATE, 4000,NULL,30);



INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
SELECT E.EMPNO,E.ENAME,E.JOB,E.MGR ,E.HIREDATE ,E.SAL ,E.COMM ,E.DEPTNO 
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL 
AND S.GRADE = 1;

SELECT * FROM EMP_TEMP;

SELECT *
FROM EMP e WHERE rownum <3;
--UPDATE문 : 필터된 데이터에 대해서 레코드 값을 수정

CREATE TABLE DEPT_TEMP2   --테스트 개발을 위한 임시 테이블 생성
AS (SELECT * FROM DEPT)
;

SELECT * FROM DEPT_TEMP2   --테스트 개발을 위한 임시 테이블 확인
;

DROP TABLE dept_temp2;

/*
 * UPDATE .....
 * SET..... 
 * UPDATE SET 이게 셋트임
 */

UPDATE dept_temp2
SET dname='DATABASE',loc = 'SEOUL'
WHERE deptno = 40;




-- 서브쿼리를 이용하여 UPDATE 

UPDATE dept_temp2
SET (dname, loc) = (SELECT dname, loc FROM dept WHERE deptno = 40)
WHERE deptno = 40;

/*
DELTE 구문으로 테이블에서 값을 제거

보통의 경우, DELETE보다는 UPDATE 구문으로 상태 값을 변경

예시 : 근무/휴직/퇴사 등의 유형으로 값을 변경
*/

SELECT *
FROM emp_temp2;

CREATE TABLE emp_temp2 AS (SELECT * FROM emp);

SELECT * FROM emp_temp2;

DELETE FROM emp_temp2
WHERE job = 'MANAGER';

ROLLBACK;
COMMIT;

--WHERE 조건을 좀 더 복잡하게 주고 DELETE 실행

DELETE FROM emp_temp2
WHERE empno IN (
SELECT e.empno 
FROM emp_temp2 e, SALGRADE s
WHERE e.sal BETWEEN s.LOSAL AND s.HISAL
AND s.grade = 3 AND deptno = 30);

SELECT e.empno 
FROM emp_temp2 e, SALGRADE s
WHERE e.sal BETWEEN s.LOSAL AND s.HISAL
AND s.grade = 3 AND deptno = 30;



--CREATE 문을 정의 : 기존에 없는 테이블 구조를 생성
--데이터는 없고, 테이블의 컬럼과 데이터타입, 제약조건 등의 구조를 생성

CREATE TABLE emp_new
(
empno     number(4),
ename     varchar(10),
job       varchar(9),
mgr       number(4),
hiredate  DATE,
salgrade  number(7,2),
comm      number(7,2),
deptno    number(2)
);

SELECT * FROM emp_new;

SELECT * FROM emp WHERE rownum <= 5;


ALTER TABLE emp_new
ADD hp varchar(20);

ALTER TABLE EMP_NEW 
RENAME COLUMN hp TO TEL_NO; 

ALTER TABLE EMP_NEW 
MODIFY empno number(5);

ALTER TABLE EMP_NEW DROP COLUMN tel_no;

SELECT * FROM emp_new;


CREATE SEQUENCE seq_deptno
INCREMENT BY 1
START WITH 1
MAXVALUE 99
MINVALUE 1
nocycle nocache;

INSERT INTO dept_temp2 (deptno, dname, loc)
VALUES (seq_deptno.nextval, 'DATABASE', 'SEOUL');

INSERT INTO dept_temp2 (deptno, dname, loc)
VALUES (seq_deptno.nextval, 'WEB', 'BUSAN');

INSERT INTO dept_temp2 (deptno, dname, loc)
VALUES (seq_deptno.nextval, 'MOBILE', 'SEUNGSOO');

SELECT * FROM dept_temp2;



CREATE TABLE login 
(
log_id   varchar2(20) NOT NULL,
log_pwd  varchar2(20) NOT NULL,
tel      varchar2(20)
);

INSERT INTO login (log_id, log_pwd, tel)
VALUES ('test01', '1234', '010-1234-2343');

INSERT INTO login (log_id, log_pwd)
VALUES ('test01','1234');

SELECT * FROM login;

ALTER TABLE login 
MODIFY tel NOT NULL;

UPDATE login 
SET tel = '010-2345-6789'
WHERE log_id = 'test01';



SELECT * --owner, constraint_name, constraint_type, table_name
FROM USER_CONSTRAINTS 
WHERE table_name = 'LOGIN';

ALTER TABLE login 
MODIFY (tel CONSTRAINT tel_nn NOT null);

ALTER TABLE LOGIN DROP CONSTRAINT SYS_C007040;


CREATE TABLE log_unique
(
log_id    varchar2(20) UNIQUE,
log_pwd   varchar2(20) NOT NULL,
tel       varchar2(20)
);


SELECT *
FROM USER_CONSTRAINTS 
WHERE table_name = 'LOG_UNIQUE';

INSERT INTO LOG_UNIQUE (log_id, log_pwd, tel)
VALUES ('test01', 'pwd123', '010-1234-1222');

INSERT INTO LOG_UNIQUE(log_id, log_pwd, tel)
VALUES ('test02', 'pwd123', '010-1234-1222');

INSERT INTO LOG_UNIQUE(log_id, log_pwd, tel)
VALUES ('test03', 'pwd123', '010-1234-1222');

INSERT INTO LOG_UNIQUE(log_id, log_pwd, tel)
VALUES (null, 'pwd123', '010-1234-1222');


UPDATE log_unique 
SET log_id = 'test_id_new'
WHERE log_id IS NULL;

SELECT * FROM log_unique;


ALTER TABLE log_unique 
MODIFY (tel unique);

CREATE TABLE log_pk 
(
log_id   varchar2(20) PRIMARY KEY,
log_pwd  varchar2(20) NOT NULL,
tel      varchar2(20)
);


INSERT INTO log_pk (log_id, log_pwd, TEL)
VALUES ('pk01','pwd01','010-1234-1232');

INSERT INTO log_pk (log_id, log_pwd, TEL)
VALUES ('pk01','pwd02','010-3434-1232');

INSERT INTO log_pk (log_id, log_pwd, TEL)
VALUES (NULL ,'pwd01','010-1234-1232');

INSERT INTO log_pk (log_id, log_pwd, TEL)
VALUES ('pk01','pwd01','010-1234-1232');


SELECT * FROM emp_temp ;

INSERT INTO emp_temp (empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (3333,'ghost','surprise',9999,sysdate,1200,NULL,99);

INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (3333,'ghost','surprise',9999,sysdate,1200,NULL,99);


--index

CREATE INDEX idx_emp_job
ON emp(job);


SELECT *
FROM USER_INDexes
WHERE TABLE_NAME IN ('emp','dept');


CREATE VIEW vw_emp
AS (SELECT empno, ename, job, deptno
FROM EMP
WHERE deptno = 10);

SELECT * FROM vw_emp;

SELECT *
FROM user_VIEWS WHERE view_name = 'vw_emp';

FROM (SELECT * FROM EMP
ORDER BY sal DESC ) A
