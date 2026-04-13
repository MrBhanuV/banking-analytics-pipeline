create database banking_project;
use banking_project;

SELECT COUNT(*) FROM stg_applications;
SELECT COUNT(*) FROM stg_installments;

-- Quick look at the data
SELECT * FROM stg_applications LIMIT 5;
SELECT * FROM stg_installments LIMIT 5;

-- Star Schema Design
-- dim_customer
-- dim_loan
-- dim_date
--         ↘
--          fact_loan_performance
--         ↗
-- dim_payment


-- ---------------------------------------------------------------------
-- dim_customer
-- ---------------------------------------------------------------------
create table dim_customer as 
select distinct
	sk_id_curr as customer_id,
    code_gender as gender,
    flag_own_car as owns_car,
    flag_own_realty as owns_realty,
    cnt_children as children_count,
    name_education_type as education_level,
    name_family_status as family_status,
    name_housing_type as housing_type,
    occupation_type as occupation,
    region_population_relative as region_populution,
    days_birth / -365 as age_year,
    days_employed /-365 as years_employed
from stg_applications;

-- ---------------------------------------------------------------------
-- dim_loan
-- ---------------------------------------------------------------------

CREATE TABLE dim_loan AS
SELECT DISTINCT
    sk_id_curr AS customer_id,
    name_contract_type AS contract_type,
    amt_credit AS credit_amount,
    amt_annuity AS annuity_amount,
    amt_income_total AS total_income,
    amt_goods_price AS goods_price,
    name_income_type AS income_type,
    weekday_appr_process_start AS application_weekday,
    hour_appr_process_start AS application_hour,
    target AS is_defaulted
FROM stg_applications;
