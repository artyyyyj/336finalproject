/* finds top 10 spenders of a bar */
select d, truncate(sum(total_price), 2) sum from (select distinct drinker d, total_price from bills where bar = "Anchor") as t1 group by d ORDER BY sum DESC limit 10;

/* finds top 10 beers of a bar */
select i, sum(quantity) sum from (select bill_id, item i, quantity from transactions where type = "beer" and bill_id in (select bill_id from bills where bar = "Lively Elf")) as t1 group by i 
order by sum desc limit 10;

/* finds top 5 manf at a bar */
select manf, sum(quantity) sum from (select transactions.bill_id, transactions.item, beer.manf, transactions.quantity
FROM transactions 
INNER JOIN beer on transactions.item = beer.name and bill_id in (select bill_id from bills where bar = "Absent Snow")) as t1 group by manf order by sum desc limit 5;

/* finds transactions for every hour of the day for a bar*/
select hour(time) hour, count(hour(time)) count from bills where bar = "Anchor" group by hour order by hour asc;

/* finds transactions for every day of the week for a bar*/
select day day, count(day) count from bills where bar = "Anchor" group by day order by count desc;

select * from transactions;
select * from bills;
select * from beer;

/* finds top 5 bars where this beer sells the most */
select bar, sum(quantity) sum from (select bills.bill_id, bills.bar, transactions.item, transactions.quantity, transactions.type
FROM bills 
INNER JOIN transactions on transactions.bill_id = bills.bill_id and transactions.type = "beer" and transactions.item = "Honey Fayre") as t1 group by bar order by sum desc limit 5;

/* finds top drinkers of a beer */
select drinker, sum(quantity) sum from (select bills.bill_id, bills.drinker, transactions.item, transactions.quantity, transactions.type
FROM bills INNER JOIN transactions on transactions.bill_id = bills.bill_id and transactions.type = "beer" and transactions.item = "Dry Hop Red") as t1 group by drinker order by sum desc limit 10;

/* finds time distribution for a beer */
select hour(time) hour, sum(quantity) sum from (select bills.bill_id, bills.time, transactions.item, bills.bar, transactions.quantity, transactions.type
FROM bills INNER JOIN transactions on transactions.bill_id = bills.bill_id and transactions.type = "beer" and transactions.item = "Dry Hop Red") as t1 group by hour;

/* see all his/her transactions ordered by time and grouped by bars. */
select bills.bill_id, transactions.item, transactions.quantity, transactions.type, bills.bar, bills.date, bills.time
FROM bills INNER JOIN transactions on transactions.bill_id = bills.bill_id and drinker = "Lucia Kim" ORDER BY bar, date desc, hour(time) desc;

/* b) see a graph with the beers s/he orders the most */
select item, sum(quantity) sum from (select bills.bill_id, transactions.item, transactions.quantity, transactions.type, bills.bar, bills.date, bills.time
FROM bills INNER JOIN transactions on transactions.bill_id = bills.bill_id and drinker = "Lucia Kim" and type = "beer") as t1 group by item;

/* spending per bar (for a drinker) */
select bar, truncate(sum(total_price), 2) sum from (select * from bills where drinker = "Scott Taylor") as t1 group by bar;

/* spending per day (for a drinker) */
select day, truncate(sum(total_price), 2) sum from (select * from bills where drinker = "Scott Taylor") as t1 group by day order by sum desc;

/* spending per month (for a drinker) */
select month(date) month, truncate(sum(total_price), 2) sum from (select * from bills where drinker = "Betty Bowlds") as t1 group by month(date) order by sum desc;

# 2-1?
select not exists (select bills.bill_id billid, bills.bar barname, bills.time timeoftransaction, operates.start starttime, operates.end endtime from bills
INNER JOIN operates on bills.bar = operates.bar and bills.day = operates.day and (bills.time > operates.end or bills.time < operates.start)) as bol;


# 2-2
select not exists (SELECT * FROM  frequents table1 WHERE EXISTS (SELECT * FROM (select bar.name barname, drinker.name drinkername from bar
INNER JOIN drinker on drinker.state != bar.state) as table2
                   WHERE  table1.bar = table2.barname AND
                          table1.drinker = table2.drinkername)) as bol;
                          
select * from bar where name = "Anchor";
select * from drinker where name = "Albert Hupp";
 INSERT INTO frequents VALUES ("Anchor", "Albert Hupp");


select bills.bill_id billid, bills.bar barname, bills.time timeoftransaction, operates.start starttime, operates.end endtime from bills
INNER JOIN operates on bills.bar = operates.bar and bills.day = operates.day and (bills.time > operates.end or bills.time < operates.start);

select * from beer;
select * from sellsbeer;

select sellsbeer.barname, sellsbeer.beername, sellsbeer.price from sellsbeer;

select b1, b2 from (select t1.name b1, t2.name b2
from beer as t1, beer as t2
where t1.name != t2.name
order by t1.name and t2.name) as z where ((select price from sellsbeer where b1 = beername) > (select price from sellsbeer where b2 = beername)) 
and ((select price from sellsbeer where b1 = beername) < (select price from sellsbeer where b2 = beername));


select t1.name b1, t2.name b2
from beer as t1, beer as t2
where t1.name != t2.name
order by t1.name and t2.name;

 INSERT INTO frequents VALUES ("Anchor", "Albert Hupp");

select * from bar where name = "Regular Drum Tavern";
select * from drinker where name = "Albert Hupp";
select * from bar;
select * from bills;
select * from operates;


