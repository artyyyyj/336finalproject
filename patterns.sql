
# 2-2
select not exists (SELECT * FROM  frequents table1 WHERE EXISTS (SELECT * FROM (select bar.name barname, drinker.name drinkername from bar
INNER JOIN drinker on drinker.state != bar.state) as table2
                   WHERE  table1.bar = table2.barname AND
                          table1.drinker = table2.drinkername)) as bol;
                          
select * from bar where name = "Anchor";
select * from drinker where name = "Albert Hupp";
 INSERT INTO frequents VALUES ("Anchor", "Albert Hupp");