-- Analyzing Retail Ecommerce Marketing Dataset

-- Step 1. Create New Column for Sign-Up Rate

ALTER TABLE levis_ecommerce_marketing_data
ADD COLUMN sign_up_rate FLOAT;

UPDATE levis_ecommerce_marketing_data
SET sign_up_rate = ROUND((sign_ups / clicks) * 100, 2);

-- Step 2. Slice Key Metrics By Key Dimensions

-- for every region, get the total clicks and total sign-ups
SELECT region, SUM(clicks) AS total_clicks, SUM(sign_ups) AS total_sign_ups
FROM levis_ecommerce_marketing_data
WHERE account_status = 'No Account'
GROUP BY region
ORDER BY total_sign_ups DESC;

-- for every region, get the average sign-up rate
SELECT region, ROUND(AVG(sign_up_rate),2) as average_sign_up_rate
FROM levis_ecommerce_marketing_data
WHERE account_status = 'No Account'
GROUP BY region
ORDER BY average_sign_up_rate DESC;

-- for every gender, get the total clicks and total sign ups
SELECT gender, SUM(clicks) AS total_clicks, SUM(sign_ups) AS total_sign_ups
FROM levis_ecommerce_marketing_data
WHERE account_status = 'No Account'
GROUP BY gender
ORDER BY total_sign_ups DESC;

-- for every gender, get the average sign-up rate
SELECT gender, ROUND(AVG(sign_up_rate),2) AS average_sign_up_rate
FROM levis_ecommerce_marketing_data
WHERE account_status = 'No Account'
GROUP BY gender
ORDER BY average_sign_up_rate DESC;

-- for rows with no account, get the total clicks, total sign-ups, and average sign-up rate
SELECT account_status,
	SUM(clicks) AS total_clicks,
	SUM(sign_ups) AS total_sign_ups,
	ROUND(AVG(sign_up_rate),2) AS average_sign_up_rate
FROM levis_ecommerce_marketing_data
WHERE account_status = 'No Account';

-- Step 3. Create New Column for Cost-per-sign-up

-- check if there are any rows where the total ad spend is 0
SELECT *
FROM levis_ecommerce_marketing_data
WHERE total_ad_spend = 0;

-- check if there are any rows where the sign-ups is 0
-- make sure we do not include these rows when calculating cost per sign-up because we do not want to divide by zero
SELECT *
FROM levis_ecommerce_marketing_data
WHERE sign_ups = 0;

-- see if there are any rows where the total ad spend is blank or 'ERROR'
SELECT *
FROM levis_ecommerce_marketing_data
WHERE total_ad_spend = '' OR total_ad_spend = 'ERROR';

-- create and populate cost per sign-up column

ALTER TABLE levis_ecommerce_marketing_data
ADD COLUMN cost_per_sign_up FLOAT;

UPDATE levis_ecommerce_marketing_data
SET cost_per_sign_up = CASE
	WHEN sign_ups != 0
    THEN ROUND(total_ad_spend/sign_ups,2)
    ELSE NULL
END;

-- Step 4. Slice Cost-per-sign-up by Key Dimensions

-- get the average cost-per-sign-up for every region
SELECT region, ROUND(AVG(cost_per_sign_up),2) AS average_cost_per_sign_up
FROM levis_ecommerce_marketing_data
WHERE account_status = 'No Account'
GROUP BY region
ORDER BY average_cost_per_sign_up DESC;

-- get the average cost-per-sign-up for every gender
SELECT gender, ROUND(AVG(cost_per_sign_up),2) AS average_cost_per_sign_up
FROM levis_ecommerce_marketing_data
WHERE account_status = 'No Account'
GROUP BY gender
ORDER BY average_cost_per_sign_up DESC;

-- get the average cost-per-sign-up for those who do not have an account
SELECT account_status, ROUND(AVG(cost_per_sign_up),2) AS average_cost_per_sign_up
FROM levis_ecommerce_marketing_data
WHERE account_status = 'No Account'
ORDER BY average_cost_per_sign_up DESC;
