-- Auditoría de Datos en EduTrack
-- Ejecutar tras importar edutrack.sql en una base de datos nueva.
-- Importante: ejecutar EN ORDEN Q1-Q12 y solo una vez las modificaciones Q6-Q8.

-- Q1: Inscripciones en 'Intro to Python'
SELECT student_name, student_email, completion_percentage
FROM enrollments
WHERE course_title = 'Intro to Python';

-- Q2: Inscripciones con porcentaje de completado menor que 10
SELECT *
FROM enrollments
WHERE completion_percentage < 10;

-- Q3: Inscripciones sin instructor asignado
SELECT *
FROM enrollments
WHERE instructor IS NULL;

-- Q4: Los cinco registros no aprobados con mayor porcentaje de completado
SELECT *
FROM enrollments
WHERE passed = FALSE
ORDER BY completion_percentage DESC
LIMIT 5;

-- Q5: Inscripciones desde el 1 de julio de 2024, de más reciente a más antigua
SELECT *
FROM enrollments
WHERE enrollment_date >= '2024-07-01'
ORDER BY enrollment_date DESC;

-- Q6: Añadir la inscripción que falta de Lucia Fernandes (ID 18)
INSERT INTO enrollments (
    id, student_id, student_name, student_email, course_id,
    course_title, category, enrollment_date, completion_percentage,
    passed, monthly_fee_paid, instructor
)
VALUES (
    18, 3, 'Lucia Fernandes', 'lucia.fernandes@student.edutrack.com', 5,
    'Advanced Python', 'Programming', '2025-04-01', 0,
    FALSE, 69.99, 'Carlos Vega'
)
RETURNING *;

-- Q7: Asignar texto predeterminado a inscripciones sin instructor
UPDATE enrollments
SET instructor = 'Pending assignment'
WHERE instructor IS NULL
RETURNING id, student_name, instructor;

-- Q8: Eliminar únicamente inscripciones de cuentas de prueba
-- Comprobación previa: SELECT * FROM enrollments WHERE student_email LIKE '%@test.com';
DELETE FROM enrollments
WHERE student_email LIKE '%@test.com'
RETURNING *;

-- Q9: Número de inscripciones por categoría después de las correcciones
SELECT category, COUNT(*) AS total
FROM enrollments
GROUP BY category;

-- Q10: Promedio de completado por curso (de menor a mayor)
SELECT course_title, AVG(completion_percentage) AS promedio
FROM enrollments
GROUP BY course_title
ORDER BY promedio ASC;

-- Q11: Cursos con más de tres inscripciones
SELECT course_title, COUNT(*) AS total
FROM enrollments
GROUP BY course_title
HAVING COUNT(*) > 3;

-- Q12: Ingresos totales por categoría (de mayor a menor)
SELECT category, SUM(monthly_fee_paid) AS total_revenue
FROM enrollments
GROUP BY category
ORDER BY total_revenue DESC;
