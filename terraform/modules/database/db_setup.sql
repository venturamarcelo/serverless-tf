-- See the data model in the LucidChart document at the link below for details
-- https://www.lucidchart.com/documents/edit/f58a90c7-b710-4da6-bbad-e076b047d1e6/S3kIj1.0cAoq

DROP TABLE IF EXISTS aid_amounts CASCADE;
DROP TABLE IF EXISTS student CASCADE;
DROP TABLE IF EXISTS partner CASCADE;
DROP TABLE IF EXISTS university CASCADE;
DROP TABLE IF EXISTS university_costs CASCADE;
DROP TABLE IF EXISTS chosen_schools CASCADE;
DROP TABLE IF EXISTS letter_submissions CASCADE;
DROP TABLE IF EXISTS chosen_letter CASCADE;

CREATE TABLE student (
  student_id serial,
  first_name varchar(64),
  last_name varchar(64),
  phone_number int,
  email varchar(256),
  gpa float,
  act_score int,
  sat_score int,
  zip int,
  ethnicity varchar(64),
  PRIMARY KEY (student_id)
);

CREATE TABLE partner (
  ptnr_student_id serial,
  student_id int REFERENCES student(student_id),
  ptnr_id int,
  name varchar,
  PRIMARY KEY (ptnr_student_id)
);

CREATE TABLE university (
  uni_id serial,
  name varchar(256),
  street_address varchar(256),
  city varchar(128),
  state varchar(2),
  zip int,
  college_size int,
  college_control int,
  area_type int,
  latitude numeric(12,9),
  longitude numeric(12,9),
  graduation_rate_4_year_asian float,
  graduation_rate_4_year_black float,
  graduation_rate_4_year_hispanic float,
  graduation_rate_4_year_white float,
  graduation_rate_4_year_nonwhite float,
  graduation_rate_4_year_aian float,
  graduation_rate_4_year_nhpi float,
  graduation_rate_4_year_total float,
  frequency_asian int,
  frequency_black int,
  frequency_hispanic int,
  frequency_white int,
  frequency_nonwhite int,
  frequency_aian int,
  frequency_nhpi int,
  PRIMARY KEY (uni_id)
);

CREATE TABLE university_costs (
  uni_year_id serial,
  uni_id int REFERENCES university(uni_id),
  year int,
  total_expected_cost float,
  tuition_and_fees float,
  housing_and_meals float,
  books_and_supplies float,
  transport float,
  personal_expenses float,
  PRIMARY KEY (uni_year_id)
);

CREATE TABLE chosen_schools (
  paired_id serial,
  uni_id int REFERENCES university(uni_id),
  student_id int REFERENCES student(student_id),
  housing_attribute varchar(32),
  viewable bool,
  date_added timestamp,
  PRIMARY KEY (paired_id)
);

CREATE TABLE letter_submissions (
  submission_id serial,
  paired_id int REFERENCES chosen_schools(paired_id),
  ingest_time timestamp,
  PRIMARY KEY (submission_id)
);

CREATE TABLE aid_amounts (
  aid_entry_id serial,
  submission_id int REFERENCES letter_submissions(submission_id),
  entry_method varchar(32),
  raw_description varchar(256),
  description_conf float,
  value float,
  value_conf float,
  term varchar(8),
  term_conf float,
  category_source varchar(32),
  category varchar(32),
  category_conf float,
  sub_category varchar(32),
  sub_category_conf float,
  PRIMARY KEY (aid_entry_id)
);

CREATE TABLE entry_method (
  method_id serial,
  description varchar(64),
  PRIMARY KEY (method_id)
);

CREATE TABLE chosen_letter (
  submission_id int REFERENCES letter_submissions(submission_id),
  method_id int REFERENCES entry_method(method_id),
  num_entries int,
  PRIMARY KEY (submission_id)
);