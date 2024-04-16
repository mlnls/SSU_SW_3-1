/* NBA 농구 선수들 데이터베이스 */
Create table player(
    pID      char(5) primary key,
    Name     varchar(30),
    position varchar(30),
    salary   numeric(10,0)
);

Create table team (
    tID      char(5),
    pID      char(5),
    cID      char(5),
    teamName varchar(30),
    city     varchar(30),
    rank     integer,
    primary key(tId, pID, cID)
);

Create table coach (
    cID      char(5) primary key,
    Name     varchar(30),
    salary   numeric(10,0)
);

Create table score (
    num number(4) primary key,
    teamName varchar2(30)
);

/* Sequence */
Create sequence sequ1 start with 2 increment by 2;
Alter sequence sequ1 maxvalue 100;
Select sequ1.nextval, sequ1.currval from dual;

Insert into score values(sequ1.nextval, 'Goldenstate');
select * from score;
Drop sequence sequ1;


Insert into player values ('001', 'Stephen', 'Guard', 5190);
Insert into player values ('002', 'Lebron', 'Forward', 4760);
Insert into player values ('003', 'Nikola', 'Center', 6000);
Insert into player values ('004', 'Jordan', 'Guard', null);
Insert into player values ('005', 'Shaquille', 'Center', null);

Insert into coach values ('001', 'Steven', 3500);
Insert into coach values ('002', 'Darvin', 400);
Insert into coach values ('003', 'Michael', 4000);
Insert into coach values ('004', 'Philip', null);
Insert into coach values ('005', 'Larry', null);

Insert into team values ('001', '001', '001', 'GoldenState', 
                'SanFrancisco', 10);
Insert into team values ('002', '002', '002', 'LALakers',
                'LA', 8);
Insert into team values ('003', '003', '003', 'Denver',
                'Denver', 2);
Insert into team values ('004', '004', '004', 'Bulls', 
                'Chicago', null);
Insert into team values ('005', '005', '005', 'LALakers',
                'LA', null);

/* To Show all tuples */
select * from player;

select * from coach;

select * from team;

/* An SQL statement that shows the effect of foreign key */
select * from team where rank>4;

select cID from coach where salary=4000;

/* Join Query */
Select distinct Name from player natural join team 
                where rank<3;

Select * from (player natural join team) join coach using (cID);

Select coach.Name, player.Name, teamName from (player natural join team) 
                join coach using(cID) where city = 'Chicago';

/* Set Operator */
(select Name from player where position = 'Guard') 
union 
(select Name from player where position = 'Center');

(select Name from coach where salary > 3000)
intersect
(select Name from coach where cID = '001');

/* Use of 'is null' clause */
select name from player where salary is null;

select pID,tID from team where cID is null;

/* Use of 'order by' clause */
select salary from player order by salary;

select rank from team where rank is not null 
                order by rank desc;

/* drop table */
Drop table player;
Drop table team;
Drop table coach;
Drop table score;