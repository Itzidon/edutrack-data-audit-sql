# Auditoría de Datos en EduTrack — Informe de análisis

## Contexto y metodología

Se importó `edutrack.sql` en Supabase y se ejecutaron las consultas **en orden (Q1 a Q12)**. Las consultas Q1–Q5 reflejan la base **antes** de insertar, actualizar y borrar registros; Q9–Q12 reflejan la base **después** de los cambios Q6–Q8. Se modificó únicamente `enrollments` durante la auditoría; las tablas `students` y `courses` se usaron solo como contexto.

## Q1 - Inscripciones en 'Intro to Python'

**Resultado: 5 inscripciones** (antes de borrar las cuentas de prueba).

| Estudiante | Correo | Completado |
| --- | --- | ---: |
| Emily Watson | emily.watson@student.edutrack.com | 85 % |
| Klaus Weber | klaus.weber@student.edutrack.com | 92 % |
| Marco Rossi | marco.rossi@student.edutrack.com | 88 % |
| James Miller | james.miller@test.com | 30 % |
| Priya Sharma | priya.sharma@student.edutrack.com | 55 % |

## Q2 - Inscripciones con completado inferior al 10 %

**Resultado: 4 inscripciones**, correspondientes a 3 estudiantes.

| Estudiante | Curso | Completado |
| --- | --- | ---: |
| Lucia Fernandes | Web Design Basics | 5 % |
| Lucia Fernandes | Digital Marketing 101 | 3 % |
| Yuki Nakamura | UI/UX Fundamentals | 0 % |
| Pierre Dubois | UI/UX Fundamentals | 0 % |

## Q3 - Inscripciones sin instructor

**Resultado: 2 inscripciones** con `instructor IS NULL`.

- ID 10: Yuki Nakamura — UI/UX Fundamentals.
- ID 11: Pierre Dubois — UI/UX Fundamentals.

## Q4 - Cinco inscripciones con mayor progreso sin haber aprobado

**Resultado: 5 inscripciones** (antes de Q6–Q8), ordenadas por porcentaje descendente.

| Estudiante | Curso | Completado | ¿Aprobado? |
| --- | --- | ---: | --- |
| Emily Watson | Web Design Basics | 60 % | No |
| Priya Sharma | Intro to Python | 55 % | No |
| Yuki Nakamura | Data Analysis with SQL | 45 % | No |
| Emily Watson | Advanced Python | 40 % | No |
| James Miller | Intro to Python | 30 % | No |

## Q5 - Inscripciones desde el 1 de julio de 2024

**Resultado: 9 inscripciones** (antes de Q6–Q8), en orden de fecha descendente.

| Fecha | Estudiante | Curso |
| --- | --- | --- |
| 2025-03-05 | Emily Watson | Advanced Python |
| 2025-02-20 | Pierre Dubois | Data Analysis with SQL |
| 2025-01-10 | Priya Sharma | Intro to Python |
| 2024-12-01 | Priya Sharma | Digital Marketing 101 |
| 2024-11-05 | Pierre Dubois | UI/UX Fundamentals |
| 2024-10-11 | Yuki Nakamura | UI/UX Fundamentals |
| 2024-09-03 | Yuki Nakamura | Data Analysis with SQL |
| 2024-08-09 | Marco Rossi | Intro to Python |
| 2024-07-01 | Lucia Fernandes | Digital Marketing 101 |

## Q6 - Añadir la inscripción faltante

**Resultado: 1 inscripción insertada.** Se verificó primero que el ID 18 no existía.

- ID: 18
- Estudiante: Lucia Fernandes (ID 3; `lucia.fernandes@student.edutrack.com`)
- Curso: Advanced Python (ID 5); categoría Programming
- Fecha de inscripción: 2025-04-01
- Porcentaje completado: 0 %; aprobado: false
- Cuota mensual pagada: 69,99 €; instructor: Carlos Vega

## Q7 - Completar instructores ausentes

**Resultado: 2 inscripciones actualizadas.** El campo `instructor` se cambió de `NULL` a `Pending assignment` únicamente en:

- ID 10: Yuki Nakamura.
- ID 11: Pierre Dubois.

## Q8 - Eliminar cuentas de prueba

**Resultado: 2 inscripciones eliminadas**, tras comprobar los correos con una consulta `SELECT` previa.

- ID 13: James Miller — `james.miller@test.com`.
- ID 14: Alex Chen — `alex.chen@test.com`.

No se eliminaron las filas de las tablas `students` ni `courses`.

## Q9 - Inscripciones por categoría

**Resultado: 16 inscripciones** después de las correcciones.

| Categoría | Inscripciones |
| --- | ---: |
| Programming | 7 |
| Design | 4 |
| Data | 3 |
| Marketing | 2 |
| **Total** | **16** |

## Q10 - Promedio de completado por curso

**Resultado: 6 cursos**, ordenados de menor a mayor.

| Curso | Promedio de completado |
| --- | ---: |
| UI/UX Fundamentals | 0,00 % |
| Web Design Basics | 32,50 % |
| Digital Marketing 101 | 36,50 % |
| Advanced Python | 45,00 % |
| Data Analysis with SQL | 47,67 % |
| Intro to Python | 80,00 % |

El curso con peor completado es **UI/UX Fundamentals** (0 %).

## Q11 - Cursos con más de tres inscripciones

**Resultado: 1 curso**.

- Intro to Python: **4 inscripciones**.

## Q12 - Ingresos totales por categoría

**Resultado: 4 categorías**, ordenadas de mayor a menor.

| Categoría | Ingresos totales |
| --- | ---: |
| Programming | 409,93 € |
| Data | 179,97 € |
| Design | 169,96 € |
| Marketing | 59,98 € |
| **Total** | **819,84 €** |

## Conclusiones

La auditoría identificó **4 inscripciones con progreso inferior al 10 %**, añadió **1 inscripción omitida**, corrigió **2 instructores ausentes** y eliminó **2 inscripciones de prueba**. Tras los cambios quedan **16 inscripciones** y **819,84 €** de cuotas registradas. *UI/UX Fundamentals* presenta el progreso más bajo (0 %), mientras que *Intro to Python* presenta el mayor promedio de completado (80 %).

La categoría **Design** muestra un promedio global de completado del **16,25 %** (65 puntos porcentuales acumulados entre cuatro inscripciones), inferior al de las demás categorías. Es prioritaria para estudiar posibles abandonos.
