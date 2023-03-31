create database if not exists studentsdb;
use studentsdb;

create table if not exists students(
	id INT primary key not null auto_increment,
    surname VARCHAR(45),
	first_name VARCHAR(45),
	mid_name VARCHAR(45),
	phone VARCHAR(45),
	email VARCHAR(45),
	telegram VARCHAR(45),
	git VARCHAR(45)
);