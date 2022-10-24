/*
Task 1
Find the average salary of the male and female employees in each department.
*/

SELECT
    d.dept_name, e.gender, ROUND(AVG(s.salary), 2) as avg_salary
FROM
    employees_mod.t_salaries s
        JOIN
    employees_mod.t_employees e ON s.emp_no = e.emp_no
        JOIN
    employees_mod.t_dept_emp de ON e.emp_no = de.emp_no
        JOIN
    employees_mod.t_departments d ON d.dept_no = de.dept_no
GROUP BY 1 , 2
ORDER BY 1;

-----------------------------------------------------------------------------------------------------------------------------------------------

/*
Task 2
Find the lowest department number encountered in the 'dept_emp' table. 
Then, find the highest department number.
*/

SELECT
    MIN(dept_no)
FROM
    t_dept_emp;

SELECT
    MAX(dept_no)
FROM
    t_dept_emp;

/*
Task 2b
Find the lowest department number encountered in the 'dept_emp' table and find the highest department number.
*/

SELECT 
    MAX(dept_no) AS lowest_dept_no,
    MIN(dept_no) AS highest_dept_no
FROM
    employees_mod.t_dept_emp;
    
-----------------------------------------------------------------------------------------------------------------------------------------------

/*
Task 3
Find the lowest department number encountered in the 'dept_emp' table and find the highest department number.
*/

SELECT 
    emp_no,
    (SELECT 
            MIN(dept_no)
        FROM
            dept_emp de
        WHERE
            e.emp_no = de.emp_no) AS dept_no,
    CASE
        WHEN emp_no <= 10020 THEN '110022'
        ELSE '110039'
    END AS manager
FROM
    employees e
WHERE
    emp_no <= 10040; 

-----------------------------------------------------------------------------------------------------------------------------------------------

/*
Task 4
Retrieve a list of all employees that have been hired in 2000.
*/
SELECT 
    emp_no,
    birth_date,
    first_name,
    last_name,
    gender,
    YEAR(hire_date) AS calendar_year
FROM
    employees_mod.t_employees
WHERE
    YEAR(hire_date) = 2000
ORDER BY emp_no ASC;

-----------------------------------------------------------------------------------------------------------------------------------------------

/*
Task 5
Retrieve a list with all employees from the ‘titles’ table who are engineers. 
Repeat the exercise, this time retrieving a list with all employees from the ‘titles’ table who are senior engineers.
*/
SELECT 
    *
FROM
    titles
WHERE
    title = 'engineer'
ORDER BY 1 ASC;
    
SELECT 
    *
FROM
    titles
WHERE
    title = 'senior engineer'
ORDER BY 1 ASC;

# Task 5b
SELECT
    *
FROM
    titles
WHERE
    title LIKE ('%engineer%');

SELECT
    *
FROM
    titles
WHERE
    title LIKE ('%senior engineer%'); 
    
SELECT
    *
FROM
    titles
WHERE
    title LIKE '%engineer%';

SELECT
    *
FROM
    titles
WHERE
    title LIKE '%senior engineer%';  
-----------------------------------------------------------------------------------------------------------------------------------------------

/*
Task 6
How many contracts have been registered in the ‘salaries’ table with duration of more than one year and of value higher than or equal to $100,000?
*/

SELECT 
    COUNT(salary) as salary
FROM
    employees.salaries
WHERE
    DATEDIFF(to_date, from_date) > 365
        AND salary >= 100000;

-- 7b. And for a leap year
SELECT 
    COUNT(salary) as salary
FROM
    employees.salaries
WHERE
    DATEDIFF(to_date, from_date) > 366
        AND salary >= 100000;

-----------------------------------------------------------------------------------------------------------------------------------------------