
/*
 This sql file contains database of the 3 hotels:
 “Grosvenor Hotel” in London
“Grosvenor Hotel” in Oxford
 "Kings Hotel" in London
 */
 
-- create schema hotelbooking; 
--  use hotelbooking;

/*
commands to drop tables if neeeded
 DROP table IF EXISTS hotel;
 DROP table IF EXISTS room;
 DROP table IF EXISTS guest;
 DROP table IF EXISTS booking;
*/

/*
commands to view  tables if neeeded
 select * from  hotel;
 select * from  room;
 select * from   guest;
 select * from   booking;
*/

 -- ---------------------CREATING TABLES

 CREATE TABLE IF NOT EXISTS hotel (
 hotel_no CHAR(4) NOT NULL, 
 name VARCHAR(20) NOT NULL, 
 address VARCHAR(50) NOT NULL,
 PRIMARY KEY (hotel_no)
 );
 
 
 CREATE TABLE IF NOT EXISTS room ( 
 room_no VARCHAR(4) NOT NULL, 
 hotel_no CHAR(4) NOT NULL, 
 type CHAR(1) NOT NULL, 
 price DECIMAL(5,2) NOT NULL,
 PRIMARY KEY (hotel_no, room_no),
 FOREIGN KEY (hotel_no) REFERENCES hotel(hotel_no)
 );
 
 
 CREATE TABLE IF NOT EXISTS guest (
 guest_no CHAR(4) NOT NULL, 
 name VARCHAR(20) NOT NULL, 
 address VARCHAR(50) NOT NULL,
 PRIMARY KEY (guest_no)
 );
 
CREATE TABLE IF NOT EXISTS booking (
hotel_no CHAR(4) NOT NULL, 
guest_no CHAR(4) NOT NULL, 
date_from DATETIME NOT NULL, 
date_to DATETIME NULL, 
room_no CHAR(4) NOT NULL,
PRIMARY KEY (guest_no, date_from),
FOREIGN KEY (hotel_no, room_no) REFERENCES room(hotel_no, room_no),
FOREIGN KEY (guest_no) REFERENCES guest (guest_no)
); 

-- Dates are in  YYYY-MM-DD format;


 -- commands to delete from individual tables:
 -- SET SQL_SAFE_UPDATES = 0;
 -- delete from hotel;
  -- delete from room;
  -- delete from booking;
  -- delete from guest;
  
  /*
commands to view  tables if neeeded
 select * from  hotel;
 select * from  room;
 select * from   guest;
 select * from   booking;
*/
  
 INSERT INTO hotel (hotel_no , name, address)
 VALUES 
 ('H111', 'Grosvenor Hotel', 'London'),
 ('H112', 'Grosvenor Hotel', 'Oxford'),
  ('H113', 'Kings Hotel', 'London')
 ;
 
 INSERT INTO room (room_no, hotel_no, type, price)
 VALUES ('1', 'H111', 'S', 72.00),
 ('2', 'H111', 'F', 200.00),
 ('3', 'H111', 'D', 100.00),
('4', 'H111', 'D', 100.00),
('5', 'H111', 'S', 72.00),
('1', 'H112', 'S', 10.00),
('2', 'H112', 'F', 50.00),
('3', 'H112', 'D', 20.00),
('4', 'H112', 'D', 20.00),
('5', 'H112', 'S', 10.00),
('1', 'H113', 'S', 20.00),
('2', 'H113', 'F', 80.00),
('3', 'H113', 'F', 80.00),
('4', 'H113', 'D', 40.00),
('5', 'H113', 'D', 40.00)
 ; 
 -- in room table, 'type' column represents type of room
 -- 'S' means room for single occupancy,  'D' means room for double occupancy, 'F' means room for family occupancy (4 people)
 -- In Grosvenor Hotel London, room type S costs £72.0, room type D costs £100.0  and room type F costs £200.0. 
 -- In Grosvenor Hotel Oxford, room type S costs £10.0, room type D costs £20.0  and room type F costs £50.0. 
 -- In Kings Hotel London, room type S costs £20.0, room type D costs £40.0  and room type F costs £80.0. 

 
 
 -- delete from guest where guest_no in ('G111','G112','G113','G114','G115');
 
 INSERT INTO guest (guest_no, name, address)
 VALUES 
 ('G111', 'John Smith', 'London'),
 ('G112', 'Neena Kochhar', 'Delhi'),
 ('G113', 'Steven King', 'London'),
 ('G114', 'Diana Lorentz', 'London'),
 ('G115', 'John Chen', 'China'),
 ('G116', 'Ismael Sciarra', 'Tel London'),
 ('G117', 'Jose Manuel', 'New Mexico'),
 ('G118', 'Alexander Khoo', 'Alexandria'),
 ('G119', 'Sigal Tobias', 'Rome'),
 ('G120', 'Shanta Kumar', 'Mumbai'),
  ('G121', 'Steven Markle', 'Washington DC'),
  ('G122', 'James Landry', 'Madrid'),
  ('G123', 'Mozhe Atkinson', 'Sydney'),
  ('G124', 'Hazel Philtanker', 'Oslo'),
  ('G125', 'Joshua Patel', 'Kolkata')
 ;
 
 -- DROP PROCEDURE IF EXISTS insert_into_booking_before2000;
 
 
 DELIMITER //
CREATE PROCEDURE insert_into_booking_before2000()
  BEGIN
		DECLARE room_value int DEFAULT 1;
        DECLARE hotel_value int DEFAULT 1;
        DECLARE guest_value int DEFAULT 1;
        DECLARE total_hotels int;
        SET total_hotels = (select count(1) from hotel);
		WHILE hotel_value<= 3 DO
			WHILE room_value <= 5 DO
						INSERT INTO booking (hotel_no, guest_no, date_from , date_to , room_no) 
							VALUES ( concat("H11",hotel_value), concat("G1",10+guest_value),
										DATE('1999-01-01'), DATE('1999-01-01') + INTERVAL 1 DAY, CONVERT(room_value, CHAR(4)) );
						SET room_value = room_value + 1;
						SET guest_value = guest_value + 1;
				END WHILE;
			SET hotel_value = hotel_value + 1;
            SET room_value =  1;
        END WHILE;
  END //
DELIMITER ;


-- inserting 15 records into booking table where date_from is before year 2000
CALL insert_into_booking_before2000();
 
  -- delete from booking ;
  -- select * from booking;
  -- select * from room;

-- DROP PROCEDURE IF EXISTS insert_into_booking;
 
 DELIMITER //
CREATE PROCEDURE insert_into_booking()
  BEGIN
		DECLARE room_value int DEFAULT 1;
        DECLARE hotel_value int DEFAULT 1;
        DECLARE guest_value int DEFAULT 1;
        DECLARE def_date DATETIME;
        SET def_date = DATE('2022-01-15');
        WHILE month(def_date)<month(curdate()) DO
				WHILE hotel_value<= 3 DO
					WHILE room_value <= 5 DO
								INSERT INTO booking (hotel_no, guest_no, date_from , date_to , room_no) 
									VALUES ( concat("H11",hotel_value), concat("G1",10+guest_value),
												def_date, def_date + INTERVAL 2 DAY, CONVERT(room_value, CHAR(4)) );
								SET room_value = room_value + 1;
								SET guest_value = guest_value + 1;
						END WHILE;
					SET hotel_value = hotel_value + 1;
					SET room_value =  1;
				END WHILE;
			SET hotel_value =  1;
            SET guest_value =  1;
			SET def_date = DATE_ADD(def_date, INTERVAL 1 MONTH);
		END WHILE;
  END //
DELIMITER ;


-- inserting 15 records per month into booking table for the year 2022 from january to previous month
-- for months january to may, 75 records are inserted from this procedure, total of 90 records in booking table 
CALL insert_into_booking();
 
  -- delete from booking ;
  -- select * from booking;
  -- select * from room;
  
  
-- 17 more records inserted into booking table for variation in records
  
INSERT INTO booking (hotel_no, guest_no, date_from , date_to , room_no) VALUES 
 ('H111', 'G111', DATE('2021-01-01'), NULL, '1'),
 ('H111', 'G112', DATE('2021-01-01'), NULL, '2'),
 ('H111', 'G113', DATE('2001-01-03'), DATE('2001-01-04'), '3'),
 ('H111', 'G114', DATE('2022-08-04'), DATE('2022-08-08'), '4'),
 ('H111', 'G115', CURDATE(), CURDATE() + INTERVAL 1 DAY , '5'),
 ('H112', 'G111', DATE('2022-08-01'), DATE('2022-08-04'), '1'),
 ('H112', 'G112', DATE('2022-08-02'), DATE('2022-08-05'), '2'),
 ('H112', 'G113',  CURDATE() - INTERVAL 1 DAY , CURDATE() + INTERVAL 2 DAY , '3'),
 ('H112', 'G114', CURDATE() , CURDATE() + INTERVAL 3 DAY , '4'),
 ('H112', 'G115', CURDATE()- INTERVAL 3 DAY , CURDATE() , '5'),
 ('H113', 'G116', DATE('2022-08-05'), DATE('2022-08-10'), '1'),
 ('H113', 'G117', CURDATE() - INTERVAL 3 DAY , CURDATE() , '2'),
 ('H113', 'G118', CURDATE() , CURDATE() + INTERVAL 3 DAY , '3'),
 ('H113', 'G119', CURDATE() - INTERVAL 3 DAY , CURDATE() + INTERVAL 2 DAY , '4'),
 ('H113', 'G120', CURDATE(), CURDATE() + INTERVAL 1 DAY , '5'),
 ('H111', 'G121', DATE('2021-01-01'), NULL, '1'),
 ('H113', 'G122', DATE('2021-01-01'), NULL, '3')
 ; 
 

	
select * from hotel;
select * from room;
desc booking;
select * from guest;
select * from booking;

select  distinct month(date_from), year(date_from) from booking;
select * from booking where year(date_from)=2001 or year(date_to)=2001;

-- Get the details of the single rooms booked in jan month of 2022 till 15 th jan 
-- and also get the total revenue geneated for this period from single rooms
select room.hotel_no, sum(room.price) as revenue_ForSingleRooms
from room inner join booking on room.room_no=booking.room_no and room.hotel_no=booking.hotel_no
where
	( (booking.date_from between "2022-01-01" and "2022-01-15") and  ( booking.date_to between "2022-01-01" and "2022-01-15" ))
    and 
	room.type='S'
group by room.hotel_no
;

select room.hotel_no, room.room_no, sum(room.price) as revenue_ForSingleRooms
from room inner join booking on room.room_no=booking.room_no and room.hotel_no=booking.hotel_no
where
	( (booking.date_from between "2022-01-01" and "2022-01-15") )
    and 
	room.type='S'
group by room.hotel_no,room.room_no
;
select * from room where hotel_no='H111';

UPDATE room SET price = price*1.05;


-- DROP TABLE IF EXISTS booking_old;
-- delete from booking_old;

CREATE TABLE  IF NOT EXISTS booking_old (
 hotel_no CHAR(4) NOT NULL, 
 guest_no CHAR(4) NOT NULL, 
 date_from DATETIME NOT NULL, 
 date_to DATETIME NULL, 
 room_no VARCHAR(4) NOT NULL,
 PRIMARY KEY (guest_no,date_from) 
 );
 
 select * from booking_old;

INSERT INTO booking_old (
SELECT * FROM booking WHERE (date_to < DATE'2000-01-01' )
 )  ;


 DELETE FROM booking WHERE date_to < DATE('2000-01-01');
 -- 107-15 = 92 records in booking table

select * from hotel;
select * from room;
select * from booking;
select * from guest;


select * from booking_old
where 
	month(booking_old.date_from) in (7,8,9,10)
    OR
    month(booking_old.date_to) in (7,8,9,10)
;

select *
from 
hotel	
	inner join room on room.hotel_no = hotel.hotel_no
		inner join booking on (booking.room_no=room.room_no  and booking.hotel_no=room.hotel_no)
where 
	hotel.name != "Grosvenor Hotel"
;

select ( (
	select sum(price)
	from 
	booking_old 
		inner join room on (booking_old.room_no=room.room_no  and booking_old.hotel_no=room.hotel_no)
			inner join hotel on room.hotel_no = hotel.hotel_no
	where
	hotel.name != "Grosvenor Hotel"
    ) -
	(select sum(price)
	from 
	booking_old 
		inner join room on (booking_old.room_no=room.room_no  and booking_old.hotel_no=room.hotel_no)
			inner join hotel on room.hotel_no = hotel.hotel_no
	where
		hotel.name = "Grosvenor Hotel"
	) ) as pricediff
;
    
select hotel_no, room_no, max(room_bookings)
from 
(select  
	room.hotel_no, room.room_no , 
    count(booking.date_from) as room_bookings
from
	booking
		inner join room on (booking.room_no=room.room_no  and booking.hotel_no=room.hotel_no)
-- where 
--	( month(booking.date_from)=month(curdate()) or month(booking.date_to)=month(curdate()) )
group by room.hotel_no, room.room_no
order by room_bookings desc,hotel_no
) as boookings_byroom

group by hotel_no
having boookings_byroom.room_bookings = max(boookings_byroom.room_bookings)
;

select year(date_from) from booking;

select room.hotel_no, room.room_no, sum(room.price) as revenue_ForSingleRooms
from room inner join booking on room.room_no=booking.room_no and room.hotel_no=booking.hotel_no
where
	( (booking.date_from between "2022-01-01" and "2022-01-15") )
    and 
	room.type='S'
group by room.hotel_no,room.room_no
;

select room.hotel_no, year(booking.date_from) as booking_year, sum(room.price) as revenue_ForYear
from room inner join booking on room.room_no=booking.room_no and room.hotel_no=booking.hotel_no
group by room.hotel_no,booking_year
-----------------------------------------------------------------

-- Simple Queries

-- 1. List full details of all hotels.

select 
hotel.hotel_no, hotel.name as hote_name, hotel.address as hotel_address,
room.room_no, room.type as room_type, concat("£",room.price) as room_price
from 
 hotel 
  inner join room on hotel.hotel_no=room.hotel_no
;

-- 2. List full details of all hotels in London.

select 
hotel.hotel_no, hotel.name as hote_name, hotel.address as hotel_address,
room.room_no, room.type as room_type, concat("£",room.price) as room_price
from 
 hotel 
  inner join room on hotel.hotel_no=room.hotel_no
where   hotel.address LIKE '%London%'  
;

-- 3. List the names and addresses of all guests in London, alphabetically ordered by name.

select 
name as guest_name, address as guest_address
from guest 
where  address LIKE '%London%'   
order by guest_name
;

-- 4. List all double or family rooms with a price below £40.00 per night, in ascending order of price.

select 
 hotel_no, room_no,  type as room_type ,
 concat("£",room.price) as room_price
from room 
where price<40.00 and (type='F' or type='D')
order by room_price asc
 ;

-- 5. List the bookings for which no date_to has been specified.

select * from booking
where booking.date_to IS NULL;
;

 
-------------------------------------------------------------------------


-- Aggregate Functions



-- 1. How many hotels are there?

select count(hotel_no) as number_of_hotels from hotel;

-- 2. What is the average price of a room? 
-- (here 2 approaches are used; one calcualtes average for all rooms in all hotel;)
--  ( another one calcualtes average for all rooms for each hotel )

select concat("£",avg(price))  as average_price_room 
from room;

-- OR 

select hotel_no, concat("£",avg(price))  as average_price_room 
from room 
group by hotel_no;

-- 3. What is the total revenue per night from all double rooms?

select concat("£",sum(price))  as total_revenue_Doubleroom 
from room 
where type='D';

-- 4. How many different guests have made bookings for August?

select count(distinct guest_no) as number_ofGuests_inAug
from booking 
where   ( month(booking.date_from)=8 or month(booking.date_to)=8 )
;

select * from booking;

select (select count(date_from) from booking
where (curdate() not between date_from and date_to) and date_to IS NOT NULL)
+
(select count(date_from) from booking_old
where (curdate() not between date_from and date_to) and date_to IS NOT NULL)
as previous_numBookings;


-------------------------------------------------------------------------------------------------------

-- Subqueries and Joins


-- 1. List the price and type of all rooms at the Grosvenor Hotel.
--    (Here  hotel_no is displayed in output to differentiate two hotels with name Grosvenor Hotel)

select 
	concat("£",room.price) as room_price, 
	room.type as room_type,
	room.hotel_no
from room
where room.hotel_no IN 
	( select hotel_no from hotel where hotel.name='Grosvenor Hotel')
;

-- 2. List all guests currently staying at the Grosvenor Hotel.

select  
guest.guest_no, guest.name as guest_name, 
room.room_no, 
hotel.hotel_no,hotel.name as hotel_name
from 
 hotel 
  inner join room on hotel.hotel_no=room.hotel_no
   inner join booking on (booking.room_no=room.room_no and booking.hotel_no=room.hotel_no)
    inner join guest on guest.guest_no=booking.guest_no
where hotel.name='Grosvenor Hotel' 
		and 
	( CURDATE() between booking.date_from and booking.date_to )
;

-- 3. List the details of all rooms at the Grosvenor Hotel, 
-- including the name of the guest staying in the room, if the room is occupied.

select  
hotel.hotel_no, hotel.name as hotel_name, hotel.address,
room.room_no, room.type as room_type, room.price as room_price,
todaysGuest.guest_name as guest_name
from 
 hotel 
  inner join room on hotel.hotel_no=room.hotel_no
	left join 
		(   select booking.hotel_no, booking.room_no,guest.name as guest_name
			from booking
				inner join guest on guest.guest_no=booking.guest_no
			where ( CURDATE()between booking.date_from and booking.date_to )
        ) as todaysGuest
        on (todaysGuest.room_no=room.room_no and todaysGuest.hotel_no=room.hotel_no)
where hotel.name='Grosvenor Hotel';
        



-- 4. What is the total income from bookings for the Grosvenor Hotel today?
-- TODAY

select 
concat("£", sum( room.price ) ) as todays_booking_income
from booking
		inner join room on (booking.room_no=room.room_no and booking.hotel_no=room.hotel_no)
			inner join hotel on hotel.hotel_no = room.hotel_no
where
		hotel.name='Grosvenor Hotel'
        and 
		(   (CURDATE()	between 	booking.date_from and booking.date_to) )
;



-- 5. List the rooms that are currently unoccupied at the Grosvenor Hotel.


select 
room.hotel_no, room.room_no, room.type as room_type, room.price as room_price
from hotel
		inner join room on (hotel.hotel_no=room.hotel_no)
where 
		(hotel.name='Grosvenor Hotel' )
        AND
		(room.hotel_no, room.room_no) 
		NOT IN
			(	select  room.hotel_no,room.room_no
				from 
					hotel 
						inner join room on hotel.hotel_no=room.hotel_no
							inner join booking on (booking.room_no=room.room_no and booking.hotel_no=room.hotel_no)
				where
					hotel.name='Grosvenor Hotel' 
					and 
					( CURDATE() between booking.date_from and booking.date_to)
		)
;


-- 6. What is the lost income from unoccupied rooms at the Grosvenor Hotel?

select 
concat("£",sum( room.price)) as Lostincome_from_vacantRooms
from hotel
		inner join room on (hotel.hotel_no=room.hotel_no)
where 
		(hotel.name='Grosvenor Hotel' )
        AND
		(room.hotel_no, room.room_no) 
		NOT IN
        
			(select  room.hotel_no,room.room_no
				from 
					hotel 
						inner join room on hotel.hotel_no=room.hotel_no
							inner join booking on (booking.room_no=room.room_no and booking.hotel_no=room.hotel_no)
				where hotel.name='Grosvenor Hotel' 
				and 
				( CURDATE() between booking.date_from and booking.date_to	)
		)
;

--------------------------------------------------------------------------------------

-- Grouping

-- 1. List the number of rooms in each hotel.

select 
hotel.hotel_no, hotel.name as hotel_name, hotel.address,
count(room.room_no) as Number_ofRooms
from hotel 
		inner join room on hotel.hotel_no = room.hotel_no
group by hotel_no
;


-- 2. List the number of rooms in each hotel in London.

select 
hotel.hotel_no, hotel.name as hotel_name, hotel.address,
count(room.room_no) as number_ofRooms
from hotel 
		inner join room on hotel.hotel_no = room.hotel_no
where hotel.address like "%London%"
group by hotel_no
;

-- 3. What is the average number of bookings for each hotel in August?

select 
hotel.hotel_no, hotel.name as hotel_name, hotel.address,
count(booking.date_from)/31 as AvgNumber_OfBookings
from hotel 
		inner join room on hotel.hotel_no = room.hotel_no
			inner join booking on (booking.room_no=room.room_no and booking.hotel_no=room.hotel_no)
where   ( month(booking.date_from)=8 or month(booking.date_to)=8 )
group by hotel_no
;

-- 4. What is the most commonly booked room type for each hotel in London?
-- (approach: here two subqueries are joined)

select 
	hotel_typebookings1.hotel_no, hotel_typebookings1.hotel_name,
    hotel_typebookings1.hotel_address, 
    hotel_typebookings1.room_type, hotel_typebookings1.bookings_perType
from 			
			(	select 
					hotel.hotel_no, hotel.name as hotel_name, hotel.address as hotel_address,
                    room.type as room_type, 
					count(booking.date_from) as bookings_perType
				from hotel 
						inner join room on hotel.hotel_no = room.hotel_no
							inner join booking on (booking.room_no=room.room_no and booking.hotel_no=room.hotel_no)
				where  hotel.address="London"
				group by room.hotel_no, room.type
				) hotel_typebookings1
	 LEFT JOIN
			(	select 
					hotel.hotel_no, hotel.name as hotel_name, hotel.address as hotel_address,
                    room.type as room_type, 
					count(booking.date_from) as bookings_perType
				from hotel 
						inner join room on hotel.hotel_no = room.hotel_no
							inner join booking on (booking.room_no=room.room_no and booking.hotel_no=room.hotel_no)
				where  hotel.address="London"
				group by room.hotel_no, room.type
				) hotel_typebookings2
                
		ON
        (hotel_typebookings1.hotel_no=hotel_typebookings2.hotel_no and 
           hotel_typebookings1.bookings_perType < hotel_typebookings2.bookings_perType
        )
  WHERE
		hotel_typebookings2.hotel_no IS NULL
;
  
  


select hotel_no, room_type, max(bookings_perType)
from 
(select  
	room.hotel_no, room.type as room_type , 
    count(booking.date_from) as bookings_perType
from
	booking
		inner join room on (booking.room_no=room.room_no  and booking.hotel_no=room.hotel_no)
-- where 
--	( month(booking.date_from)=month(curdate()) or month(booking.date_to)=month(curdate()) )
group by room.hotel_no, room_type
) as boookings_byroom
group by hotel_no
;
	

-- 5. What is the lost income from unoccupied rooms at each hotel today?

select 
hotel.hotel_no, hotel.name as hotel_name, hotel.address as hotel_address,
concat("£",sum( room.price)) as LostIncome_from_VacantRooms
from hotel
		inner join room on (hotel.hotel_no=room.hotel_no)
where 
		(room.hotel_no, room.room_no) 
		NOT IN
			(select  room.hotel_no,room.room_no
				from 
					hotel 
						inner join room on hotel.hotel_no=room.hotel_no
							inner join booking on (booking.room_no=room.room_no and booking.hotel_no=room.hotel_no)
				where CURDATE() between booking.date_from and booking.date_to  
			)
	group by hotel.hotel_no
;


