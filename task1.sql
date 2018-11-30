--create database 银行贷款
use [银行贷款]
--(1)	查询所有法人的法人代码、法人名称、经济性质和注册资金。
--select Eno, Ename, Enature, Ecapital from LET;
--(2)	查询“B1100”银行的的银行名称和电话。
--select Bname,Tel from BankT where Bno = 'B1100'
--(3)	查询贷款金额在2000至4000万元之间的法人代码、银行代码、贷款日期和贷款金额。
--select Eno,Bno,Ldate,Lamount from LoanT where Lamount>=2000 and Lamount<=4000
--(4)	查询2009年1月1日以后贷款且贷款期限是10年的法人代码。
--select Eno from LoanT where Ldate>'2009-1-1' and Lterm = 10;
--(5)	查询贷款期限为5年、10年或15年的贷款信息。
--select * from LoanT where Lterm=5 or Lterm=10 or Lterm=15
--(6)	查询经济性质为“私营“的所有法人的最高注册资金、最低注册资金和平均注册资金。
--select max(Ecapital) as 最高注册资金,min(Ecapital) as 最低注册资金,avg(Ecapital) as 平均注册资金 from LET where Enature = '私营'
--(7)	查询每种经济性质的法人的经济性质、最高注册资金、最低注册资金和平均注册资金。
/*select Enature,MAX(Ecapital) as 最高注册资金,min(Ecapital) as 最低注册资金,avg(Ecapital) as 平均注册资金
from  LET
group by Enature*/
--(8)	统计每个法人的法人代码和贷款总次数，要求查询结果按贷款总次数的升序排列。
--select Eno,COUNT(*) AS [COUNT(*)] FROM LoanT GROUP BY Eno ORDER BY COUNT(*) ASC
--(9)	查询贷款次数超过3次的法人的平均贷款金额和贷款次数。
/*SELECT Eno, AVG(Lamount) AS 平均贷款金额, COUNT(Eno) AS [COUNT(*)]
FROM LoanT
GROUP BY Eno
Having COUNT(*)>3*/
--(10)	 统计每种经济性质贷款的法人的总数和其平均贷款金额，列出平均贷款金额前三名的经济性质、法人总数和平均贷款金额。
--没有where语句的话，相当于把A表中的每一条记录与B表中的每一条记录组合(n*n)，select语句选择出需要的列，
--有了where，相当于，对于A表，B表组合后的每一条数据，只有满足where语句的才是有效的
/*SELECT /*top(3)*/ LET.Enature,count(LET.Enature) as 法人总数, avg(LoanT.Lamount) as 平均贷款金额
from LET,LoanT
--where LET.Eno = LoanT.Eno
group by LET.enature
--having count(*)>3*/

/*SELECT /*top(3)*/ *--LET.Enature--,count(LET.Enature) as 法人总数, avg(LoanT.Lamount) as 平均贷款金额
from LET,LoanT
where LET.Enature='私营' and LET.Eno=LoanT.Eno
--group by LET.enature
--having count(*)>3*/

/*SELECT  LET.Enature,LoanT.Lamount,LET.Ename
from LET,LoanT*/
--where LET.Eno = LoanT.Eno
--order by 平均贷款金额 desc
--(11)	 查询贷款期限为5年、10年或15年的法人名称、银行名称、贷款日期、贷款金额和贷款期限。
select  b.erep,a.bname,c.ldate,c.lamount,c.lterm
from BankT a,LET b,LoanT c
where a.Bno = c.Bno and b.Eno=c.Eno
and (c.Lterm=5 or c.Lterm=10 or c.Lterm=15)
--(12)查询经济性质为“国营”的法人在“上海”的银行贷款的信息，列出法人名称、银行名称和贷款日期。
/*select let.Erep,BankT.Bname,LoanT.Ldate
from LET,LoanT,BankT
WHERE LET.Eno=LoanT.Eno AND LoanT.Bno = BankT.Bno
AND LET.Enature ='国营' and BankT.Bname like '%上海%'*/
--(13)	 查询与“B1100”银行在同一城市（假设银行名称的第5和第6个字符为城市名称）的其他的银行的名称。
/*select a.Bname from BankT a
where substring(a.Bname,5,2)=(
select substring(b.Bname,5,2)
from BankT b where b.Bno='B1100'
)*/
--去掉重复的数据
/*select distinct * into #Tmp from BankT
drop table BankT
select * into BankT from #Tmp
drop table #Tmp*/
--(14)	 查询哪些银行没有贷过款，列出银行号和银行名称。分别用多表连接和子查询两种方式实现。
/*select BankT.Bno, BankT.Bname,LoanT.Lamount from BankT
LEFT JOIN LoanT on BankT.Bno = LoanT.Bno
--WHERE LoanT.Lamount is null*/

/*select BankT.Bno,BankT.Bname from BankT 
where BankT.Bno not in (select LoanT.Bno from LoanT)*/
--(15)	 查询贷过款的所有法人的名称，贷款银行名称，贷款日期，贷款金额，要求将查询结果放在一张新的永久表New_LoanT中，新表中的列名分别为：法人名称、银行名称、贷款日期和贷款金额。
/*select LET.Erep 法人名称,BankT.Bname 银行名称,LoanT .Ldate 贷款日期,LoanT.Lamount 贷款金额
INTO New_LoadT
from BankT,LET,LoanT
where BankT.Bno=LoanT.Bno and LoanT.Eno = LET.Eno*/
--(16)	 分别查询经济性质“国营”和“私营”的法人名称，贷款银行名称，贷款日期，贷款金额，要求将这两个查询结果合并成一个结果集，并以法人名称、银行名称、贷款日期和贷款金额作为显示列名，结果按贷款日期的升序和贷款金额的降序显示。
/*select LET.Erep 法人名称, BankT.Bname 银行名称,LoanT.Ldate 贷款日期,LoanT.Lamount 贷款金额
from LET,BankT,LoanT
where LoanT.Bno = BankT.Bno and LoanT.Eno = LET.Eno and LET.Enature='国营'
UNION
select LET.Erep 法人名称, BankT.Bname 银行名称,LoanT.Ldate 贷款日期,LoanT.Lamount 贷款金额
from LET,BankT,LoanT
where LoanT.Bno = BankT.Bno and LoanT.Eno = LET.Eno and LET.Enature='私营'
order by 贷款日期 ASC,贷款金额 DESC*/

use StuDB
--(17)	查询计算机系没有选课的学生的姓名和年龄。
/*select student.sname,student.sage
from student
left join sc on sc.sno = student.sno
where sc.cno is null */
--(18)	统计‘VB’课程的考试最高分、最低分和平均分。
/*select max(sc.grade) VB最高分,min(sc.grade) VB最低分,avg(sc.grade) VB平均分
from student
join sc on sc.sno = student.sno
join course on course.cno = sc.cno
where course.cname='VB'

select sname,cname,grade
from student
join sc on sc.sno = student.sno
join course on course.cno = sc.cno
where course.cname='VB'

select sname,cname,grade
from student,sc,course
where student.sno = sc.sno and sc.cno=course.cno and course.cname='VB'*/
--(19)	统计‘数据库’课程的选课人数。
/*select count(*) as 数据库选课人数 from sc,course,student
where sc.cno = course.cno and sc.sno = student.sno and course.cname='数据库基础'*/
--(20)	统计计算机系学生’vb’课程考试的最高分、最低分、平均分。
/*select max(sc.grade) 最高分,min(sc.grade)最低分,avg(sc.grade)平均分
from sc,student,course
where  sc.cno = course.cno 
and sc.sno = student.sno 
and course.cname='VB' 
AND student.sdept='计算机系'*/

--(21)	统计每个系学生’vb’课程考试的最高分、最低分、平均分，列出系名和三个分数。
/*select student.sdept, max(sc.grade),min(sc.grade),avg(sc.grade)
from student,sc,course
where student.sno = sc.sno and sc.cno=course.cno and course.cname='VB'
group by student.sdept*/

--(22)	查询每个学生的修课总学分，并进行如下处理：如果总学分高于10分，则显示‘好学生’；如果总学分在6到10分间，则显示‘一般学生’；如果总学分低于6分，则显示‘不好学生’。
select student.sname,
case 
when sum(course.credit)>10 then '好学生'
when sum(course.credit) between 6 and 10 then '一般学生'
else '不好学生'
end 等级
from sc
join course on sc.cno = course.cno
join student on student.sno = sc.sno
group by student.sname
--(23)	统计每个系每个学生的修课门数和平均成绩，如果修课门数大于3并且平均成绩高于90的显示‘优秀’；如果修课门数大于3并且平均成绩在80～90，则显示‘较好’；对于修课门数小于等于3的并且平均成绩高于90的显示‘较好’；如果修课门数小于等于3并且平均成绩在80～90，则显示‘一般’；其他情况显示为‘应努力’。
--列出系名、学号、原修课门数和平均成绩以及处理后的显示结果。
select sc.Sno,student.sdept, count(sc.XKLB) 修课门数,avg(sc.grade) 平均分数,
case   
when count(sc.Cno)>3 and avg(grade)>90 then '优秀'  
when count(sc.Cno)>3 and avg(grade) between 80 and 90 then '较好'  
when count(sc.Cno)<=3 and avg(grade)>90 then '较好'  
when count(sc.Cno)<=3 and avg(grade)between 80 and 90 then '一般'  
else '应努力'  
end  等级
from sc
join student on sc.sno=student.sno
join course on course.cno=sc.cno
group by sc.Sno,student.sdept
--(24)	查询计算机系学生考试成绩最低的两个成绩所对应的学生的姓名、课程名和成绩。
/*select TOP 2 student.sname,sc.grade,course.cname
from student
join sc on sc.sno=student.sno
join course on course.cno = sc.cno
where student.sdept='计算机系'
Order by sc.grade ASC*/
--(25)	列出没有选课的学生的学号、姓名和所在系。
/*SELECT student.sno,student.sname,student.sdept
from student
where student.sno=sno and sno not in (
	select sc.sno from sc
)*/

/*SELECT distinct student.sno,student.sname,student.sdept
from student
join sc on student.sno not in (select sc.sno from sc)*/

/*SELECT student.sno,student.sname,student.sdept,*
from student
right join sc on sc.sno!=student.sno*/

/*select sno,sname,sdept
from student
where student.sno  not in (select sno from sc)*/

--思考题
--create database Tech
/*use Tech
create table 教师表1(
	tid char(10) primary key,
	tname char(10) not null,
	zc char(6)
)

insert into 教师表1 values('T1','A','教授');
insert into 教师表1 values('T2','B','副教授');
insert into 教师表1 values('T3','C','教授');
*/
--use Tech
/*SELECT [tid] 教师号,tname 教师名,
case
when 教师表1.tid='T1' or 教师表1.tid='T3' then '教授'
else ' '
end 教授,
case
when 教师表1.tid='T2' /*or 教师表1.tid='T3'*/ then '副教授'
else ' '
end 副教授
from 教师表1*/

/*create table 教师表2(
	tid char(10) primary key,
	tname char(10) not null,
	zc char(6),
	salary int
)

insert into 教师表2 values('T1','A','教授','5000')
insert into 教师表2 values('T2','B','副教授','4000')
insert into 教师表2 values('T3','C','教授','5000')
*/
/*select 教师表2.tid,教师表2.tname,
CASE 
when 教师表2.salary=5000 then '5000' end 教授工资,
case
when 教师表2.salary=4000 then '4000' end 副教授工资
from 教师表2*/

