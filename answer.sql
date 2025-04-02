Chuanxin.Zhai  


1.
select workp.name,max(pc1.sales_quantity) as quantity 
from work_place workp
left join
(select sold_at,count(1)as sales_quantity from pc 
group by sold_at)pc1 on pc1.sold_at = workp.name;




2.
select 
s.name,d.name as department_name
from department d
join dept_role dr
on d.name=dr.name
join staff_role sr
on sr.role_id=dr.id
join staff s
on s.account=sr.staff_account
join email_staff_assign e 
on e.account=s.account
where e.email='manager.club@durian.pc'


3.
select s.name
from department d
join dept_role dr
on d.name=dr.name
join staff_role sr
on sr.role_id=dr.id
join staff s
on s.account=sr.staff_account
join payroll pa
on pa.staff_account=s.account
where d.name='Finance'
and pa.salary_base>
(select max(pa.salary_base)from department d
join dept_role dr
on d.name=dr.name
join staff_role sr
on sr.role_id=dr.id
join staff s
on s.account=sr.staff_account
join payroll pa
on pa.staff_account=s.account
where d.name='Sales')


4.
select email from email_staff_assign 
where account
in (select account from staff where office_id 
in (select  id from office where room 
not in (select room from  (select  room,count(*)as number from office group by room having count(*)>1)a)))
and email in (select  email_addr from email where type='personal')

5.
SELECT t1.max_1-t2.max_2 AS diff
FROM
(SELECT DISTINCT MAX(staff.current_salary_base) AS max_1
FROM staff) AS t1, (
SELECT DISTINCT MAX(staff.current_salary_base) AS max_2
FROM staff
WHERE staff.current_salary_base<(SELECT DISTINCT MAX(staff.current_salary_base)
FROM staff)) AS t2



6.
SELECT account, name
FROM staff, payroll
WHERE staff.account = payroll.staff_account
AND staff_role <> 'QA STAFF'
AND account IN ( SELECT account
FROM pc, staff, payroll
WHERE qa_staff = staff.account
AND staff.account = payroll.staff_account
GROUP BY qa_staff
HAVING COUNT(serial) > 1) ;

7.
SELECT s.staff,COUNT(s.Outstanding_Month)AS 'Con_M'
FROM(
    SELECT s.staff
    ,(s.Outstanding_Month-ROW_NUMBER() OVER(PARTITION BY s.staff ORDER BY s.Outstanding_Month ))AS 'Con_Month'
    FROM(
        SELECT s.staff
        FROM staff_awards
        GROUP BY  s.staff,
        )
    )
    GROUP BY s.staff,s.Con_Month
    HAVING COUNT (s.Outstanding_Month)>=3

