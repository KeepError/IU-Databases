-- Task 1
SELECT * FROM course
WHERE dept_name='Comp. Sci.' AND credits=3;


-- Task 2
SELECT course.course_id, course.title FROM takes
JOIN course ON takes.course_id=course.course_id
WHERE id='12345';

-- Task 3
SELECT SUM(course.credits) FROM takes
JOIN course ON takes.course_id=course.course_id
WHERE id='12345';

-- Task 4
SELECT takes.id, SUM(course.credits) FROM takes
JOIN course ON takes.course_id=course.course_id
GROUP BY takes.id;

-- Task 5
SELECT DISTINCT student.name FROM takes
JOIN course ON takes.course_id=course.course_id
JOIN student ON takes.id=student.id
WHERE course.dept_name='Comp. Sci.';

-- Task 6
SELECT id FROM instructor
EXCEPT
SELECT id FROM teaches;

-- Task 7
SELECT id, name FROM instructor
EXCEPT
SELECT teaches.id, instructor.name FROM teaches
JOIN instructor ON teaches.id=instructor.id;
