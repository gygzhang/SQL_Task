/*
ʵ���� �������������
ʵ��ѧʱ��2
ʵ�����ͣ���֤
ʵ��Ҫ�󣺱���
һ��ʵ��Ŀ��
ͨ����ʵ���ѧϰ��ʹѧ�������մ������������ƺ�ʹ�á�
����ʵ������
˵����ʹ�����д������ݿ⡣
 
1���½�һ�������¼ͳ�Ʊ�LoanNum�����ÿһ�����˵�λ�Ĵ��������ΪLoanT����һ��INSERT��伶�������������µĴ����¼����ʱ����Ҫ��ʱ����LoanNum���и÷��˵Ĵ��������

2������һ��AFTER�м�������������LoanT��Ĵ����Lamount�������޸�ʱ������������10%���򽫴˴β�����¼������һ�ű�L_U��Eno��Bno��Oldamount��Newamount��������Oldamount���޸�ǰ�Ľ�Newamount���޸ĺ�Ľ�

3������һ��instead of�м���������Ϊ�����(LoanT)���������Թ��򡰴������ڣ�Ldata���������ڵ�ǰ���ڣ�������ڣ��Զ���Ϊ��ǰ���ڡ���

4������һ��DELETE���������������(LoanT)�еļ�¼��ɾ��ʱ����ɾ���Ĵ����¼��ɾ�����ڲ��뵽����һ�ű�L_D(Eno, Bno, Ldata, Lamount, Lterm, Deldata)

*/
--use [���д���]
/*
1���½�һ�������¼ͳ�Ʊ�LoanNum�����ÿһ�����˵�λ�Ĵ��������
ΪLoanT����һ��INSERT��伶�������������µĴ����¼����ʱ����
Ҫ��ʱ����LoanNum���и÷��˵Ĵ��������
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
--Inserted��������ǲ�������޸ĺ�����ݣ���deleted��������Ǹ���ǰ�Ļ���ɾ�������ݡ�
	--select Eno from inserted
	update LoanNum set LoanNum.num = LoanNum.num+1 where LoanNum.Eno=(select Eno from inserted)
END*/

--drop trigger qq


--insert LoanT VALUES('E01','B1104','2008-1-21',27,10);

/**
2������һ��AFTER�м�������������LoanT��Ĵ����Lamount�������޸�ʱ��
����������10%���򽫴˴β�����¼������һ�ű�L_U��Eno��Bno��Oldamount��
Newamount��������Oldamount���޸�ǰ�Ľ�Newamount���޸ĺ�Ľ�
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
3������һ��instead of�м���������Ϊ�����(LoanT)����������
���򡰴������ڣ�Ldata���������ڵ�ǰ���ڣ�������ڣ��Զ���Ϊ��ǰ���ڡ���
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

--����LOANT����LD
--select * into L_D FROM LoanT where 1=0
--use ���д���
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


