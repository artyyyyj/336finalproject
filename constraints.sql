# adding primary keys
ALTER TABLE bills
ADD PRIMARY KEY (bill_id); 

ALTER TABLE bar
ADD PRIMARY KEY (name); 

ALTER TABLE barfood
ADD PRIMARY KEY (name); 

ALTER TABLE beer
ADD PRIMARY KEY (name, manf); 

ALTER TABLE drinker
ADD PRIMARY KEY (name, phone); 

ALTER TABLE frequents
ADD PRIMARY KEY (bar, drinker); 

ALTER TABLE sellsbeer
ADD PRIMARY KEY (barname, beername); 

ALTER TABLE sellsfood
ADD PRIMARY KEY (barname, foodname);

ALTER TABLE transactions
ADD PRIMARY KEY (bill_id);

# attempt to add a tuple with an already existing bill-id : this fails because of the primary key
 INSERT INTO bills values("539d0ed9-d719-11e8-a6b4-acde48001122", "Absent Snow", "2018-01-09", "Gary Dunsford", 51.3, 3.59, 8.72, 63.61, "17:52:00", "Bertie Rains", "Tuesday");
 INSERT INTO sellsbeer values("Anchor", "Dry Hop Red", 9.45);
 
 INSERT INTO drinker values("Arthur Lai", "900-900-9030", "NJ");
 INSERT INTO drinker values( "Ailene Brown",	"644-147-9657",	"MD");
 INSERT INTO drinker values( "Ailene Brown",	"908-234-2343",	"MD");
 
 # Adding Foreign Keys
 ALTER TABLE bills ADD FOREIGN KEY (bar) REFERENCES bar(name); 
INSERT INTO bills values("test1", "Walmart", "2018-01-09", "Gary Dunsford", 51.3, 3.59, 8.72, 63.61, "17:52:00", "Bertie Rains", "Tuesday");

 ALTER TABLE bills ADD FOREIGN KEY (drinker) REFERENCES drinker(name); 
 INSERT INTO bills values("test1", "Walmart", "2018-01-09", "Superman", 51.3, 3.59, 8.72, 63.61, "17:52:00", "Bertie Rains", "Tuesday");
 
  ALTER TABLE sellsbeer ADD FOREIGN KEY (beername) REFERENCES beer(name);
  ALTER TABLE sellsbeer ADD FOREIGN KEY (barname) REFERENCES bar(name);
INSERT INTO sellsbeer values("Anchor", "Water", 9.45);
INSERT INTO sellsbeer values("Walmart", "Honey Fayre", 9.45);

  ALTER TABLE sellsfood ADD FOREIGN KEY (foodname) REFERENCES barfood(name);
  ALTER TABLE sellsfood ADD FOREIGN KEY (barname) REFERENCES bar(name);
  INSERT INTO sellsfood values("Anchor", "Hershey Chocolate Bars", 9.45);
INSERT INTO sellsfood values("Walmart", "Burger", 9.45);
    
    select * from sellsfood where barname = "Anchor";
    select * from barfood;
 






 

 
 





