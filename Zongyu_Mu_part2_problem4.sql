/*Problem 4*/
DROP TABLE ASSIGNED_TO CASCADE CONSTRAINTS;
DROP TABLE WAITS_ON CASCADE CONSTRAINTS;
DROP TABLE TRANSCRIPT CASCADE CONSTRAINTS;
DROP TABLE REGISTERING CASCADE CONSTRAINTS;
DROP TABLE PREREQ_OF CASCADE CONSTRAINTS;
DROP TABLE CAN_TEACH CASCADE CONSTRAINTS;
DROP TABLE SECTION CASCADE CONSTRAINTS;
DROP TABLE GTA CASCADE CONSTRAINTS;
DROP TABLE STUDENT CASCADE CONSTRAINTS;
DROP TABLE PROFESSOR CASCADE CONSTRAINTS;
DROP TABLE COURSE CASCADE CONSTRAINTS;

CREATE TABLE COURSE (
    dept        VARCHAR2(10),
    course_no   VARCHAR2(10),
    PRIMARY KEY (dept, course_no)
);
INSERT INTO COURSE VALUES ('CS', '542');
INSERT INTO COURSE VALUES ('CS', '546');
INSERT INTO COURSE VALUES ('CS', '5007');
INSERT INTO COURSE VALUES ('CS', '5084');

CREATE TABLE PROFESSOR (
    pssn        CHAR(9),
    pname       VARCHAR2(50),
    PRIMARY KEY (pssn)
);
INSERT INTO PROFESSOR VALUES ('111111111', 'Dr. Ben');
INSERT INTO PROFESSOR VALUES ('222222222', 'Dr. Max');

CREATE TABLE STUDENT (
    sssn        CHAR(9),
    sname       VARCHAR2(50),
    PRIMARY KEY (sssn)
);
INSERT INTO STUDENT VALUES ('333333333', 'Tuyen');
INSERT INTO STUDENT VALUES ('444444444', 'Zoey');

CREATE TABLE GTA (
    sssn        CHAR(9),
    salary      NUMBER(10,2),
    PRIMARY KEY (sssn),
    FOREIGN KEY (sssn) REFERENCES STUDENT(sssn)
);
INSERT INTO GTA VALUES ('333333333', 3000.00);
INSERT INTO GTA VALUES ('444444444', 3200.00);


CREATE TABLE SECTION (
    dept            VARCHAR2(10),
    course_no       VARCHAR2(10),
    section_no      CHAR(2),
    taught_by_pssn  CHAR(9),
    PRIMARY KEY (dept, course_no, section_no),
    FOREIGN KEY (dept, course_no)
        REFERENCES COURSE(dept, course_no),
    FOREIGN KEY (taught_by_pssn)
        REFERENCES PROFESSOR(pssn)
    ON DELETE CASCADE
);
INSERT INTO SECTION VALUES ('CS', '542', '01', '111111111');
INSERT INTO SECTION VALUES ('CS', '546', '01', '222222222');


CREATE TABLE CAN_TEACH (
    pssn        CHAR(9),
    dept        VARCHAR2(10),
    course_no   VARCHAR2(10),
    PRIMARY KEY (pssn, dept, course_no),
    FOREIGN KEY (pssn) REFERENCES PROFESSOR(pssn),
    FOREIGN KEY (dept, course_no)
        REFERENCES COURSE(dept, course_no)
);
INSERT INTO CAN_TEACH VALUES ('111111111', 'CS', '542');
INSERT INTO CAN_TEACH VALUES ('222222222', 'CS', '546');

CREATE TABLE PREREQ_OF (
    dept                VARCHAR2(10),
    course_no           VARCHAR2(10),
    prereq_dept         VARCHAR2(10),
    prereq_course_no    VARCHAR2(10),
    PRIMARY KEY (dept, course_no, prereq_dept, prereq_course_no),
    FOREIGN KEY (dept, course_no)
        REFERENCES COURSE(dept, course_no),
    FOREIGN KEY (prereq_dept, prereq_course_no)
        REFERENCES COURSE(dept, course_no)
);
INSERT INTO PREREQ_OF VALUES ('CS', '546', 'CS', '5007');
INSERT INTO PREREQ_OF VALUES ('CS', '542', 'CS', '5084');


CREATE TABLE REGISTERING (
    sssn        CHAR(9),
    dept        VARCHAR2(10),
    course_no   VARCHAR2(10),
    section_no  CHAR(2),
    PRIMARY KEY (sssn, dept, course_no, section_no),
    FOREIGN KEY (sssn) REFERENCES STUDENT(sssn),
    FOREIGN KEY (dept, course_no, section_no)
        REFERENCES SECTION(dept, course_no, section_no)
);
INSERT INTO REGISTERING VALUES ('333333333', 'CS', '542', '01');
INSERT INTO REGISTERING VALUES ('444444444', 'CS', '546', '01');


CREATE TABLE TRANSCRIPT (
    sssn        CHAR(9),
    dept        VARCHAR2(10),
    course_no   VARCHAR2(10),
    section_no  CHAR(2),
    grade       VARCHAR2(2),
    PRIMARY KEY (sssn, dept, course_no, section_no),
    FOREIGN KEY (sssn) REFERENCES STUDENT(sssn),
    FOREIGN KEY (dept, course_no, section_no)
        REFERENCES SECTION(dept, course_no, section_no)
);
INSERT INTO TRANSCRIPT VALUES ('333333333', 'CS', '542', '01', 'A');
INSERT INTO TRANSCRIPT VALUES ('444444444', 'CS', '546', '01', 'A');


CREATE TABLE WAITS_ON (
    sssn          CHAR(9),
    dept          VARCHAR2(10),
    course_no     VARCHAR2(10),
    section_no    CHAR(2),
    wait_position NUMBER(2),
    PRIMARY KEY (sssn, dept, course_no, section_no),
    FOREIGN KEY (sssn) REFERENCES STUDENT(sssn),
    FOREIGN KEY (dept, course_no, section_no)
        REFERENCES SECTION(dept, course_no, section_no)
);
INSERT INTO WAITS_ON VALUES ('333333333', 'CS', '546', '01', 1);
INSERT INTO WAITS_ON VALUES ('444444444', 'CS', '542', '01', 2);


CREATE TABLE ASSIGNED_TO (
    gta_sssn     CHAR(9),
    dept         VARCHAR2(10),
    course_no    VARCHAR2(10),
    section_no   CHAR(2),
    rating       NUMBER(3),
    PRIMARY KEY (gta_sssn, dept, course_no, section_no),
    FOREIGN KEY (gta_sssn) REFERENCES GTA(sssn),
    FOREIGN KEY (dept, course_no, section_no)
        REFERENCES SECTION(dept, course_no, section_no)
);
INSERT INTO ASSIGNED_TO VALUES ('333333333', 'CS', '542', '01', 95);
INSERT INTO ASSIGNED_TO VALUES ('444444444', 'CS', '546', '01', 96);

COMMIT;


