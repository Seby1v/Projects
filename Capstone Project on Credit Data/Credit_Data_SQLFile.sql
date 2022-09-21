# create schema customer_credit;
#use customer_credit;

# schema(or database) name is customer_credit
# table name is customers

# -------------------BASIC EXPLORATION-------------------

# table description
desc customers;

# number of rows - 41436
select count(*) as num_rows from customers;

#number of columns - 18(including index from dataframe) 
SELECT count(*) as num_cols FROM information_schema.columns WHERE table_name = 'customers';


# top 5 rows of dataset
select * from customers LIMIT 5;


-- select distinct age_cat from customer_database
-- where (loan='yes' or housing ='yes') ;

-- --------------------------SQL QUERIES------------------------------------------------

-- 1. Write an SQL query to identify the age group  which is taking more loan 
-- and then calculate the sum of all of the balances of it?

select age_bin, sum(balance) as balance_sum from customers 
where (loan='yes' or housing ='yes')
group by age_bin
order by balance_sum desc
limit 1;

#Young (21-40) is taking more loans and sum of balance is 12918368

-- 2. Write an SQL query to calculate for each record if a loan has been taken less than 100, 
-- then  calculate the fine of 15% of the current balance and create a temp table and     
-- then add the amount for each month from that temp table? 

# no separate loan amount column diffrent from balance for each record
# this query cannot be performed
# both loans housing and personal have been taken more than 100 times

select loan ,housing, count(*) from customers
group by loan, housing
having (loan='yes' or housing='yes');

-- 3. Write an SQL query to calculate each age group along with 
-- each department's highest balance record? 

# highest balance for each age group - old(age>60) has highest
select age_bin, max(balance) as max_bal from customers
group by age_bin
order by max_bal desc; # young age-group has highest balance 8929

# no department column but we can try by 'job'
select job, age_cat, max(balance) as max_bal from customer_database
group by job, age_cat
order by max_bal desc; #retired and old have highest balance 8556


-- 4. Write an SQL query to find the secondary highest education, where duration is more than 150. 
-- The query should contain only married people, and then calculate the interest amount? (Formula interest => balance*15%).

# deleted duration during data cleaning 

-- 5. Write an SQL query to find which profession has taken more loan along with age?

select job, age_bin, count(*) as loan_count from customers
where (loan='yes' or housing ='yes')
group by job, age_bin
order by loan_count desc
limit 1; # blue-collar and young have taken most loans(4208)

-- 6. Write an SQL query to calculate each month's total balance and 
-- then calculate in which month the highest amount of transaction was performed?

select month, sum(balance) as total_balance from customer_database 
group by month
order by total_balance desc
limit 1;

# in month of MAY highest transaction was performed

