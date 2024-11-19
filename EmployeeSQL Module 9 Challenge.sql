CREATE TABLE departments (
    dept_no CHAR(4) PRIMARY KEY,
    dept_name VARCHAR(40) NOT NULL
);

CREATE TABLE employees (
    emp_no INT PRIMARY KEY,
    emp_title_id CHAR(5) NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    sex CHAR(1) CHECK (sex IN ('M', 'F')),
    hire_date DATE NOT NULL
);

CREATE TABLE salaries (
    emp_no INT PRIMARY KEY,
    salary INT NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no) ON DELETE CASCADE
);

CREATE TABLE titles (
    title_id CHAR(5) PRIMARY KEY,
    title VARCHAR(50) NOT NULL
);

CREATE TABLE dept_emp (
    emp_no INT,
    dept_no CHAR(4),
    PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no) ON DELETE CASCADE,
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no) ON DELETE CASCADE
);

CREATE TABLE dept_manager (
    dept_no CHAR(4),
    emp_no INT,
    PRIMARY KEY (dept_no, emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no) ON DELETE CASCADE,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no) ON DELETE CASCADE
);

SELECT *
FROM departments;

SELECT 
    e.emp_no,
    e.last_name,
    e.first_name,
    e.sex,
    s.salary
FROM 
    employees e
JOIN 
    salaries s
ON 
    e.emp_no = s.emp_no;

SELECT 
    first_name,
    last_name,
    hire_date
FROM 
    employees
WHERE 
    EXTRACT(YEAR FROM hire_date) = 1986;

SELECT 
    dm.dept_no,
    d.dept_name,
    dm.emp_no AS manager_emp_no,
    e.last_name,
    e.first_name
FROM 
    dept_manager dm
JOIN 
    departments d
ON 
    dm.dept_no = d.dept_no
JOIN 
    employees e
ON 
    dm.emp_no = e.emp_no;

SELECT 
    de.dept_no,
    e.emp_no,
    e.last_name,
    e.first_name,
    d.dept_name
FROM 
    dept_emp de
JOIN 
    employees e
ON 
    de.emp_no = e.emp_no
JOIN 
    departments d
ON 
    de.dept_no = d.dept_no;

SELECT 
    first_name,
    last_name,
    sex
FROM 
    employees
WHERE 
    first_name = 'Hercules'
    AND last_name LIKE 'B%';

SELECT 
    e.emp_no,
    e.last_name,
    e.first_name
FROM 
    dept_emp de
JOIN 
    employees e
ON 
    de.emp_no = e.emp_no
JOIN 
    departments d
ON 
    de.dept_no = d.dept_no
WHERE 
    d.dept_name = 'Sales';

SELECT 
    e.emp_no,
    e.last_name,
    e.first_name,
    d.dept_name
FROM 
    dept_emp de
JOIN 
    employees e
ON 
    de.emp_no = e.emp_no
JOIN 
    departments d
ON 
    de.dept_no = d.dept_no
WHERE 
    d.dept_name IN ('Sales', 'Development');

SELECT 
    last_name,
    COUNT(*) AS frequency
FROM 
    employees
GROUP BY 
    last_name
ORDER BY 
    frequency DESC;


