use crowdfunding;

-- Total Number of Projects
SELECT 
    CONCAT(ROUND(COUNT(id) / 1000, 1), 'K') AS 'TOTAL PROJECTS'
FROM
    Projects;
    
/*# TOTAL PROJECTS
365.9K
*/

  
-- Total Number of Projects based on outcome.
SELECT 
    state, CONCAT(ROUND(COUNT(*)/1000,3), "K") AS 'Projects Based On Outcome'
FROM
    projects
GROUP BY state WITH rollup;

/*
# state, Projects Based On Outcome
canceled, 32.498K
failed, 188.239K
live, 3.163K
purged, 0.178K
successful, 140.313K
suspended, 1.501K
Total, 365.892K
*/

-- Total Number of Projects based on Locations
SELECT 
    country AS LOCATION,
    CONCAT(ROUND(COUNT(*)/1000,3), "K") AS 'Projects Based On Locations'
FROM
    projects
GROUP BY country WITH rollup
ORDER BY 'Projects Based On Locations' DESC;

/*# LOCATION	Projects Based On Locations
AT	0.697K
AU	7.757K
BE	0.724K
CA	14.774K
CH	0.883K
DE	4.714K
DK	1.173K
ES	2.737K
FR	3.532K
GB	34.074K
HK	1.227K
IE	0.877K
IT	3.374K
JP	0.308K
LU	0.068K
MX	2.677K
NL	2.836K
NO	0.682K
NZ	1.454K
SE	1.905K
SG	0.895K
US	278.524K
Total	365.892K
*/

--  Total Number of Projects based on  Category
SELECT 
    c.name AS Category,
    CONCAT(ROUND(COUNT(p.category_id)/1000,1), 'K') AS 'Number of Projects'
FROM
    category c
        INNER JOIN
    projects p ON c.id = p.category_id
GROUP BY c.name WITH rollup
ORDER BY 'Number of Projects' DESC LIMIT 10;

/*# Category	Number of Projects
3D Printing	0.7K
Academic	1.0K
Accessories	4.2K
Action	0.8K
Animals	0.3K
Animation	2.5K
Anthologies	1.0K
Apparel	7.5K
Apps	6.5K
Architecture	0.8K
*/


/*Total Number of projects created by Year, Quarter, Month
I. Total Number of projects created by Year.*/
SELECT 
    Year(created_date) AS Year,
    CONCAT(ROUND(COUNT(name)/1000,1), 'K') AS 'Number of Projects'
FROM projects 
GROUP BY 
    Year WITH rollup
ORDER BY 
    Year;
/*# Year	Number of Projects
Total 	365.9K
2009	1.3K
2010	9.8K
2011	24.4K
2012	39.2K
2013	41.6K
2014	59.2K
2015	58.1K
2016	46.2K
2017	47.3K
2018	37.4K
2019	1.5K
*/
    
-- II. Total Number of Projects Created by Year and Quarter   
SELECT 
    Year(created_date) AS Year,
    quarter(created_date) AS Quarter,
    COUNT(name) AS 'Number of Projects'
FROM projects 
GROUP BY 
    Year, quarter
ORDER BY 
    Year;
/*# Year	Quarter	Number of Projects
2009	2	172
2009	3	514
2009	4	624
2010	1	1131
2010	2	2391
2010	3	2824
2010	4	3489
2011	1	5163
2011	2	6345
2011	3	6086
2011	4	6765
2012	1	10931
2012	2	10924
2012	3	9347
2012	4	8014
2013	1	10338
2013	2	10908
2013	3	10253
2013	4	10057
2014	1	11667
2014	2	12681
2014	3	21804
2014	4	13003
2015	1	17016
2015	2	15321
2015	3	14178
2015	4	11589
2016	1	12811
2016	2	12082
2016	3	11263
2016	4	10002
2017	1	12623
2017	2	12505
2017	3	11801
2017	4	10341
2018	1	10182
2018	2	9437
2018	3	9986
2018	4	7805
2019	1	1519
*/
-- III. Total Number of Projects created by Year, Quarter and Month
SELECT 
    YEAR(created_date) AS Year,
    CONCAT('Q-', QUARTER(created_date)) AS Quarter,
    MONTH(created_date) AS MonthNumber,
    MONTHNAME(created_date) AS Month,
    COUNT(name) AS 'Number of Projects'
FROM
    projects
GROUP BY YEAR(created_date) , CONCAT('Q-', QUARTER(created_date)) , MONTH(created_date) , MONTHNAME(created_date)
ORDER BY YEAR(created_date) , MONTH(created_date);

/*# Year	Quarter	MonthNumber	Month	Number of Projects
2009	Q-2	4	April	27
2009	Q-2	5	May	69
2009	Q-2	6	June	76
2009	Q-3	7	July	86
2009	Q-3	8	August	124
2009	Q-3	9	September	304
2009	Q-4	10	October	200
2009	Q-4	11	November	228
2009	Q-4	12	December	196
2010	Q-1	1	January	284
2010	Q-1	2	February	342
2010	Q-1	3	March	505
2010	Q-2	4	April	667
2010	Q-2	5	May	737
2010	Q-2	6	June	987
2010	Q-3	7	July	967
2010	Q-3	8	August	835
2010	Q-3	9	September	1022
2010	Q-4	10	October	1126
2010	Q-4	11	November	1156
2010	Q-4	12	December	1207
2011	Q-1	1	January	1483
2011	Q-1	2	February	1714
2011	Q-1	3	March	1966
2011	Q-2	4	April	2040
2011	Q-2	5	May	2106
2011	Q-2	6	June	2199
2011	Q-3	7	July	2036
2011	Q-3	8	August	2084
2011	Q-3	9	September	1966
2011	Q-4	10	October	2137
2011	Q-4	11	November	2451
2011	Q-4	12	December	2177
2012	Q-1	1	January	3012
2012	Q-1	2	February	3348
2012	Q-1	3	March	4571
2012	Q-2	4	April	3763
2012	Q-2	5	May	3875
2012	Q-2	6	June	3286
2012	Q-3	7	July	3311
2012	Q-3	8	August	3121
2012	Q-3	9	September	2915
2012	Q-4	10	October	3039
2012	Q-4	11	November	2674
2012	Q-4	12	December	2301
2013	Q-1	1	January	3448
2013	Q-1	2	February	3131
2013	Q-1	3	March	3759
2013	Q-2	4	April	3703
2013	Q-2	5	May	3838
2013	Q-2	6	June	3367
2013	Q-3	7	July	3412
2013	Q-3	8	August	3473
2013	Q-3	9	September	3368
2013	Q-4	10	October	3788
2013	Q-4	11	November	3535
2013	Q-4	12	December	2734
2014	Q-1	1	January	3852
2014	Q-1	2	February	3552
2014	Q-1	3	March	4263
2014	Q-2	4	April	4294
2014	Q-2	5	May	4144
2014	Q-2	6	June	4243
2014	Q-3	7	July	10425
2014	Q-3	8	August	6106
2014	Q-3	9	September	5273
2014	Q-4	10	October	5455
2014	Q-4	11	November	4522
2014	Q-4	12	December	3026
2015	Q-1	1	January	5204
2015	Q-1	2	February	5571
2015	Q-1	3	March	6241
2015	Q-2	4	April	5130
2015	Q-2	5	May	5303
2015	Q-2	6	June	4888
2015	Q-3	7	July	4889
2015	Q-3	8	August	4741
2015	Q-3	9	September	4548
2015	Q-4	10	October	4645
2015	Q-4	11	November	3894
2015	Q-4	12	December	3050
2016	Q-1	1	January	4207
2016	Q-1	2	February	4237
2016	Q-1	3	March	4367
2016	Q-2	4	April	4023
2016	Q-2	5	May	4272
2016	Q-2	6	June	3787
2016	Q-3	7	July	3742
2016	Q-3	8	August	3740
2016	Q-3	9	September	3781
2016	Q-4	10	October	3571
2016	Q-4	11	November	3556
2016	Q-4	12	December	2875
2017	Q-1	1	January	4223
2017	Q-1	2	February	3819
2017	Q-1	3	March	4581
2017	Q-2	4	April	4085
2017	Q-2	5	May	4445
2017	Q-2	6	June	3975
2017	Q-3	7	July	3964
2017	Q-3	8	August	4057
2017	Q-3	9	September	3780
2017	Q-4	10	October	4022
2017	Q-4	11	November	3632
2017	Q-4	12	December	2687
2018	Q-1	1	January	3929
2018	Q-1	2	February	3100
2018	Q-1	3	March	3153
2018	Q-2	4	April	3207
2018	Q-2	5	May	3298
2018	Q-2	6	June	2932
2018	Q-3	7	July	3269
2018	Q-3	8	August	3405
2018	Q-3	9	September	3312
2018	Q-4	10	October	3403
2018	Q-4	11	November	2668
2018	Q-4	12	December	1734
2019	Q-1	1	January	1519
*/

-- SUCCESSFUL PROJECTS
SELECT 
    CONCAT(ROUND(COUNT(*) / 1000, 1), 'K') AS 'TOTAL SUCCESSFUL PROJECTS'
FROM
    PROJECTS
WHERE
    state = 'successful';
/*# TOTAL SUCCESSFUL PROJECTS
140.3K
*/

-- AMOUNT RAISED BY SUCCESSFUL PROJECTS--
SELECT 
    CONCAT(ROUND(COUNT(*) / 1000, 1), 'K') AS 'Total Number of Successful Projects',
    CONCAT(ROUND(SUM(USD_Pledged) / 1000000, 1),
            'M') AS 'Amount Raised'
FROM
    projects
WHERE
    state = 'successful';
/*# Total Number of Successful Projects	Amount Raised
140.3K	3479.5M
*/

-- Number of Backers by Successful Projects --
SELECT 
    CONCAT(ROUND(COUNT(*) / 1000, 1), 'K') AS 'Total Number of Successful Projects',
    CONCAT(ROUND(SUM(Backers_count) / 1000000),
            'M') AS 'Number of Backers'
FROM
    projects
WHERE
    state = 'successful';
/*# Total Number of Successful Projects	Number of Backers
140.3K	40M
*/

-- Average number of days for successful Projects --
SELECT 
    CONCAT(ROUND(COUNT(*) / 1000, 1), 'K') AS 'Total Number of Successful Projects',
    CONCAT(ROUND(AVG(datediff(Successful_Date, Created_Date)), 1), ' Days') AS 'Average Days'
FROM
    projects
WHERE
    state = 'successful';
/*# Total Number of Successful Projects	Average Days
140.3K	80.4 Days
*/
 
-- Successful projects based on Number of Backers
SELECT 
    name AS 'Project_Name',
    CONCAT(ROUND(backers_count / 1000, 1), 'K') AS 'Number of Backers'
FROM
    projects
WHERE
    state = 'successful'
ORDER BY backers_count DESC
LIMIT 10;

/*
# Project_Name	Number of Backers
Exploding Kittens	219.4K
Fidget Cube: A Vinyl Desk Toy	154.9K
Bring Reading Rainbow Back for Every Child, Everywhere!	105.9K
The Veronica Mars Movie Project	91.6K
Double Fine Adventure	87.1K
Bears vs Babies - A Card Game	85.6K
Pebble Time - Awesome Smartwatch, No Compromises	78.5K
Torment: Tides of Numenera	74.4K
Project Eternity	74.0K
Yooka-Laylee - A 3D Platformer Rare-vival!	73.2K

*/
-- Successful projects based on amount raised
SELECT 
    name AS 'Project_Name',
    CONCAT('$', ROUND(SUM(usd_pledged)/1000000, 1), 'M') AS 'Amount Raised'
FROM
    projects
WHERE
    state = 'successful'
group by name 
ORDER BY sum(usd_pledged) DESC
LIMIT 10;
/*
# Project_Name	Amount Raised
Pebble Time - Awesome Smartwatch, No Compromises	$20.3M
COOLEST COOLER: 21st Century Cooler that's Actually Cooler	$13.3M
Pebble 2, Time 2 + All-New Pebble Core	$12.8M
Kingdom Death: Monster 1.5	$12.4M
Pebble: E-Paper Watch for iPhone and Android	$10.3M
The World's Best TRAVEL JACKET with 15 Features || BAUBAX	$9.2M
Exploding Kittens	$8.8M
OUYA: A New Kind of Video Game Console	$8.6M
THE 7th CONTINENT – What Goes Up, Must Come Down.	$7.1M
The Everyday Backpack, Tote, and Sling	$6.6M
*/

-- Percentage of successful projects (overall)
SELECT CONCAT(ROUND((sum(state = 'successful')/COUNT(ID)) * 100, 2), '%'
) AS 'Success Percentage' from PROJECTS;
/*
# Success Percentage
38.35%
*/

-- TOP 10 CATEGORIES BY SUCCESSFUL PROJECTS
SELECT 
    c.name AS `Category Name`,
    CONCAT(ROUND(SUM(p.state = 'successful') / 1000, 2), 'K') AS `Successful Projects`
FROM category c
LEFT JOIN projects p
    ON c.id = p.category_id
GROUP BY c.name
ORDER BY SUM(p.state = 'successful') DESC LIMIT 10;
/*
# Category Name	Successful Projects
Tabletop Games	9.75K
Product Design	9.32K
Music	8.00K
Shorts	6.15K
Documentary	5.60K
Theater	3.93K
Art	3.66K
Indie Rock	3.31K
Rock	3.17K
Food	3.05K
*/

-- Percentage of successful projects by year, month, etc.
-- I. Percentage of successful projects by year.
SELECT 
    YEAR(created_date) AS Year,
    CONCAT(ROUND(SUM(state = 'successful') / COUNT(id) * 100,
                    2),
            '%') AS 'Success Percentage'
FROM
    projects
GROUP BY 1
ORDER BY 1;
/*# Year	Success Percentage
2009	43.97%
2010	43.46%
2011	45.40%
2012	43.12%
2013	43.32%
2014	32.56%
2015	31.60%
2016	35.92%
2017	39.53%
2018	44.25%
2019	3.09%
*/

-- II. Percentage of successful projects by month.
SELECT 
    YEAR(created_date) AS Year,
    MONTH(created_date) AS month,
    MONTHNAME(created_date) AS monthname,
    CONCAT(ROUND(SUM(state = 'successful') / COUNT(id) * 100,
                    2),
            '%') as 'success percentage'
FROM
    projects
GROUP BY YEAR(created_date) , MONTH(created_date) , MONTHNAME(created_date)
ORDER BY YEAR;

/*
2009	4	April	62.96%
2009	5	May	37.68%
2009	6	June	47.37%
2009	7	July	43.02%
2009	8	August	48.39%
2009	9	September	36.18%
2009	10	October	44.00%
2009	11	November	49.12%
2009	12	December	45.92%
2010	1	January	45.07%
2010	2	February	48.83%
2010	3	March	49.31%
2010	4	April	40.18%
2010	5	May	40.98%
2010	6	June	37.89%
2010	7	July	40.85%
2010	8	August	41.68%
2010	9	September	45.60%
2010	10	October	46.63%
2010	11	November	44.90%
2010	12	December	44.16%
2011	1	January	44.64%
2011	2	February	47.20%
2011	3	March	48.63%
2011	4	April	46.47%
2011	5	May	44.82%
2011	6	June	46.93%
2011	7	July	45.58%
2011	8	August	43.43%
2011	9	September	47.61%
2011	10	October	46.28%
2011	11	November	42.47%
2011	12	December	41.80%
2012	1	January	43.23%
2012	2	February	47.07%
2012	3	March	42.97%
2012	4	April	42.94%
2012	5	May	42.40%
2012	6	June	43.49%
2012	7	July	42.43%
2012	8	August	41.91%
2012	9	September	41.58%
2012	10	October	42.68%
2012	11	November	43.61%
2012	12	December	43.16%
2013	1	January	46.14%
2013	2	February	48.00%
2013	3	March	45.68%
2013	4	April	45.42%
2013	5	May	42.76%
2013	6	June	42.29%
2013	7	July	43.70%
2013	8	August	41.00%
2013	9	September	41.83%
2013	10	October	40.63%
2013	11	November	41.67%
2013	12	December	40.60%
2014	1	January	41.95%
2014	2	February	44.26%
2014	3	March	40.49%
2014	4	April	39.61%
2014	5	May	38.71%
2014	6	June	33.23%
2014	7	July	20.63%
2014	8	August	27.78%
2014	9	September	31.65%
2014	10	October	30.89%
2014	11	November	30.98%
2014	12	December	34.01%
2015	1	January	33.30%
2015	2	February	31.68%
2015	3	March	31.65%
2015	4	April	32.11%
2015	5	May	31.47%
2015	6	June	30.28%
2015	7	July	29.99%
2015	8	August	30.65%
2015	9	September	31.93%
2015	10	October	33.63%
2015	11	November	32.20%
2015	12	December	29.70%
2016	1	January	33.25%
2016	2	February	34.27%
2016	3	March	35.29%
2016	4	April	35.47%
2016	5	May	35.58%
2016	6	June	34.51%
2016	7	July	35.17%
2016	8	August	37.73%
2016	9	September	39.06%
2016	10	October	39.68%
2016	11	November	36.39%
2016	12	December	35.48%
2017	1	January	41.18%
2017	2	February	40.59%
2017	3	March	40.73%
2017	4	April	37.04%
2017	5	May	38.02%
2017	6	June	37.76%
2017	7	July	38.70%
2017	8	August	39.66%
2017	9	September	40.87%
2017	10	October	40.80%
2017	11	November	38.68%
2017	12	December	40.64%
2018	1	January	45.61%
2018	2	February	49.16%
2018	3	March	50.30%
2018	4	April	47.18%
2018	5	May	47.60%
2018	6	June	47.68%
2018	7	July	45.12%
2018	8	August	44.14%
2018	9	September	45.23%
2018	10	October	42.17%
2018	11	November	35.08%
2018	12	December	18.63%
2019	1	January	3.09%
*/

-- III. Percentage of successful projects by year, quarter, month.
SELECT 
    YEAR(created_date) AS Year,
    CONCAT('Q-', QUARTER(created_date)) AS quarter,
    MONTH(created_date) AS month,
    MONTHNAME(created_date) AS monthname,
    CONCAT(ROUND(SUM(state = 'successful') / COUNT(id) * 100,
                    2),
            '%') AS 'Monthly percentage successful projects'
FROM
    projects
GROUP BY YEAR(created_date) , CONCAT('Q-', QUARTER(created_date)) , MONTH(created_date) , MONTHNAME(created_date)
ORDER BY YEAR;
/*
# Year	quarter	month	monthname	Monthly percentage successful projects
2009	Q-2	4	April	62.96%
2009	Q-2	5	May	37.68%
2009	Q-2	6	June	47.37%
2009	Q-3	7	July	43.02%
2009	Q-3	8	August	48.39%
2009	Q-3	9	September	36.18%
2009	Q-4	10	October	44.00%
2009	Q-4	11	November	49.12%
2009	Q-4	12	December	45.92%
2010	Q-1	1	January	45.07%
2010	Q-1	2	February	48.83%
2010	Q-1	3	March	49.31%
2010	Q-2	4	April	40.18%
2010	Q-2	5	May	40.98%
2010	Q-2	6	June	37.89%
2010	Q-3	7	July	40.85%
2010	Q-3	8	August	41.68%
2010	Q-3	9	September	45.60%
2010	Q-4	10	October	46.63%
2010	Q-4	11	November	44.90%
2010	Q-4	12	December	44.16%
2011	Q-1	1	January	44.64%
2011	Q-1	2	February	47.20%
2011	Q-1	3	March	48.63%
2011	Q-2	4	April	46.47%
2011	Q-2	5	May	44.82%
2011	Q-2	6	June	46.93%
2011	Q-3	7	July	45.58%
2011	Q-3	8	August	43.43%
2011	Q-3	9	September	47.61%
2011	Q-4	10	October	46.28%
2011	Q-4	11	November	42.47%
2011	Q-4	12	December	41.80%
2012	Q-1	1	January	43.23%
2012	Q-1	2	February	47.07%
2012	Q-1	3	March	42.97%
2012	Q-2	4	April	42.94%
2012	Q-2	5	May	42.40%
2012	Q-2	6	June	43.49%
2012	Q-3	7	July	42.43%
2012	Q-3	8	August	41.91%
2012	Q-3	9	September	41.58%
2012	Q-4	10	October	42.68%
2012	Q-4	11	November	43.61%
2012	Q-4	12	December	43.16%
2013	Q-1	1	January	46.14%
2013	Q-1	2	February	48.00%
2013	Q-1	3	March	45.68%
2013	Q-2	4	April	45.42%
2013	Q-2	5	May	42.76%
2013	Q-2	6	June	42.29%
2013	Q-3	7	July	43.70%
2013	Q-3	8	August	41.00%
2013	Q-3	9	September	41.83%
2013	Q-4	10	October	40.63%
2013	Q-4	11	November	41.67%
2013	Q-4	12	December	40.60%
2014	Q-1	1	January	41.95%
2014	Q-1	2	February	44.26%
2014	Q-1	3	March	40.49%
2014	Q-2	4	April	39.61%
2014	Q-2	5	May	38.71%
2014	Q-2	6	June	33.23%
2014	Q-3	7	July	20.63%
2014	Q-3	8	August	27.78%
2014	Q-3	9	September	31.65%
2014	Q-4	10	October	30.89%
2014	Q-4	11	November	30.98%
2014	Q-4	12	December	34.01%
2015	Q-1	1	January	33.30%
2015	Q-1	2	February	31.68%
2015	Q-1	3	March	31.65%
2015	Q-2	4	April	32.11%
2015	Q-2	5	May	31.47%
2015	Q-2	6	June	30.28%
2015	Q-3	7	July	29.99%
2015	Q-3	8	August	30.65%
2015	Q-3	9	September	31.93%
2015	Q-4	10	October	33.63%
2015	Q-4	11	November	32.20%
2015	Q-4	12	December	29.70%
2016	Q-1	1	January	33.25%
2016	Q-1	2	February	34.27%
2016	Q-1	3	March	35.29%
2016	Q-2	4	April	35.47%
2016	Q-2	5	May	35.58%
2016	Q-2	6	June	34.51%
2016	Q-3	7	July	35.17%
2016	Q-3	8	August	37.73%
2016	Q-3	9	September	39.06%
2016	Q-4	10	October	39.68%
2016	Q-4	11	November	36.39%
2016	Q-4	12	December	35.48%
2017	Q-1	1	January	41.18%
2017	Q-1	2	February	40.59%
2017	Q-1	3	March	40.73%
2017	Q-2	4	April	37.04%
2017	Q-2	5	May	38.02%
2017	Q-2	6	June	37.76%
2017	Q-3	7	July	38.70%
2017	Q-3	8	August	39.66%
2017	Q-3	9	September	40.87%
2017	Q-4	10	October	40.80%
2017	Q-4	11	November	38.68%
2017	Q-4	12	December	40.64%
2018	Q-1	1	January	45.61%
2018	Q-1	2	February	49.16%
2018	Q-1	3	March	50.30%
2018	Q-2	4	April	47.18%
2018	Q-2	5	May	47.60%
2018	Q-2	6	June	47.68%
2018	Q-3	7	July	45.12%
2018	Q-3	8	August	44.14%
2018	Q-3	9	September	45.23%
2018	Q-4	10	October	42.17%
2018	Q-4	11	November	35.08%
2018	Q-4	12	December	18.63%
2019	Q-1	1	January	3.09%
*/


-- IV. QUARTER-WISE PERCENTAGE OF SUCCESSFUL PROJECTS
SELECT 
    YEAR(created_date) AS Year,
    CONCAT('Q-', QUARTER(created_date)) AS quarter,
        CONCAT(ROUND(SUM(state = 'successful') / COUNT(id) * 100,
                    2),
            '%') AS 'Quarterly percentage successful projects'
FROM
    projects
GROUP BY YEAR(created_date) , CONCAT('Q-', QUARTER(created_date)) 
ORDER BY YEAR(created_date);

/*# Year	quarter	Quarterly percentage successful projects
2009	Q-2	45.93%
2009	Q-3	40.27%
2009	Q-4	46.47%
2010	Q-1	48.10%
2010	Q-2	39.48%
2010	Q-3	42.81%
2010	Q-4	45.20%
2011	Q-1	47.01%
2011	Q-2	46.08%
2011	Q-3	45.50%
2011	Q-4	43.46%
2012	Q-1	44.30%
2012	Q-2	42.91%
2012	Q-3	41.99%
2012	Q-4	43.12%
2013	Q-1	46.54%
2013	Q-2	43.52%
2013	Q-3	42.17%
2013	Q-4	40.99%
2014	Q-1	42.12%
2014	Q-2	37.18%
2014	Q-3	25.30%
2014	Q-4	31.65%
2015	Q-1	32.16%
2015	Q-2	31.30%
2015	Q-3	30.83%
2015	Q-4	32.12%
2016	Q-1	34.28%
2016	Q-2	35.21%
2016	Q-3	37.33%
2016	Q-4	37.30%
2017	Q-1	40.84%
2017	Q-2	37.62%
2017	Q-3	39.73%
2017	Q-4	40.02%
2018	Q-1	48.14%
2018	Q-2	47.48%
2018	Q-3	44.82%
2018	Q-4	34.52%
2019	Q-1	3.09%
*/

/* Percentage of Successful projects by Goal Range ( decide the range as per your need )
Small (0-5K), Medium (5K-20K), Large (20K-50K), Very Large (50K-100K) and Mega (>100K) */

SELECT 
    CASE
        WHEN Goal_USD BETWEEN 0 AND 5000 THEN 'Small'
        WHEN goal_usd BETWEEN 5001 AND 20000 THEN 'Medium'
        WHEN goal_usd BETWEEN 20001 AND 50000 THEN 'Large'
        WHEN goal_usd BETWEEN 50001 AND 100000 THEN 'Very Large'
        ELSE 'Mega'
    END AS Goal_Range,
    COUNT(id) AS Total_Projects,
    SUM(state = 'successful') AS Total_successful_projects,
    CONCAT(ROUND(SUM(state = 'successful') / COUNT(id) * 100,
                    0),
            '%') AS Successful_percentage
FROM
    projects
GROUP BY goal_range;

/*
# Goal_Range	Total_Projects	Total_successful_projects	Successful_percentage
Very Large		15264			2372						16%
Medium			112660			40456						36%
Small			181468			85648						47%
Large			44168			11055						25%
Mega			12332			782							6%
*/

