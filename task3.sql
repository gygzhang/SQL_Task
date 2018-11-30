if not exists (select * from sys.databases where name = 'StuDB')
create database StuDB
use StuDB;
if not exists (select * from sys.tables where name='student')
create table student(
	sno char(9) primary key,
	sname nchar(10) not null,
	ssex nchar(2),
	sage tinyint,
	sdept nvarchar(20)
);

if not exists (select * from sys.tables where name='course')
create table course(
	cno char(4) primary key,
	cname nchar(40) not null,
	Semester smallint,
	credit smallint
);

if not exists (select * from sys.tables where name='sc')
create table sc(
	sno char(7),
	cno char(4),
	grade int,
	ctype char(4),
	primary key(sno,cno),
	foreign key(sno) references student(sno),
	foreign key(cno) references course(cno)
)

if not exists (select * from sys.databases where name = 'Æû³µ') 
create database Æû³µ
use Æû³µ
if not exists (select * from sys.tables where name ='CarT')
create table CarT(
	CId integer primary key,
	CName char(10) not null,
	CType varchar(60) not null,
	CPrice integer,
	Ccolor varchar(20)
)

if not exists (select * from sys.tables where name ='DepartT')
create table DepartT(
	Did integer primary key,
	DName char(20) not null,
	DLead char(10) not null,
	DAmount integer
)

if not exists (select * from sys.tables where name = 'FacT')
create table FacT(
	CID integer not null,
	Did integer not null,
	FDate smalldatetime not null,
	FAmount integer,
	FPrice integer,
	foreign key(CID) references CarT(CId),
	foreign key(Did) references DepartT(DId)
)