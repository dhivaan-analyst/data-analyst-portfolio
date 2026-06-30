create database loan_analysis;
use loan_analysis; 
select count(*) from loans;


#Query 1 — Total Loans and Average Loan Amount by Purpose:
select
	Purpose,
    count(*) as number_of_loans,
    round(avg(`Current Loan Amount`), 2) as avg_loan_amount,
    round(sum(`Current Loan Amount`), 2) as total_loan_amount
from loans
group by Purpose
order by number_of_loans desc
limit 10;

#Query 2 — Average Credit Score and Loan Amount by Home Ownership:
select
	`Home Ownership`,
    COUNT(*) as no_of_borrowers,
    round(avg(`Credit Score`), 2) as avg_creditscore,
    round(avg(`Current Loan Amount`), 2) as avg_loan_amount
from loans
group by `Home Ownership`
order by avg_creditscore desc;

   #Query 3 — Top 10 Customers by Loan Amount (using Window Function):
select
	`Customer ID`,`Current Loan Amount`,`Purpose`,
    `Credit Score`,
    dense_rank() over(order by `Current Loan Amount` desc) as loan_rank
    from loans
    order by loan_rank
    limit 10;
    
#Query 4 — Borrower Risk Profile (Credit Problems + Bankruptcies):
select
	case
		when `Number of Credit Problems` = 0 and Bankruptcies = 0 then 'Low Risk'
		when `Number of Credit Problems` <= 2 and Bankruptcies <= 1 then 'Mediam risk'
		else 'high risk'
    end as Risk_category,
    count(*) as number_of_borrowers,
    round(avg(`Current Loan Amount`), 2) as avg_loan_amount
    from loans
    group by Risk_category
    order by number_of_borrowers desc;
    
    #Query 5 — Loan Distribution by Term and Home Ownership:
    select
		Term,
        `Home Ownership`,
        count(*) as no_of_loans,
        round(avg(`Current Loan Amount`), 2) as avg_loan_amount
        from loans
        group by Term, `Home Ownership`
        order by Term,no_of_loans;
	
    #Query 6 — Advanced: Average Loan Amount by Purpose with Ranking (Window Function):
    select
		Purpose,
        count(*) as loan_count,
        round(avg(`Current Loan Amount`), 2) as avg_loan_amount,
        rank() over(order by avg(`Current Loan Amount`) desc) as avg_amount_rank
        from loans
        group by Purpose
        order by avg_amount_rank
        limit 10;
        