-- Cleaning Levis Ecommerce Marketing Dataset

-- Step 1. Take a Look the Dataset

-- look at the columns of the dataset and their data types
DESCRIBE levis_ecommerce_marketing_data;

-- look at the first ten rows of the dataset
SELECT *
FROM levis_ecommerce_marketing_data
LIMIT 10;

-- Step 2. Remove Duplicates If They Exist

-- check for duplicates
SELECT *, COUNT(*) AS number_of_duplicates
FROM levis_ecommerce_marketing_data
GROUP BY `date`, channel, campaign, region, gender, account_status, impressions, clicks, conversions, sign_ups, emails_sent, emails_opened, total_ad_spend
HAVING number_of_duplicates > 1;

-- Step 3. Check for Missing Values and Inconsistencies

-- check for nulls or blanks in each column
SELECT
    SUM(`date` IS NULL) AS nulls_in_date,
    SUM(`date` = '') AS blanks_in_date,

    SUM(`channel` IS NULL) AS nulls_in_channel,
    SUM(`channel` = '') AS blanks_in_channel,

    SUM(`campaign` IS NULL) AS nulls_in_campaign,
    SUM(`campaign` = '') AS blanks_in_campaign,

    SUM(`region` IS NULL) AS nulls_in_region,
    SUM(`region` = '') AS blanks_in_region,

    SUM(`gender` IS NULL) AS nulls_in_gender,
    SUM(`gender` = '') AS blanks_in_gender,

    SUM(`account_status` IS NULL) AS nulls_in_account_status,
    SUM(`account_status` = '') AS blanks_in_account_status,

    SUM(`impressions` IS NULL) AS nulls_in_impressions,
    SUM(`impressions` = '') AS blanks_in_impressions,

    SUM(`clicks` IS NULL) AS nulls_in_clicks,
    SUM(`clicks` = '') AS blanks_in_clicks,

    SUM(`conversions` IS NULL) AS nulls_in_conversions,
    SUM(`conversions` = '') AS blanks_in_conversions,

    SUM(`sign_ups` IS NULL) AS nulls_in_sign_ups,
    SUM(`sign_ups` = '') AS blanks_in_sign_ups,

    SUM(`emails_sent` IS NULL) AS nulls_in_emails_sent,
    SUM(`emails_sent` = '') AS blanks_in_emails_sent,

    SUM(`emails_opened` IS NULL) AS nulls_in_emails_opened,
    SUM(`emails_opened` = '') AS blanks_in_emails_opened,

    SUM(`total_ad_spend` IS NULL) AS nulls_in_total_ad_spend,
    SUM(`total_ad_spend` = '') AS blanks_in_total_ad_spend
FROM levis_ecommerce_marketing_data;

-- check distinct values in date column to see if there are any misspellings or inconsistencies
SELECT DISTINCT `date`
FROM levis_ecommerce_marketing_data;

-- check distinct values in channel column to see if there are any misspellings or inconsistencies
SELECT DISTINCT channel
FROM levis_ecommerce_marketing_data;

-- there are 'ERROR' and blank values in the channel column
-- check to see the number of 'ERROR' values and blank values in the channel column
SELECT
	CASE
		WHEN channel = 'ERROR' THEN 'errors'
        WHEN channel = '' THEN 'blanks'
        ELSE 'no issue'
        END AS 'potentials_issues',
	COUNT(channel) AS number_of_potential_issues
FROM levis_ecommerce_marketing_data
GROUP BY potentials_issues;

-- check distinct values in the campaign column to see if there are any misspellings or inconsistencies
SELECT DISTINCT campaign
FROM levis_ecommerce_marketing_data;

-- there are 'ERROR' and blank values in the campaign column
-- check to see the number of 'ERROR' and blank values in the campaign column
SELECT
	CASE
		WHEN campaign = 'ERROR' THEN 'errors'
        WHEN campaign = '' THEN 'blanks'
        ELSE 'no issue'
        END AS potential_issues,
	COUNT(campaign) AS number_of_potential_issues
FROM levis_ecommerce_marketing_data
GROUP BY potential_issues;

-- check the distinct values in the region column to see if there are any misspellings or inconsistencies
SELECT DISTINCT region
FROM levis_ecommerce_marketing_data;

-- there is at least one blank and one 'ERROR' value in the region column
-- check the number of blank and 'ERROR' values in the column
SELECT
	CASE
		WHEN region = '' THEN 'blanks'
        WHEN region = 'ERROR' THEN 'errors'
        ELSE 'niether blanks nor errors'
        END AS error_category,
	COUNT(region) AS number_of_errors
FROM levis_ecommerce_marketing_data
GROUP BY error_category;

-- check the distinct values in the gender column to see if there are any misspellings or inconsistencies
SELECT DISTINCT gender
FROM levis_ecommerce_marketing_data;

-- there are values in the gender column that are 'unspecified', blank, or 'ERROR'
-- check the number of each of these values in the column
SELECT
	CASE
		WHEN gender = 'Unspecified' THEN 'Unspecified'
        WHEN gender = 'ERROR' THEN 'errors'
        WHEN gender = '' THEN 'blanks'
        ELSE 'no issue'
        END AS potential_issues,
    COUNT(gender) AS number_of_potential_issues
FROM levis_ecommerce_marketing_data
GROUP BY potential_issues;

-- check the distinct values in the account_status column to see if there are any misspellings or inconsistencies
SELECT DISTINCT account_status
FROM levis_ecommerce_marketing_data;

-- there are blank and 'ERROR' values in the account_status column
-- check the number of these values in the column
SELECT
	CASE
    WHEN account_status = 'ERROR' THEN 'errors'
    WHEN account_status = '' THEN 'blanks'
    ELSE 'no issue'
    END AS potential_issues,
    COUNT(account_status)
FROM levis_ecommerce_marketing_data
GROUP BY potential_issues;

-- check if there are any 'ERROR' values in the date column because we haven't checked for that yet,
-- and there are a lot of 'ERROR' values in the columns we've looked at so far
SELECT `date`
FROM levis_ecommerce_marketing_data
WHERE `date` = 'ERROR';

-- check if there exists an 'ERROR' value in the impressions column
SELECT EXISTS (
  SELECT 1
  FROM levis_ecommerce_marketing_data
  WHERE impressions = 'ERROR'
) AS error_exists;

-- check the number of 'ERROR' values in the impressions column
SELECT COUNT(*) AS number_of_errors
FROM levis_ecommerce_marketing_data
WHERE impressions = 'ERROR';

-- check if there exists an 'ERROR' value in clicks column
SELECT EXISTS (
	SELECT 1
    FROM levis_ecommerce_marketing_data
    WHERE clicks = 'ERROR'
) AS error_exists;

-- check if there are any 'ERROR' values in conversions column
SELECT EXISTS(
	SELECT 1
    FROM levis_ecommerce_marketing_data
    WHERE conversions = 'ERROR'
) AS error_exists;

-- count the number of 'ERROR' values in conversions column
SELECT COUNT(*) AS count_of_errors
FROM levis_ecommerce_marketing_data
WHERE conversions = 'ERROR';

-- check if there are any 'ERROR' values in sign_ups column
SELECT EXISTS (
	SELECT 1
    FROM levis_ecommerce_marketing_data
    WHERE sign_ups = 'ERROR'
) AS error_exists;

-- count the number of 'ERROR' values in the sign_ups column
SELECT COUNT(*) AS count_of_errors
FROM levis_ecommerce_marketing_data
WHERE sign_ups = 'ERROR';

-- check if there are any 'ERROR' values in emails_sent column
SELECT EXISTS (
	SELECT 1
    FROM levis_ecommerce_marketing_data
    WHERE emails_sent = 'ERROR'
) AS error_exists;

-- count the number of 'ERROR' values in the emails_sent column
SELECT COUNT(*) AS count_of_errors
FROM levis_ecommerce_marketing_data
WHERE emails_sent = 'ERROR';

-- check if there are any 'ERROR' values in emails_opened column
SELECT EXISTS (
	SELECT 1
    FROM levis_ecommerce_marketing_data
    WHERE emails_opened = 'ERROR'
) AS error_exists;

-- count the number of 'ERROR' values in the emails_opened column
SELECT COUNT(*) AS count_of_errors
FROM levis_ecommerce_marketing_data
WHERE emails_opened = 'ERROR';

-- check if there are any 'ERROR' values in total_ad_spend column
SELECT EXISTS (
	SELECT 1
    FROM levis_ecommerce_marketing_data
    WHERE total_ad_spend = 'ERROR'
) AS error_exists;

-- count the number of 'ERROR' values in the total_ad_spend column
SELECT COUNT(*) AS count_of_errors
FROM levis_ecommerce_marketing_data
WHERE total_ad_spend = 'ERROR';

-- Step 4. Convert Columns to Appropriate Data Types

-- create backup table
CREATE TABLE backup_levis_ecommerce_marketing_data AS
SELECT *
FROM levis_ecommerce_marketing_data;

-- change date column from text to date data type
ALTER TABLE levis_ecommerce_marketing_data
MODIFY `date` DATE;

-- change all blank or 'ERROR' values in the emails_sent column to nulls
UPDATE levis_ecommerce_marketing_data
SET emails_sent = NULL
WHERE emails_sent = '' OR emails_sent = 'ERROR';

-- convert emails_sent column from text to int
ALTER TABLE levis_ecommerce_marketing_data
MODIFY emails_sent INT;

-- change all blank or 'ERROR' values in the emails_opened column to nulls
UPDATE levis_ecommerce_marketing_data
SET emails_opened = NULL
WHERE emails_opened = '' OR emails_opened = 'ERROR';

-- convert emails_opened column from text to int
ALTER TABLE levis_ecommerce_marketing_data
MODIFY emails_opened INT;

-- convert clicks column from text to int
ALTER TABLE levis_ecommerce_marketing_data
MODIFY clicks INT;

-- change all blank or 'ERROR' values in the sign_ups column to nulls
UPDATE levis_ecommerce_marketing_data
SET sign_ups = NULL
WHERE sign_ups = '' OR sign_ups = 'ERROR';

-- convert sign_ups column from text to int
ALTER TABLE levis_ecommerce_marketing_data
MODIFY sign_ups INT;

-- Step 5. Look at Summary Statistics for Numerical Columns

-- summary stats for impressions
SELECT
	MIN(impressions),
    MAX(impressions),
    AVG(impressions),
    STDDEV(impressions)
FROM levis_ecommerce_marketing_data;

-- summary stats for clicks
SELECT
	MIN(clicks),
    MAX(clicks),
    AVG(clicks),
    STDDEV(clicks)
FROM levis_ecommerce_marketing_data;

-- summary stats for conversions
SELECT
	MIN(conversions),
    MAX(conversions),
    AVG(conversions),
    STDDEV(conversions)
FROM levis_ecommerce_marketing_data;

-- summary stats for sign_ups
SELECT
	MIN(sign_ups),
    MAX(sign_ups),
    AVG(sign_ups),
    STDDEV(sign_ups)
FROM levis_ecommerce_marketing_data;

-- summary stats for total_ad_spend
SELECT
	MIN(total_ad_spend),
    MAX(total_ad_spend),
    AVG(total_ad_spend),
    STDDEV(total_ad_spend)
FROM levis_ecommerce_marketing_data;

-- summary stats on emails_sent column
SELECT
	MIN(emails_sent),
    MAX(emails_sent),
    AVG(emails_sent),
    STDDEV(emails_sent)
FROM levis_ecommerce_marketing_data;

-- summary stats on emails_opened column
SELECT
	MIN(emails_opened),
    MAX(emails_opened),
    AVG(emails_opened),
    STDDEV(emails_opened)
FROM levis_ecommerce_marketing_data;

-- check the range of dates
SELECT
	MIN(`date`),
	MAX(`date`)
FROM levis_ecommerce_marketing_data;

-- Step 6. Handle Rows with Null, Blank, or Invalid Entries

-- drop rows that have nulls in the sign_ups column

-- look at the rows we are going to delete
SELECT *
FROM levis_ecommerce_marketing_data
WHERE sign_ups IS NULL;

-- delete rows with nulls in the sign_ups column
DELETE FROM levis_ecommerce_marketing_data
WHERE sign_ups IS NULL;

-- drop rows that have null, blank, or 'ERROR' entries in the region column

-- look at the rows we are going to delete
SELECT *
FROM levis_ecommerce_marketing_data
WHERE region = '' OR region = 'ERROR';

-- delete rows that have blanks or 'ERROR' entries in region column
DELETE FROM levis_ecommerce_marketing_data
WHERE region = '' OR region = 'ERROR';

-- drop rows that have blanks or 'ERROR' entries in the account_status column

-- look at the rows we are going to drop
SELECT *
FROM levis_ecommerce_marketing_data
WHERE account_status = '' OR account_status = 'ERROR';

-- delete rows that have blanks or 'ERROR' entries in the account_status column
DELETE FROM levis_ecommerce_marketing_data
WHERE account_status = '' OR account_status = 'ERROR';

-- drop rows that have blanks or 'ERROR' entries in the gender column

-- look at the rows we are going to drop
SELECT *
FROM levis_ecommerce_marketing_data
WHERE gender = '' OR gender = 'ERROR';

-- delete the rows that have blanks or 'ERROR' entries in the gender column
DELETE FROM levis_ecommerce_marketing_data
WHERE gender = '' OR gender = 'ERROR';

-- take a look at the rows that have values of 0 in the clicks column
SELECT *
FROM levis_ecommerce_marketing_data
WHERE clicks = 0;

-- delete the rows that have values of 0 in the clicks column because these rows do not make sense
-- they all have values of 0 in the conversions column, values between 10 and 80 in the sign_ups column, and values of 0 in total_ad_spend column
DELETE FROM levis_ecommerce_marketing_data
WHERE clicks = 0;

-- Step 7. Validate Logical Relationships Between Columns

-- check if there are any rows where clicks < sign_ups
SELECT *
FROM levis_ecommerce_marketing_data
WHERE clicks < sign_ups;

-- delete rows where clicks < sign_ups because clicks should be greater than sign ups
DELETE FROM levis_ecommerce_marketing_data
WHERE clicks < sign_ups;
