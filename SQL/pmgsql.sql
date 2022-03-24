/* creating tables in the pmgchallenge database */
create table store_revenue(
	id INT IDENTITY(1,1), 
	date DATETIME, 
	brand_id int, 
	store_location varchar(250), 
	revenue float,
	CONSTRAINT PK_STORE_REVENUE_ID PRIMARY KEY (id)
)

create table marketing_data (
	id int IDENTITY(1,1), 
	date datetime, 
	geo varchar(2), 
	impressions float, 
	clicks float,
	CONSTRAINT PK_MARKET_DATE_ID PRIMARY KEY (id)
) 
/* Inserting values into the tables*/
INSERT INTO store_revenue VALUES
('01-01-2016','1','United States-CA','100'),
('01-01-2016','1','United States-TX','420'),
('01-01-2016','1','United States-NY','142'),
('02-01-2016','1','United States-CA','231'),
('02-01-2016','1','United States-TX','2342'),
('02-01-2016','1','United States-NY','232'),
('03-01-2016','1','United States-CA','100'),
('03-01-2016','1','United States-TX','420'),
('03-01-2016','1','United States-NY','3245'),
('04-01-2016','1','United States-CA','34'),
('04-01-2016','1','United States-TX','3'),
('04-01-2016','1','United States-NY','54'),
('05-01-2016','1','United States-CA','45'),
('05-01-2016','1','United States-TX','423'),
('05-01-2016','1','United States-NY','234'),
('01-01-2016','2','United States-CA','234'),
('01-01-2016','2','United States-TX','234'),
('01-01-2016','2','United States-NY','142'),
('02-01-2016','2','United States-CA','234'),
('02-01-2016','2','United States-TX','3423'),
('02-01-2016','2','United States-NY','2342'),
('03-01-2016','2','United States-CA','234234'),
('06-01-2016','3','United States-TX','3'),
('03-01-2016','2','United States-TX','3'),
('03-01-2016','2','United States-NY','234'),
('04-01-2016','2','United States-CA','2'),
('04-01-2016','2','United States-TX','2354'),
('04-01-2016','2','United States-NY','45235'),
('05-01-2016','2','United States-CA','23'),
('05-01-2016','2','United States-TX','4'),
('05-01-2016','2','United States-NY','124');

INSERT INTO marketing_data VALUES
	('01-01-2016','TX','2532','45'),
('01-01-2016','CA','3425','63'),
('01-01-2016','NY','3532','25'),
('01-01-2016','MN','1342','784'),
('02-01-2016','TX','3643','23'),
('02-01-2016','CA','1354','53'),
('02-01-2016','NY','4643','85'),
('02-01-2016','MN','2366','85'),
('03-01-2016','TX','2353','57'),
('03-01-2016','CA','5258','36'),
('03-01-2016','NY','4735','63'),
('03-01-2016','MN','5783','87'),
('04-01-2016','TX','5783','47'),
('04-01-2016','CA','7854','85'),
('04-01-2016','NY','4754','36'),
('04-01-2016','MN','9345','24'),
('05-01-2016','TX','2535','63'),
('05-01-2016','CA','4678','73'),
('05-01-2016','NY','2364','33'),
('05-01-2016','MN','3452','25');

/*Question #1 Generate a query to get the sum of the clicks of the marketing data​*/

SELECT SUM(md.clicks) as SUM_OF_CLICKS
FROM marketing_data md


/*Question #2 Generate a query to gather the sum of revenue by geo from the store_revenue table​*/

SELECT sr.store_location,SUM(sr.revenue) AS SUM_OF_REVENUE
FROM store_revenue sr
GROUP BY sr.store_location

/*Question #3 Merge these two datasets so we can see impressions, clicks, and revenue together by date and geo. Please ensure all records from each table are accounted for.​*/

SELECT *
FROM store_revenue sr
FULL OUTER JOIN marketing_data md 
ON md.geo = RIGHT(sr.store_location,2) AND md.date = sr.date

/*Question #4 In your opinion, what is the most efficient store and why?​*/

SELECT sr.brand_id,md.geo,AVG(md.clicks) AS AVG_CLICKS,AVG(md.impressions) AS AVG_IMPRESSIONS,AVG(sr.revenue) AS AVG_REVENUE,
AVG(md.clicks+md.impressions+sr.revenue) as Avg_net_efficiency
FROM store_revenue sr
FULL OUTER JOIN marketing_data md 
ON md.geo = RIGHT(sr.store_location,2) AND md.date = sr.date
GROUP BY sr.brand_id,md.geo
ORDER BY Avg_net_efficiency DESC
/* When considering the avg values of Clicks,Impressions and Revenue across all the dates we observe that
   For Barnd 2 the most effecienct store is in state of California and for brand 1 it is New York  */
   
/*Question #5 (Challenge) Generate a query to rank in order the top 10 revenue producing states​*/

select TOP(10) sr.store_location,sr.revenue
FROM store_revenue sr
ORDER BY sr.revenue DESC


