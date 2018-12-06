/*
实验四 触发器程序设计
实验学时：2
实验类型：验证
实验要求：必修
一、实验目的
通过本实验的学习，使学生掌握握触发器程序的设计和使用。
二、实验内容
说明：使用银行贷款数据库。
 
1、新建一个贷款记录统计表LoanNum，存放每一个法人单位的贷款次数。为LoanT表创建一个INSERT语句级触发器，当有新的贷款记录插入时，需要及时更新LoanNum表中该法人的贷款次数。

2、创建一个AFTER行级触发器，当对LoanT表的贷款金额（Lamount）进行修改时，若金额减少了10%，则将此次操作记录到另外一张表L_U（Eno，Bno，Oldamount，Newamount），其中Oldamount是修改前的金额，Newamount是修改后的金额。

3、创建一个instead of行级触发器，为贷款表(LoanT)定义完整性规则“贷款日期（Ldata）不能早于当前日期，如果早于，自动改为当前日期”。

4、创建一个DELETE触发器，当贷款表(LoanT)中的记录被删除时，将删除的贷款记录和删除日期插入到另外一张表L_D(Eno, Bno, Ldata, Lamount, Lterm, Deldata)

*/
--use [银行贷款]
/*
1、新建一个贷款记录统计表LoanNum，存放每一个法人单位的贷款次数。
为LoanT表创建一个INSERT语句级触发器，当有新的贷款记录插入时，需
要及时更新LoanNum表中该法人的贷款次数。
*/
/*create table LoanNum1(
	num int,
	Eno char(3) foreign key references LET(Eno)
)*/

/*INSERT LoanNum values(3,'E01');
INSERT LoanNum values(7,'E02');
INSERT LoanNum values(2,'E03');
INSERT LoanNum values(2,'E06');
INSERT LoanNum values(4,'E07');
INSERT LoanNum values(3,'E09');
INSERT LoanNum values(1,'E10');*/


/**create trigger qq
on LoanT
AFTER insert
as
begin
--Inserted表的数据是插入或是修改后的数据，而deleted表的数据是更新前的或是删除的数据。
	--select Eno from inserted
	update LoanNum set LoanNum.num = LoanNum.num+1 where LoanNum.Eno=(select Eno from inserted)
END*/

--drop trigger qq


--insert LoanT VALUES('E01','B1104','2008-1-21',27,10);

/**
2、创建一个AFTER行级触发器，当对LoanT表的贷款金额（Lamount）进行修改时，
若金额减少了10%，则将此次操作记录到另外一张表L_U（Eno，Bno，Oldamount，
Newamount），其中Oldamount是修改前的金额，Newamount是修改后的金额。
**/
--create trigger atrigger
--on LoanT
--after update
--as 
--begin
--	declare @old int,@new int;
--	select @old= Lamount from deleted
--	select @new = Lamount from inserted
--	print @old
--	print @new
--end

--drop trigger atrigger

/*create table L_U(
	Eno char(3) not null,
	Bno char(5) not null,
	Oldamount int,
	Newamount int,
	primary key(Eno,Bno),
	foreign key(Eno) references LET(Eno),
	foreign key(Bno) references BankT(Bno)
)*/

--create trigger atrigger
--on LoanT
--after update
--as 
--begin
--	declare @old int,@new int,@eno char(3),@bno char(5);
--	select @old= Lamount from deleted
--	select @new = Lamount from inserted
--	select @eno = Eno from deleted
--	select @bno = Bno from deleted
--	if @old-@new=0.1*@old
--	insert into L_U(Eno,Bno,Oldamount,Newamount) values(@eno,@bno,@old,@new)
--	--print @old-@new
--end

--drop trigger atrigger

--update LoanT set Lamount=1000 where LoanT.Bno='B1100' AND LoanT.Eno='E01'

/**
3、创建一个instead of行级触发器，为贷款表(LoanT)定义完整性
规则“贷款日期（Ldata）不能早于当前日期，如果早于，自动改为当前日期”。
**/

--create trigger tgr_instead
--on LoanT
--instead of update,insert
--as
--begin
--	declare @date datetime,@Eno char(3),@Bno char(5),@term int,@amount int
--	declare @inserted int,@deleted int
--	select @inserted =count(*) from inserted
--	select @deleted = count(*) from deleted
--	print @inserted
--	print @deleted
--	--insert
--	if(@inserted=1 and @deleted=0)
--		begin
--			select @Bno=Bno,@Eno=Eno, @term=Lterm,@amount=Lamount,@date=Ldate from inserted
--			if(@date>GETDATE()) insert LoanT(Bno,Eno,Ldate,Lamount,Lterm) values(@Bno,@Eno,GETDATE(),@amount,@term)
--			else insert LoanT(Bno,Eno,Ldate,Lamount,Lterm) values(@Bno,@Eno,@date,@amount,@term)
--		end
--	--update
--	if(@inserted=1 and @deleted=1)
--		begin
--			select @Bno=Bno,@Eno=Eno, @term=Lterm,@amount=Lamount,@date=Ldate from inserted
--			--print 
--			if(update(Ldate) and @date>getdate()) update LoanT set Ldate =GETDATE(),Lamount=@amount,Lterm=@term  where Bno =@Bno and Eno =@Eno
--			else update LoanT set Ldate =@date,Lamount=@amount,Lterm=@term  where Bno =@Bno and Eno =@Eno
--		end
--end	

--drop trigger tgr_instead

--update LoanT set Ldate='2099-1-1' where LoanT.Bno='B1100' AND LoanT.Eno='E01' 
--insert into LoanT(Eno,Bno,Ldate,Lterm,Lamount) values('E01','B1100','2088-01-01',1000,1111);

--create table L_D();

--根据LOANT创建LD
--select * into L_D FROM LoanT where 1=0
--use 银行贷款
--create trigger tgr_deleted
--on LoanT
--for delete
--as
--begin 
--	declare @date datetime,@Eno char(3),@Bno char(5),@term int,@amount int
--	select @date=Ldate,@Eno=Eno,@Bno=Bno,@term=Lterm,@amount=Lamount from deleted
--	insert into L_D(Bno,Eno,Ldate,Lamount,Lterm) values(@Bno,@Eno,@date,@amount,@term)
--end

--drop trigger tgr_deleted

--delete from LoanT where LoanT.Bno='B1100' AND LoanT.Eno='E01' 


