SELECT*
FROM bright_tv_user_profiles;
----------------------

SELECT DISTINCT gender
FROM bright_tv_user_profiles;


SELECT DISTINCT 
    CASE 
        WHEN gender IS NULL THEN 'Unknown'
        WHEN gender = 'None' THEN 'Unknown'
        ELSE gender
    END AS gender
FROM bright_tv_user_profiles;
-----------------------------
SELECT DISTINCT province
FROM bright_tv_user_profiles;

SELECT DISTINCT 
    CASE 
        WHEN province IS NULL THEN 'Unknown'
        WHEN province = 'None' THEN 'Unknown' 
        ELSE province
    END AS province
FROM bright_tv_user_profiles;
-----------------------------
SELECT DISTINCT race
FROM bright_tv_user_profiles;

SELECT DISTINCT 
    CASE 
        WHEN race IS NULL THEN 'Unknown'
        WHEN race = 'None' THEN 'Unknown'
        ELSE race
    END AS race
FROM bright_tv_user_profiles;
-------------------------------
SELECT DISTINCT age
FROM bright_tv_user_profiles
WHERE age IS NULL;
-------------------------------
SELECT COUNT(*) AS row_count,
            userid
FROM bright_tv_user_profiles
GROUP BY userid
HAVING COUNT(*) > 1;
------------------------------
CREATE OR REPLACE TEMPORARY VIEW users AS
SELECT
    UserID AS userid,
    Age AS age,
    CASE 
        WHEN Age < 1 THEN '01. Infant'
        WHEN Age BETWEEN 1 AND 12 THEN '02. Child'
        WHEN Age BETWEEN 13 AND 17 THEN '03. Junior'
        WHEN Age BETWEEN 18 AND 24 THEN '04. Youth'
        WHEN Age BETWEEN 25 AND 35 THEN '05. Adult'
        ELSE '06. Senior'
    END AS age_group,   
    CASE
        WHEN Gender IS NULL THEN 'unknown'
        WHEN Gender = 'None' THEN 'unknown'
        ELSE Gender
    END AS gender,
    CASE
        WHEN Race IS NULL THEN 'unknown'
        WHEN Race IN ('None', 'other') THEN 'unknown'
        ELSE Race
    END AS race,
    CASE
        WHEN Province IS NULL THEN 'unknown'
        WHEN Province = 'None' THEN 'unknown'
        ELSE Province
    END AS province
FROM workspace.default.bright_tv_user_profiles;

SELECT*
FROM users;

------------------------------------------------

SELECT*FROM bright_tv_viewership;

SELECT COUNT(*) 
FROM bright_tv_viewership;

SELECT USERID,
       userid
FROM bright_tv_viewership
WHERE userid IS NULL;  

-------------------------------------------------

SELECT
  COALESCE(USERID, userid) AS userid,
  channel2,
  try_to_timestamp(recorddate2,'M/d/yy H:mm') AS recorddate2_ts,
  TO_DATE(try_to_timestamp(recorddate2,'M/d/yy H:mm')) AS watch_date,
  DAYNAME(try_to_timestamp(recorddate2,'M/d/yy H:mm')) AS day_name,
  CASE
    WHEN DAYNAME(try_to_timestamp(recorddate2,'M/d/yy H:mm')) NOT IN ('Sat', 'Sun') THEN 'weekday'
    ELSE 'weekend'
  END AS day_of_week_classification,
  date_format(try_to_timestamp(recorddate2,'M/d/yy H:mm'),'MMMM') AS month_name,
  date_format(try_to_timestamp(recorddate2,'M/d/yy H:mm'),'HH:mm:ss') AS watch_starting_time,
  `Duration 2`
FROM bright_tv_viewership;

SELECT *
FROM bright_tv_viewership AS A
LEFT JOIN users AS B ON A.userid = B.userid;
---------------------------------------------------------------
CREATE OR REPLACE TEMPORARY VIEW users AS
SELECT
    UserID AS userid,
    Age AS age,
    CASE 
        WHEN Age < 1 THEN '01. Infant'
        WHEN Age BETWEEN 1 AND 12 THEN '02. Child'
        WHEN Age BETWEEN 13 AND 17 THEN '03. Junior'
        WHEN Age BETWEEN 18 AND 24 THEN '04. Youth'
        WHEN Age BETWEEN 25 AND 35 THEN '05. Adult'
        ELSE '06. Senior'
    END AS age_group,   
    CASE
        WHEN Gender IS NULL THEN 'unknown'
        WHEN Gender = 'None' THEN 'unknown'
        ELSE Gender
    END AS gender,
    CASE
        WHEN Race IS NULL THEN 'unknown'
        WHEN Race IN ('None', 'other') THEN 'unknown'
        ELSE Race
    END AS race,
    CASE
        WHEN Province IS NULL THEN 'unknown'
        WHEN Province = 'None' THEN 'unknown'
        ELSE Province
    END AS province
FROM workspace.default.bright_tv_user_profiles;

SELECT*
FROM users;

SELECT
  COALESCE(USERID, userid) AS userid,
  channel2,
  try_to_timestamp(recorddate2,'M/d/yy H:mm') AS recorddate2_ts,
  TO_DATE(try_to_timestamp(recorddate2,'M/d/yy H:mm')) AS watch_date,
  DAYNAME(try_to_timestamp(recorddate2,'M/d/yy H:mm')) AS day_name,
  CASE
    WHEN DAYNAME(try_to_timestamp(recorddate2,'M/d/yy H:mm')) NOT IN ('Sat', 'Sun') THEN 'weekday'
    ELSE 'weekend'
  END AS day_of_week_classification,
  date_format(try_to_timestamp(recorddate2,'M/d/yy H:mm'),'MMMM') AS month_name,
  date_format(try_to_timestamp(recorddate2,'M/d/yy H:mm'),'HH:mm:ss') AS watch_starting_time,
  `Duration 2`
FROM bright_tv_viewership;

SELECT
  A.UserID AS userid,
  A.Channel2,
  A.RecordDate2,
  A.`Duration 2`,
  B.age,
  B.age_group,
  B.gender,
  B.race,
  B.province,
  TO_DATE(try_to_timestamp(A.RecordDate2, 'M/d/yy H:mm')) AS watch_date,
  DAYNAME(try_to_timestamp(A.RecordDate2, 'M/d/yy H:mm')) AS day_name,
  CASE
    WHEN DAYNAME(try_to_timestamp(A.RecordDate2, 'M/d/yy H:mm')) NOT IN ('Sat', 'Sun') THEN 'weekday'
    ELSE 'weekend'
  END AS day_of_week_classification,
  date_format(try_to_timestamp(A.RecordDate2, 'M/d/yy H:mm'), 'MMMM') AS month_name,
  date_format(try_to_timestamp(A.RecordDate2, 'M/d/yy H:mm'), 'HH:mm:ss') AS watch_starting_time
FROM bright_tv_viewership AS A
LEFT JOIN users AS B ON A.UserID = B.userid;



  

