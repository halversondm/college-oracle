-- script to create NORTHWOODS database
-- revised 4/7/99 JM

DROP TABLE enrollment;
DROP TABLE course_section;
DROP TABLE term;
DROP TABLE course;
DROP TABLE student;
DROP TABLE faculty;
DROP TABLE location;

CREATE TABLE LOCATION
(locid NUMBER(5) CONSTRAINT location_locid_pk PRIMARY KEY,
bldg_code VARCHAR2(10) CONSTRAINT location_bldg_code_nn NOT NULL,
room VARCHAR2(6) CONSTRAINT location_room_nn NOT NULL,
capacity NUMBER(5));

CREATE TABLE faculty
(fid NUMBER(5) CONSTRAINT faculty_fid_pk PRIMARY KEY,
flname VARCHAR2(30) CONSTRAINT faculty_flname_nn NOT NULL,
ffname VARCHAR2(30) CONSTRAINT faculty_ffname_nn NOT NULL,
fmi CHAR(1),
locid NUMBER(5) CONSTRAINT faculty_locid_fk REFERENCES location(locid),
fphone VARCHAR2(10),
frank VARCHAR2(8) CONSTRAINT faculty_frank_cc
CHECK ((frank = 'ASSO') OR (frank = 'FULL')
OR (frank = 'ASST') OR (frank = 'INST')),
fpin NUMBER(4));

CREATE TABLE student
(sid NUMBER(5) CONSTRAINT student_sid_pk PRIMARY KEY,
slname VARCHAR2(30) CONSTRAINT student_slname_nn NOT NULL,
sfname VARCHAR2(30) CONSTRAINT student_sfname_nn NOT NULL,
smi CHAR(1),
sadd VARCHAR2(25),
scity VARCHAR2(20),
sstate CHAR(2) DEFAULT 'WI',
szip VARCHAR2(9),
sphone VARCHAR2(10),
sclass CHAR(2) CONSTRAINT student_sclass_cc
       CHECK ((sclass = 'FR') OR (sclass = 'SO') 
       OR (sclass = 'JR') OR (sclass = 'SR')),
sdob DATE,
spin NUMBER(4),
fid NUMBER(4) CONSTRAINT student_fid_fk 
       REFERENCES faculty(fid));

ALTER TABLE student 
  MODIFY (spin NUMBER(4) CONSTRAINT student_spin_nn NOT NULL);

ALTER TABLE student 
  ADD CONSTRAINT student_spin_uk UNIQUE (spin);
			 
ALTER TABLE student 
  DROP CONSTRAINT student_sclass_cc; 

ALTER TABLE student
  ADD CONSTRAINT student_sclass_cc
    CHECK ((sclass = 'FR') OR (sclass = 'SO') 
    OR (sclass = 'JR') OR (sclass = 'SR')
    OR (sclass = 'GR'));

ALTER TABLE student
  MODIFY (sclass CHAR(2) DEFAULT 'FR')


CREATE TABLE TERM
(termid NUMBER(5) CONSTRAINT term_termid_pk PRIMARY KEY,
tdesc VARCHAR2(20) CONSTRAINT term_tdesc_nn NOT NULL,
status VARCHAR2(20) CONSTRAINT term_status_nn NOT NULL
    		CONSTRAINT term_status_cc CHECK ((status = 'OPEN') 
		OR (status = 'CLOSED')));

CREATE TABLE COURSE
(cid NUMBER(6) CONSTRAINT course_cid_pk PRIMARY KEY,
callid VARCHAR2(10) CONSTRAINT course_callid_nn NOT NULL,
cname VARCHAR2(25),
ccredit NUMBER(2) DEFAULT 3);

CREATE TABLE COURSE_SECTION
(csecid NUMBER(8) CONSTRAINT course_section_csecid_pk PRIMARY KEY,
cid NUMBER(6) CONSTRAINT course_section_cid_fk REFERENCES course(cid) 
	CONSTRAINT course_section_cid_nn NOT NULL,
termid NUMBER(5) CONSTRAINT course_section_termid_fk 
	REFERENCES term(termid) CONSTRAINT course_section_termid_nn NOT NULL,
secnum NUMBER(2) CONSTRAINT course_section_secnum_nn NOT NULL,
fid NUMBER(5) CONSTRAINT course_section_fid_fk
	REFERENCES faculty(fid),
day VARCHAR2(10),
time DATE,
locid NUMBER(5) CONSTRAINT course_section_locid_fk REFERENCES location(locid),
maxenrl NUMBER(4) CONSTRAINT course_section_maxenrl_nn NOT NULL,
currenrl NUMBER(4) CONSTRAINT course_section_currenrl_nn NOT NULL);

CREATE TABLE ENROLLMENT
(sid NUMBER(5) CONSTRAINT enrollment_sid_fk REFERENCES student(sid),
csecid NUMBER(8),
grade CHAR(1),
PRIMARY KEY (sid, csecid));

ALTER TABLE enrollment
  ADD CONSTRAINT enrollment_grade_cc
    CHECK ((grade = 'A') OR (grade = 'B') 
    OR (grade = 'C') OR (grade = 'D') OR (grade = 'F'));

ALTER TABLE enrollment
  ADD CONSTRAINT enrollment_csecid_fk FOREIGN KEY (csecid)
       REFERENCES course_section(csecid);



---- inserting/updating records 
INSERT INTO location VALUES
(53, 'BUS', '424', 1);

INSERT INTO location VALUES
(54, 'BUS', '402', 1);

INSERT INTO location VALUES
(45, 'CR', '101', 150);

INSERT INTO location VALUES
(46, 'CR', '202', 40);

INSERT INTO location VALUES
(47, 'CR', '103', 35);

INSERT INTO location VALUES
(48, 'CR', '105', 35);

INSERT INTO location VALUES
(49, 'BUS', '105', 42);

INSERT INTO location VALUES
(50, 'BUS', '404', 35);

INSERT INTO location VALUES
(51, 'BUS', '421', 35);

INSERT INTO location VALUES
(52, 'BUS', '211', 55);

INSERT INTO location VALUES
(55, 'BUS', '433', 1);

INSERT INTO location VALUES
(56, 'LIB', '217', 1);

INSERT INTO location VALUES
(57, 'LIB', '222', 1);

--- inserting records into FACULTY
INSERT INTO faculty VALUES
(1, 'Cox', 'Kim', 'J', 53, '7155551234', 'ASSO', 1181);

INSERT INTO faculty VALUES
(2, 'Blanchard', 'John', 'R', 54, '7155559087', 'FULL', 1075);

INSERT INTO faculty VALUES
(3, 'Williams', 'Jerry', 'F', 56, '7155555412', 'ASST', 8531);

INSERT INTO faculty VALUES
(4, 'Sheng', 'Laura', 'M', 55, '7155556409', 'INST', 1690);

INSERT INTO faculty VALUES
(5, 'Brown', 'Philip', 'E', 57, '7155556082', 'ASSO', 9899);

--- inserting records into STUDENT
INSERT INTO student VALUES
(100, 'Miller', 'Sarah', 'M', '144 Windridge Blvd.', 'Eau Claire', 
'WI', '54703', '7155559876', 'SR', TO_DATE('07/14/1979', 'MM/DD/YYYY'), 8891, 1);

INSERT INTO student VALUES
(101, 'Umato', 'Brian', 'D', '454 St. John''s Street', 'Eau Claire', 
'WI', '54702', '7155552345', 'SR', TO_DATE('08/19/1979', 'MM/DD/YYYY'), 1230, 1);

INSERT INTO student VALUES
(102, 'Black', 'Daniel', NULL, '8921 Circle Drive', 'Bloomer', 
'WI', '54715', '7155553907', 'JR', TO_DATE('10/10/1977', 'MM/DD/YYYY'), 1613, 1);

INSERT INTO student VALUES
(103, 'Mobley', 'Amanda', 'J', '1716 Summit St.', 'Eau Claire', 
'WI', '54703', '7155556902', 'SO', TO_DATE('09/24/1978', 'MM/DD/YYYY'), 1841, 2);

INSERT INTO student VALUES
(104, 'Sanchez', 'Ruben', 'R', '1780 Samantha Court', 'Eau Claire', 
'WI', '54701', '7155558899', 'SO', TO_DATE('11/20/1977', 'MM/DD/YYYY'), 4420, 4);

INSERT INTO student VALUES
(105, 'Connoly', 'Michael', 'S', '1818 Silver Street', 'Elk Mound', 
'WI', '54712', '7155554944', 'FR', TO_DATE('12/4/1977', 'MM/DD/YYYY'), 9188, 3);

--- inserting records into TERM
INSERT INTO term VALUES
(1, 'Fall 2000', 'CLOSED');

INSERT INTO term VALUES
(2, 'Spring 2001', 'CLOSED');

INSERT INTO term VALUES
(3, 'Summer 2001', 'CLOSED');

INSERT INTO term VALUES
(4, 'Fall 2001', 'CLOSED');

INSERT INTO term VALUES
(5, 'Spring 2002', 'CLOSED');

INSERT INTO term VALUES
(6, 'Summer 2002', 'OPEN');

--- inserting records into COURSE
INSERT INTO course VALUES
(1, 'MIS 101', 'Intro. to Info. Systems', 3);

INSERT INTO course VALUES
(2, 'MIS 301', 'Systems Analysis', 3);

INSERT INTO course VALUES
(3, 'MIS 441', 'Database Management', 3);

INSERT INTO course VALUES
(4, 'CS 155', 'Programming in C++', 3);

INSERT INTO course VALUES
(5, 'MIS 451', 'Client/Server Systems', 3);

--- inserting records into COURSE_SECTION
INSERT INTO course_section VALUES
(1000, 1, 4, 1, 2, 'MWF', TO_DATE('10:00 AM', 'HH:MI AM'), 45, 140, 135);

INSERT INTO course_section VALUES
(1001, 1, 4, 2, 3, 'TTH', TO_DATE('09:30 AM', 'HH:MI AM'), 51, 35, 35);

INSERT INTO course_section VALUES
(1002, 1, 4, 3, 3, 'MWF', TO_DATE('08:00 AM', 'HH:MI AM'), 46, 35, 32);

INSERT INTO course_section VALUES
(1003, 2, 4, 1, 4, 'TTH', TO_DATE('11:00 AM', 'HH:MI AM'), 50, 35, 35);

INSERT INTO course_section VALUES
(1004, 2, 5, 2, 4, 'TTH', TO_DATE('02:00 PM', 'HH:MI PM'), 50, 35, 35);

INSERT INTO course_section VALUES
(1005, 3, 5, 1, 1, 'MWF', TO_DATE('09:00 AM', 'HH:MI AM'), 49, 30, 25);

INSERT INTO course_section VALUES
(1006, 3, 5, 2, 1, 'MWF', TO_DATE('10:00 AM', 'HH:MI AM'), 49, 30, 28);

INSERT INTO course_section VALUES
(1007, 4, 5, 1, 5, 'TTH', TO_DATE('08:00 AM', 'HH:MI AM'), 47, 35, 20);

INSERT INTO course_section VALUES
(1008, 5, 5, 1, 2, 'MWF', TO_DATE('02:00 PM', 'HH:MI PM'), 49, 35, 32);

INSERT INTO course_section VALUES
(1009, 5, 5, 2, 2, 'MWF', TO_DATE('03:00 PM', 'HH:MI PM'), 49, 35, 35);

INSERT INTO course_section VALUES
(1010, 1, 6, 1, 1, 'M-F', TO_DATE('08:00 AM', 'HH:MI AM'), 45, 50, 35);

INSERT INTO course_section VALUES
(1011, 2, 6, 1, 2, 'M-F', TO_DATE('08:00 AM', 'HH:MI AM'), 50, 35, 35);

INSERT INTO course_section VALUES
(1012, 3, 6, 1, 3, 'M-F', TO_DATE('09:00 AM', 'HH:MI AM'), 49, 35, 29);

--- inserting records into ENROLLMENT
INSERT INTO enrollment VALUES
(100, 1000, 'A');

INSERT INTO enrollment VALUES
(100, 1003, 'A');

INSERT INTO enrollment VALUES
(100, 1005, 'B');

INSERT INTO enrollment VALUES
(100, 1008, 'B');

INSERT INTO enrollment VALUES
(101, 1000, 'C');

INSERT INTO enrollment VALUES
(101, 1004, 'B');

INSERT INTO enrollment VALUES
(101, 1005, 'A');

INSERT INTO enrollment VALUES
(101, 1008, 'B');

INSERT INTO enrollment VALUES
(102, 1000, 'C');

INSERT INTO enrollment VALUES
(102, 1011, NULL);

INSERT INTO enrollment VALUES
(102, 1012, NULL);

INSERT INTO enrollment VALUES
(103, 1010, NULL);

INSERT INTO enrollment VALUES
(103, 1011, NULL);

INSERT INTO enrollment VALUES
(104, 1000, 'B');

INSERT INTO enrollment VALUES
(104, 1004, 'C');

INSERT INTO enrollment VALUES
(104, 1008, 'C');

INSERT INTO enrollment VALUES
(104, 1012, NULL);

INSERT INTO enrollment VALUES
(104, 1010, NULL);

INSERT INTO enrollment VALUES
(105, 1010, NULL);

INSERT INTO enrollment VALUES
(105, 1011, NULL);

COMMIT;
