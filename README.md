## Database-task

数据库

#### Part 1

DurianPC aims to become a top-notch manufacturer of desktop and laptop computers in the Lukewarm Kingdom. The company was just formed recently but has already received abundant funding from investors all over the kingdom. The company has made a lot of decisions on the structure and operations of the company, which will be shown in the next section. In this coursework, your task is to:
1. First, design a database that works under the company’s structure and operating model. The database must be in the third normal form (3NF). Tables should not have m:m relationships.
2. Design necessary INSERT/UPDATE statements that can modify the database based on the company’s requirements.
3. Design necessary SELECT queries that can fetch needed information for the company.

#### The Structure of the Company

The owner of DurianPC has decided that the manufacturing will be carried out in a factory in the north region of the kingdom while the administrative staff will work in the headquarters (HQ) located in the centre of the kingdom.      Each work place is associated with a unique postcode.      Apart from the factory and the HQ, the owner of the DurianPC also wants to provide customers with places to experience his products.      As a result, many retail stores will be constructed at different places across the Lukewarm region.      All staffs in these retail stores are considered employees of the company, belonging to the sales department.      Each retail store is associated with one postcode.

Staff is organised by departments in the company.      Each department has a department name and some descriptions.      Each staff is assigned to one or more roles in his department.      Two or more persons may share the same role in the department so that the workload can be split.      Like departments, roles are also associated with some descriptions.      Two departments may have roles with the same name, so be careful when designing your database.      Offices are usually allocated to staff by the department.      However, staff members from different departments can occasionally share offices.      Each staff has a unique phone number, a computer account that is a string no longer than 15 characters and an email address.      Sometimes, an email address is given to a role shared by many staff members.      For example, the human resource (HR) department has a shared email account HR@durian.pc and the finance office has finance@durian.pc.      The company should also be able to identify what department an email address belongs to and the person(s) who use it by searching the database.      In addition to the above requirements, the IT department will ask a user to change his email password 1 year after the last time he changes his password.

Individual staff performance is evaluated every year to decide their salary.      There’s a salary baseline for each individual decided when the working contract was signed.      High performers can receive up to 20% salary bonus.      Staffs working in the south region of Lukewarm will receive a 10% salary bonus due to the high temperature there.      The “working” here means the employee’s office is located in that region.      The region information can be found by analysing the postcode.      All postcodes in the south region start with “LS”.

All staff bonuses are added rather than multiplied.      If one staff is being sick, he will receive 90% of his normal payment (after counting all bonuses) without having to go to the company.      For example, if an employee is a high performer and works in the south region, he will have (100% + 20% + 10% = 130%) salary based on his salary baseline.      But if he gets sick and has to stay at home for a month, he will receive (130% * 90% = 117%) pay.

The financial department will pay salaries at the end of each month based on the performance records in the database.      Payment records must be stored in the database so that they can be retrieved in the future.      The amount of payment bonus or deduction, and the reason (just some text comments) should also be indicated clearly along with the payment records.

The computers manufactured by DurianPC includes desktops and laptops.     Each computer has a unique serial number once manufactured.     There are also different models for computers.     Model numbers for desktops start with “DT”, followed by 4 digits (e.g. DT4271).     Model numbers for laptops start with “LC”, followed by 4 digits, and then end with letter ‘P’ or ‘L’ (E.g. LC2333P).     The letter ‘P’ means powerhouse and the letter ‘L’ means feather-light.     Before a computer is packaged and shipped, it will be checked thoroughly by an employee for defects.     A computer is made up of several parts (such as CPU, motherboard, graphics card, screen and power supply).     Each part is associated with a part type, a manufacturer, a model and a unique serial number.     Below is an example of a CPU installed on a computer:

1.     Part type: CPU
2.     CPU model: i5-4430
3.     Manufacturer: Intel
4.     Unique serial number: L070Q228

Each month, DurianPC will make a phone call to the part manufacturers to report common defects of their parts.     The company will also send the defected parts to the manufacturer if requested.     You can assume that phone numbers contain only digits.     Your database should keep a record of all computers manufactured so far, their manufacture time, the staff who did the quality assurance, each computer’s parts information as well as whether this computer has been sold and from which retail store.

In this coursework, you can make some assumptions to the data if they are not specified in the requirements. For example, you can assume address occupies up to 200 characters, or people’s name can be up to 30 characters long.

Based on the description in the previous section, design your tables for DurianPC. The table design should be in the third normal form (3NF) and should not have m:m relationships in the ER diagram. You need to provide both the ER diagram and the SQL create table statements. ER diagrams can be generated automatically from phpMyAdmin or other tools. You don’t have to manually draw everything.


#### Part 2

In the second part, you are required to write queries based on the model answer.    The table design of the model answer is shown below, an SQL containing all CREATE TABLE statements is also available on the module page. Once done, save all of these SELECT statements in “answer.txt” or “answer.   sql”.


1. Get the retail store(s) that has sold the most amount of powerhouse laptops. In the result, list the
name(s) of the retail store(s) and the amount sold.

2. Get the staff names and their associated department names for the email account
“manager.club@durian.pc”.

3. List all staff members in the finance department (‘Finance’, case sensitive) whose current baseline
salary is higher than the highest base salary of the sales department (‘Sales’, also case sensitive).

4. Get the list of email accounts for those who work in an office alone (share no office with others).
In the result, only list staff members’ personal email accounts (email type is ‘personal’, case
sensitive).

5. Get the difference between the highest baseline salary and the second highest baseline salary of all
staff members. Multiple cases of highest salaries should be considered as a single case, same for
the second highest salaries (For example, for four salaries 2000, 2000, 1800 and 1800, the
difference should be 200). The result should have a single column “diff” and a single value. You
are not allowed to use the LIMIT keyword

6. Get the list of all staff members who once did quality checking in the factory and checked at least
one computer, but then changed to a different role and have worked as the new role for at least
for one month. Assume that the role does quality checking is called “QA staff”, role names are
case sensitive. In the result, list staff names and staff accounts.


