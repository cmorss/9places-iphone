create table trips (primary_key int, title varchar(100), description varchar(255));
create table landmark (primary_key int, trip_id int, title varchar(100), description varchar(255));

insert into trips (title, description) values ("Beach Trip", "A summer trip to the sunny beaches of Alaska");
