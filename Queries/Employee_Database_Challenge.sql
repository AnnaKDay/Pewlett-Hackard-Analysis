-- combining titles and employees tables
SELECT e.emp_no,
    e.first_name,
    e.last_name,
    ti.title,
    ti.from_date,
    ti.to_date
INTO emp_titles
FROM employees AS e
INNER JOIN titles AS ti
    ON (ti.emp_no = e.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- retirement table with current position (taking into account promotions)
-- removing duplicates from promotions or job changes 
SELECT DISTINCT rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles
FROM retirement_titles as rt
WHERE (to_date = '9999-01-01')
ORDER BY emp_no ASC;

-- count number of each unique title from unique_titles table
SELECT ut.title,
	COUNT (ut.title)
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY count DESC;

-- mentorship-eligibility table
SELECT DISTINCT ON(e.emp_no)
	e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_elibility
FROM employees AS e
INNER JOIN dept_emp AS de
	ON (e.emp_no = de.emp_no)
INNER JOIN titles AS ti
	ON(e.emp_no = ti.emp_no)
WHERE (de.to_date = '9999-01-01')
	AND (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no ASC;