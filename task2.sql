--/*实验三SQL查询二
--实验学时：2
--实验类型：验证
--实验要求：必修
--一、实验目的
--通过本实验使学生掌握多表查询、子查询以及基本数据操作
--二、实验内容
--使用实验一建立的银行贷款数据库和表，完成以下查询。
--1-4是多表查询和子查询，5-11是数据操作*/
USE [银行贷款]
----(1)	查询经济性质为“国营”的法人在上海的银行贷款的信息，列出法人代码、银行代码和贷款日期，分别用多表连接和子查询两种方式实现。
----多表查询
--select LoanT.Eno,LoanT.Bno,LoanT.Ldate
--FROM LoanT,BankT,LET
--WHERE LoanT.Bno=BankT.Bno
--and LoanT.Eno = LET.Eno
--AND LET.Enature='国营'
--AND BankT.Bname LIKE '%上海%'

------子查询
--select LoanT.Eno,LoanT.Bno,LoanT.Ldate
--FROM LoanT
--WHERE Eno IN (SELECT Eno FROM LET WHERE LET.Enature='国营')
--AND Bno IN (select Bno from BankT where BankT.Bname LIKE '%上海%')

----(2)	查询在“建设银行上海分行”贷过款的法人名称，分别用多表连接和子查询两种方式实现。
----多表查询
--SELECT LET.Erep
--FROM LET,BankT,LoanT
--WHERE LET.Eno=LoanT.Eno
--AND BankT.Bno = LoanT.Bno
--AND BankT.Bname='建设银行上海分行'
------子查询
--SELECT LET.Erep
--FROM LET,LoanT
--WHERE LoanT.Bno in (SELECT Bno from BankT where BankT.Bname='建设银行上海分行')
--and LET.Eno =LoanT.Eno 

----(3)	查询在“工商银行北京A支行”贷款金额前三名（包括并列的情况）的法人的法人代码、法人名称和经济性质，分别用多表连接和子查询两种方式实现。
----多表查询
--select TOP 3 LET.Eno,LET.Erep,LET.Enature,LoanT.Lamount
--from LET,BankT,LoanT
--WHERE LET.Eno=LoanT.Eno
--AND LoanT.Bno=BankT.Bno
--AND BankT.Bname='工商银行北京A支行'
--ORDER by Lamount desc

----子查询
--select top 3 LET.Eno,LET.Erep,LET.Enature,LoanT.Lamount
--FROM LET,LoanT
--where LoanT.Bno in(select bno from BankT where BankT.Bname='工商银行北京A支行')
--and LET.Eno =LoanT.Eno
--ORDER BY LoanT.Lamount desc

----(4)	查询在“工商银行北京B支行”贷款、且贷款金额高于此银行的平均贷款金额的法人代码、贷款日期和贷款金额。
--select LET.Eno,LoanT.Ldate,LoanT.Lamount
--from BankT,LoanT,LET
--where BankT.Bno=LoanT.Bno
--and LoanT.Eno = LET.Eno
--and BankT.Bname='工商银行北京B支行'
--and LoanT.Lamount>(select AVG(LoanT.Lamount) from LoanT)
--order by LoanT.Lamount DESC

----(5)	在银行表中插入如下数据：银行代码号为：B321B，银行名称为：建设银行上海B分行，电话为空值。
--insert into BankT values('B321B','建设银行上海B分行','')

----(6)	在法人表中插入如下数据：法人代码号为：E11，法人名称为：新法人，
----注册资金为：2350万元，经济性质使用默认值。
--Insert into LET(Eno,Ename,Ecapital) values('E11','新法人','2350')

----(7)	删除银行编号为“B321B”的银行信息。
--delete from BankT where BankT.Bno ='B321B'

----(8)	删除2000年之前一次贷款金额最小的贷款记录。
--delete from LoanT WHERE
--LoanT.Lamount=(select min(Lamount) from LoanT where LoanT.Ldate<'2000-1-1')

----(9)	删除从贷款日期到当前日期天数超过10年的贷款记录。
--delete from LoanT where (select DATEDIFF(year,Ldate,GETDATE()))>10

----(10)	删除法人名称为“爱贝乐玩具有限公司”且贷款金额小于10万元的贷款记录，分别用子查询和多表连接两种方式实现。
----多表连接
--delete LoanT from LoanT join LET on LET.Ename='爱贝乐玩具有限公司' and LET.Eno=LoanT.Eno

----子查询
--delete LoanT from LoanT where LoanT.Eno=(select LET.Eno from LET where LET.Ename='爱贝乐玩具有限公司')
--select *  from LoanT,LET where LET.Ename='爱贝乐玩具有限公司' --and LET.Eno=LoanT.Eno--and LoanT.Lamount<10

----(11)	将经济性质为“私营”的法人在“工商银行上海支行”贷款的所有贷款金额加5万元，分别用子查询和多表连接两种方式实现。
--子查询
--UPDATE LoanT set Lamount=Lamount+5 
--where LoanT.Eno IN(SELECT Eno FROM LET WHERE LET.Enature='私营')
--and LoanT.Bno IN(select Bno from BankT where BankT.Bname='工商银行上海支行')

----多表连接
--update LoanT set Lamount=Lamount+5  
--from LoanT 
--join LET
--ON LET.Enature='私营' and LET.Eno =LoanT.Eno
--join BankT
--on BankT.Bname='工商银行上海支行' AND BankT.Bno=LoanT.Bno
----使用实验一建立的学生数据库和表，完成以下查询
use StuDB
----12-15是多表查询和子查询，16-20是数据操作
----(12)	查询计算机系年龄大于总平均年龄的学生的姓名和年龄。
----子查询
--SELECT student.sname,student.sage
--from student
--where student.sage>(select avg(student.sage) from student)
--and student.sdept ='计算机系'

----(13)	查询计算机系年龄大于计算机系平均年龄的学生的姓名和年龄。
--SELECT student.sname,student.sage
--from student
--where student.sage>(select avg(student.sage) from student where student.sdept='计算机系')
--and student.sdept ='计算机系'
----(14)	查询计算机系考试成绩小于总平均分的学生的学号、姓名。
----???多表查询和子查询
--select student.sno,student.sname
--from student,sc
--where 
--student.sdept='计算机系'
--and student.sno = sc.sno
--and sc.grade<(select avg(sc.grade) from sc)



----(15)	将考试成绩最低的并且不及格学生的最低修课成绩改为60。
--update sc set sc.grade=60
--from sc
--join student on sc.sno = student.sno
--and sc.grade =(select min(sc.grade) from sc)
--where sc.grade<60 

----(16)	将数据库基础考试成绩最低的且成绩为不及格学生的数据库考试成绩改为60。
--update sc set sc.grade=60
--from sc
--join student
--on sc.sno = student.sno
--where sc.grade<60
--and sc.grade=(select min(sc.grade) from sc)
----(17)	删除计算机系“计算机网络”课程的全部选课记录。
--delete from sc
--where sc.cno in(select course.cno from course where course.cname='计算机网络')
--and sc.sno in(select student.sno from student where student.sdept='计算机系')

----(18)	删除vb考试成绩最低的两个学生的vb考试记录。
--DELETE TOP (2) from sc
--where 
--sc.sno 
--in (select top 2 sno from sc 
--where sc.cno = (select cno from course where course.cname='VB')
--order by sc.grade ASC)

--delete from sc
--where 
--sc.sno 
--in (
--select top 2 sno from sc 
--where sc.cno = (select cno from course where course.cname='VB')
--order by sc.grade ASC
--)
--and sc.cno = (select cno from course where course.cname='VB')

----(19)	对数据库考试成绩进行如下修改：如果成绩低于60分，则提高10％；如果成绩在60到80之间，则增加6％；如果成绩在80到95之间则提高4％，其他情况不提高。
--update sc set sc.grade = sc.grade*1.1 where sc.grade <60
--update sc set sc.grade = sc.grade*1.06 where sc.grade between 60 and 80
--update sc set sc.grade = sc.grade*1.04 where sc.grade between 80 and 95

----(20)	对学分进行如下修改：如果是第1到第3学期开始的课程，则学分增加1分；如果是第4到第6学期开设的课程，学分增加2分，其他学期开始的课程学分增加3分。
--update course set course.credit = course.credit+1 where course.Semester between 1 and 3
--update course set course.credit = course.credit+2 where course.Semester between 4 and 6
--update course set course.credit = course.credit+3 where course.Semester>6
----以下查询必须用子查询完成：
----(21)	查询男生年龄最大的学生的姓名和所在系。
--select student.sname,student.sdept 
--from student
--where student.sage=(select max(student.sage) from student)

----(22)	查询选修了‘数据库基础’的学生的姓名、所在系。
--select distinct student.sname,student.sdept
--from student,sc
--where sc.sno = student.sno
--and sc.cno =(select course.cno from course where course.cname='数据库基础')
----(23)	选修了第6学期开始的课程的学生的学号、姓名和所在系。
--select distinct student.sno,student.sname,student.sdept
--from student,sc
--where sc.cno=(select course.cno from course where course.Semester=6)
--and student.sno = sc.sno
----(24)	查询男生所修的课程的课程名。
--select course.cname
--from course
--where 
--course.cno in(
--select sc.cno from sc 
--where sc.sno in(
--select student.sno from student 
--where student.ssex='男'
--)
--)
----(25)	查询年龄最小的学生所选的课程名。
--select course.cname
--from course
--where course.cno in(
--select sc.cno from sc 
--where sc.sno =(select student.sno from student 
--where student.sage =(select min(student.sage) from student)
--)
--)
