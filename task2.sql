--/*ʵ����SQL��ѯ��
--ʵ��ѧʱ��2
--ʵ�����ͣ���֤
--ʵ��Ҫ�󣺱���
--һ��ʵ��Ŀ��
--ͨ����ʵ��ʹѧ�����ն���ѯ���Ӳ�ѯ�Լ��������ݲ���
--����ʵ������
--ʹ��ʵ��һ���������д������ݿ�ͱ�������²�ѯ��
--1-4�Ƕ���ѯ���Ӳ�ѯ��5-11�����ݲ���*/
USE [���д���]
----(1)	��ѯ��������Ϊ����Ӫ���ķ������Ϻ������д������Ϣ���г����˴��롢���д���ʹ������ڣ��ֱ��ö�����Ӻ��Ӳ�ѯ���ַ�ʽʵ�֡�
----����ѯ
--select LoanT.Eno,LoanT.Bno,LoanT.Ldate
--FROM LoanT,BankT,LET
--WHERE LoanT.Bno=BankT.Bno
--and LoanT.Eno = LET.Eno
--AND LET.Enature='��Ӫ'
--AND BankT.Bname LIKE '%�Ϻ�%'

------�Ӳ�ѯ
--select LoanT.Eno,LoanT.Bno,LoanT.Ldate
--FROM LoanT
--WHERE Eno IN (SELECT Eno FROM LET WHERE LET.Enature='��Ӫ')
--AND Bno IN (select Bno from BankT where BankT.Bname LIKE '%�Ϻ�%')

----(2)	��ѯ�ڡ����������Ϻ����С�������ķ������ƣ��ֱ��ö�����Ӻ��Ӳ�ѯ���ַ�ʽʵ�֡�
----����ѯ
--SELECT LET.Erep
--FROM LET,BankT,LoanT
--WHERE LET.Eno=LoanT.Eno
--AND BankT.Bno = LoanT.Bno
--AND BankT.Bname='���������Ϻ�����'
------�Ӳ�ѯ
--SELECT LET.Erep
--FROM LET,LoanT
--WHERE LoanT.Bno in (SELECT Bno from BankT where BankT.Bname='���������Ϻ�����')
--and LET.Eno =LoanT.Eno 

----(3)	��ѯ�ڡ��������б���A֧�С�������ǰ�������������е�������ķ��˵ķ��˴��롢�������ƺ;������ʣ��ֱ��ö�����Ӻ��Ӳ�ѯ���ַ�ʽʵ�֡�
----����ѯ
--select TOP 3 LET.Eno,LET.Erep,LET.Enature,LoanT.Lamount
--from LET,BankT,LoanT
--WHERE LET.Eno=LoanT.Eno
--AND LoanT.Bno=BankT.Bno
--AND BankT.Bname='�������б���A֧��'
--ORDER by Lamount desc

----�Ӳ�ѯ
--select top 3 LET.Eno,LET.Erep,LET.Enature,LoanT.Lamount
--FROM LET,LoanT
--where LoanT.Bno in(select bno from BankT where BankT.Bname='�������б���A֧��')
--and LET.Eno =LoanT.Eno
--ORDER BY LoanT.Lamount desc

----(4)	��ѯ�ڡ��������б���B֧�С�����Ҵ�������ڴ����е�ƽ��������ķ��˴��롢�������ںʹ����
--select LET.Eno,LoanT.Ldate,LoanT.Lamount
--from BankT,LoanT,LET
--where BankT.Bno=LoanT.Bno
--and LoanT.Eno = LET.Eno
--and BankT.Bname='�������б���B֧��'
--and LoanT.Lamount>(select AVG(LoanT.Lamount) from LoanT)
--order by LoanT.Lamount DESC

----(5)	�����б��в����������ݣ����д����Ϊ��B321B����������Ϊ�����������Ϻ�B���У��绰Ϊ��ֵ��
--insert into BankT values('B321B','���������Ϻ�B����','')

----(6)	�ڷ��˱��в����������ݣ����˴����Ϊ��E11����������Ϊ���·��ˣ�
----ע���ʽ�Ϊ��2350��Ԫ����������ʹ��Ĭ��ֵ��
--Insert into LET(Eno,Ename,Ecapital) values('E11','�·���','2350')

----(7)	ɾ�����б��Ϊ��B321B����������Ϣ��
--delete from BankT where BankT.Bno ='B321B'

----(8)	ɾ��2000��֮ǰһ�δ�������С�Ĵ����¼��
--delete from LoanT WHERE
--LoanT.Lamount=(select min(Lamount) from LoanT where LoanT.Ldate<'2000-1-1')

----(9)	ɾ���Ӵ������ڵ���ǰ������������10��Ĵ����¼��
--delete from LoanT where (select DATEDIFF(year,Ldate,GETDATE()))>10

----(10)	ɾ����������Ϊ��������������޹�˾���Ҵ�����С��10��Ԫ�Ĵ����¼���ֱ����Ӳ�ѯ�Ͷ���������ַ�ʽʵ�֡�
----�������
--delete LoanT from LoanT join LET on LET.Ename='������������޹�˾' and LET.Eno=LoanT.Eno

----�Ӳ�ѯ
--delete LoanT from LoanT where LoanT.Eno=(select LET.Eno from LET where LET.Ename='������������޹�˾')
--select *  from LoanT,LET where LET.Ename='������������޹�˾' --and LET.Eno=LoanT.Eno--and LoanT.Lamount<10

----(11)	����������Ϊ��˽Ӫ���ķ����ڡ����������Ϻ�֧�С���������д������5��Ԫ���ֱ����Ӳ�ѯ�Ͷ���������ַ�ʽʵ�֡�
--�Ӳ�ѯ
--UPDATE LoanT set Lamount=Lamount+5 
--where LoanT.Eno IN(SELECT Eno FROM LET WHERE LET.Enature='˽Ӫ')
--and LoanT.Bno IN(select Bno from BankT where BankT.Bname='���������Ϻ�֧��')

----�������
--update LoanT set Lamount=Lamount+5  
--from LoanT 
--join LET
--ON LET.Enature='˽Ӫ' and LET.Eno =LoanT.Eno
--join BankT
--on BankT.Bname='���������Ϻ�֧��' AND BankT.Bno=LoanT.Bno
----ʹ��ʵ��һ������ѧ�����ݿ�ͱ�������²�ѯ
use StuDB
----12-15�Ƕ���ѯ���Ӳ�ѯ��16-20�����ݲ���
----(12)	��ѯ�����ϵ���������ƽ�������ѧ�������������䡣
----�Ӳ�ѯ
--SELECT student.sname,student.sage
--from student
--where student.sage>(select avg(student.sage) from student)
--and student.sdept ='�����ϵ'

----(13)	��ѯ�����ϵ������ڼ����ϵƽ�������ѧ�������������䡣
--SELECT student.sname,student.sage
--from student
--where student.sage>(select avg(student.sage) from student where student.sdept='�����ϵ')
--and student.sdept ='�����ϵ'
----(14)	��ѯ�����ϵ���Գɼ�С����ƽ���ֵ�ѧ����ѧ�š�������
----???����ѯ���Ӳ�ѯ
--select student.sno,student.sname
--from student,sc
--where 
--student.sdept='�����ϵ'
--and student.sno = sc.sno
--and sc.grade<(select avg(sc.grade) from sc)



----(15)	�����Գɼ���͵Ĳ��Ҳ�����ѧ��������޿γɼ���Ϊ60��
--update sc set sc.grade=60
--from sc
--join student on sc.sno = student.sno
--and sc.grade =(select min(sc.grade) from sc)
--where sc.grade<60 

----(16)	�����ݿ�������Գɼ���͵��ҳɼ�Ϊ������ѧ�������ݿ⿼�Գɼ���Ϊ60��
--update sc set sc.grade=60
--from sc
--join student
--on sc.sno = student.sno
--where sc.grade<60
--and sc.grade=(select min(sc.grade) from sc)
----(17)	ɾ�������ϵ����������硱�γ̵�ȫ��ѡ�μ�¼��
--delete from sc
--where sc.cno in(select course.cno from course where course.cname='���������')
--and sc.sno in(select student.sno from student where student.sdept='�����ϵ')

----(18)	ɾ��vb���Գɼ���͵�����ѧ����vb���Լ�¼��
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

----(19)	�����ݿ⿼�Գɼ����������޸ģ�����ɼ�����60�֣������10��������ɼ���60��80֮�䣬������6��������ɼ���80��95֮�������4���������������ߡ�
--update sc set sc.grade = sc.grade*1.1 where sc.grade <60
--update sc set sc.grade = sc.grade*1.06 where sc.grade between 60 and 80
--update sc set sc.grade = sc.grade*1.04 where sc.grade between 80 and 95

----(20)	��ѧ�ֽ��������޸ģ�����ǵ�1����3ѧ�ڿ�ʼ�Ŀγ̣���ѧ������1�֣�����ǵ�4����6ѧ�ڿ���Ŀγ̣�ѧ������2�֣�����ѧ�ڿ�ʼ�Ŀγ�ѧ������3�֡�
--update course set course.credit = course.credit+1 where course.Semester between 1 and 3
--update course set course.credit = course.credit+2 where course.Semester between 4 and 6
--update course set course.credit = course.credit+3 where course.Semester>6
----���²�ѯ�������Ӳ�ѯ��ɣ�
----(21)	��ѯ������������ѧ��������������ϵ��
--select student.sname,student.sdept 
--from student
--where student.sage=(select max(student.sage) from student)

----(22)	��ѯѡ���ˡ����ݿ��������ѧ��������������ϵ��
--select distinct student.sname,student.sdept
--from student,sc
--where sc.sno = student.sno
--and sc.cno =(select course.cno from course where course.cname='���ݿ����')
----(23)	ѡ���˵�6ѧ�ڿ�ʼ�Ŀγ̵�ѧ����ѧ�š�����������ϵ��
--select distinct student.sno,student.sname,student.sdept
--from student,sc
--where sc.cno=(select course.cno from course where course.Semester=6)
--and student.sno = sc.sno
----(24)	��ѯ�������޵Ŀγ̵Ŀγ�����
--select course.cname
--from course
--where 
--course.cno in(
--select sc.cno from sc 
--where sc.sno in(
--select student.sno from student 
--where student.ssex='��'
--)
--)
----(25)	��ѯ������С��ѧ����ѡ�Ŀγ�����
--select course.cname
--from course
--where course.cno in(
--select sc.cno from sc 
--where sc.sno =(select student.sno from student 
--where student.sage =(select min(student.sage) from student)
--)
--)
