# Auditoría de Datos en EduTrack

## Introducción

En este proyecto he trabajado con la base de datos de EduTrack utilizando Supabase y SQL.

El objetivo era revisar las inscripciones de los estudiantes, detectar posibles errores, corregir algunos registros y analizar los resultados de los cursos.

Primero importé el archivo `edutrack.sql` en Supabase y comprobé que los datos se habían cargado correctamente.

Después realicé 12 consultas SQL. Las primeras sirven para buscar información, las siguientes para corregir registros y las últimas para obtener datos generales sobre las inscripciones, el progreso y los ingresos.

Todas las modificaciones se realizaron en la tabla `enrollments`, sin cambiar las tablas `students` y `courses`.

## Q1 - Inscripciones en Intro to Python

Busqué los estudiantes inscritos en Intro to Python, mostrando sus nombres, correos electrónicos y porcentajes de progreso.

**Resultado: 5 inscripciones.**

| Estudiante | Email | Progreso |
|---|---|---:|
| Emily Watson | emily.watson@student.edutrack.com | 85 % |
| Klaus Weber | klaus.weber@student.edutrack.com | 92 % |
| Marco Rossi | marco.rossi@student.edutrack.com | 88 % |
| James Miller | james.miller@test.com | 30 % |
| Priya Sharma | priya.sharma@student.edutrack.com | 55 % |

Estos resultados corresponden a los datos antes de eliminar las cuentas de prueba.

## Q2 - Inscripciones con menos del 10 % de progreso

Busqué las inscripciones que tenían un porcentaje de completado inferior al 10 %.

**Resultado: 4 inscripciones de 3 estudiantes.**

| Estudiante | Curso | Progreso |
|---|---|---:|
| Lucia Fernandes | Web Design Basics | 5 % |
| Lucia Fernandes | Digital Marketing 101 | 3 % |
| Yuki Nakamura | UI/UX Fundamentals | 0 % |
| Pierre Dubois | UI/UX Fundamentals | 0 % |

Hay varias inscripciones con muy poco progreso. Sería interesante revisar estos casos para saber si los estudiantes necesitan algún tipo de seguimiento.

## Q3 - Inscripciones sin instructor

Busqué los registros que no tenían un instructor asignado.

**Resultado: 2 inscripciones.**

- Yuki Nakamura, ID 10, curso UI/UX Fundamentals.
- Pierre Dubois, ID 11, curso UI/UX Fundamentals.

En ambos casos, el campo `instructor` tenía el valor `NULL`.

## Q4 - Cinco inscripciones con mayor progreso sin aprobar

Busqué las cinco inscripciones con mayor porcentaje de completado entre las que todavía no habían aprobado.

**Resultado: 5 inscripciones.**

| Estudiante | Curso | Progreso |
|---|---|---:|
| Emily Watson | Web Design Basics | 60 % |
| Priya Sharma | Intro to Python | 55 % |
| Yuki Nakamura | Data Analysis with SQL | 45 % |
| Emily Watson | Advanced Python | 40 % |
| James Miller | Intro to Python | 30 % |

Emily Watson es la estudiante con mayor progreso de este grupo, con un 60 % en Web Design Basics, aunque todavía no aparece como aprobada.

Los resultados corresponden al estado de la base de datos antes de las correcciones.

## Q5 - Inscripciones desde el 1 de julio de 2024

Busqué las inscripciones realizadas desde el 1 de julio de 2024 y las ordené desde la más reciente hasta la más antigua.

**Resultado: 9 inscripciones.**

| Fecha | Estudiante | Curso |
|---|---|---|
| 2025-03-05 | Emily Watson | Advanced Python |
| 2025-02-20 | Pierre Dubois | Data Analysis with SQL |
| 2025-01-10 | Priya Sharma | Intro to Python |
| 2024-12-01 | Priya Sharma | Digital Marketing 101 |
| 2024-11-05 | Pierre Dubois | UI/UX Fundamentals |
| 2024-10-11 | Yuki Nakamura | UI/UX Fundamentals |
| 2024-09-03 | Yuki Nakamura | Data Analysis with SQL |
| 2024-08-09 | Marco Rossi | Intro to Python |
| 2024-07-01 | Lucia Fernandes | Digital Marketing 101 |

La inscripción más reciente de este grupo era la de Emily Watson, del 5 de marzo de 2025.

## Q6 - Añadir una inscripción que faltaba

En esta consulta añadí una inscripción de Lucia Fernandes que no estaba registrada en la base de datos.

Primero comprobé que no existía ningún registro con el ID 18.

**Resultado: 1 inscripción añadida.**

Datos de la inscripción:

- ID: 18
- Estudiante: Lucia Fernandes
- ID del estudiante: 3
- Email: lucia.fernandes@student.edutrack.com
- Curso: Advanced Python
- ID del curso: 5
- Categoría: Programming
- Fecha: 2025-04-01
- Progreso: 0 %
- Aprobado: No
- Cuota pagada: 69,99 €
- Instructor: Carlos Vega

La inscripción se añadió correctamente a la tabla `enrollments`.

## Q7 - Corregir los instructores vacíos

Actualicé las inscripciones que no tenían instructor asignado.

**Resultado: 2 registros actualizados.**

- Yuki Nakamura, ID 10.
- Pierre Dubois, ID 11.

En los dos registros cambié el valor `NULL` por `Pending assignment`.

De esta manera, las inscripciones quedan identificadas como pendientes de asignar un instructor.

## Q8 - Eliminar las cuentas de prueba

Busqué las inscripciones que tenían correos electrónicos terminados en `@test.com`.

Antes de eliminarlas, comprobé cuáles eran los registros afectados.

**Resultado: 2 inscripciones eliminadas.**

- James Miller, ID 13: james.miller@test.com
- Alex Chen, ID 14: alex.chen@test.com

Se eliminaron únicamente estas inscripciones de la tabla `enrollments`, sin modificar las tablas `students` ni `courses`.

## Q9 - Número de inscripciones por categoría

Después de realizar las correcciones, conté cuántas inscripciones había en cada categoría.

**Resultado: 16 inscripciones.**

| Categoría | Inscripciones |
|---|---:|
| Programming | 7 |
| Design | 4 |
| Data | 3 |
| Marketing | 2 |
| **Total** | **16** |

Programming es la categoría con más inscripciones, mientras que Marketing tiene menos.

## Q10 - Progreso medio por curso

Calculé el porcentaje medio de completado de cada curso y ordené los resultados de menor a mayor.

**Resultado: 6 cursos.**

| Curso | Progreso medio |
|---|---:|
| UI/UX Fundamentals | 0,00 % |
| Web Design Basics | 32,50 % |
| Digital Marketing 101 | 36,50 % |
| Advanced Python | 45,00 % |
| Data Analysis with SQL | 47,67 % |
| Intro to Python | 80,00 % |

El curso con menor progreso es UI/UX Fundamentals, con un 0 %.

Por otro lado, Intro to Python tiene el mejor resultado, con un progreso medio del 80 %.

## Q11 - Cursos con más de tres inscripciones

Busqué los cursos que tenían más de tres inscripciones registradas.

**Resultado: 1 curso.**

| Curso | Inscripciones |
|---|---:|
| Intro to Python | 4 |

Intro to Python es el único curso que cumple esta condición después de eliminar las cuentas de prueba.

## Q12 - Ingresos totales por categoría

Calculé la suma de las cuotas pagadas que aparecen registradas en cada categoría.

**Resultado: 819,84 € en total.**

| Categoría | Ingresos |
|---|---:|
| Programming | 409,93 € |
| Data | 179,97 € |
| Design | 169,96 € |
| Marketing | 59,98 € |
| **Total** | **819,84 €** |

Programming es la categoría con la mayor cantidad registrada, mientras que Marketing tiene la menor.

Estos importes corresponden a la suma del campo `monthly_fee_paid` de las inscripciones, no a una estimación de ingresos futuros.

## Conclusiones

Después de revisar la base de datos, estos son los principales resultados:

- Encontré 4 inscripciones con menos del 10 % de progreso.
- Había 2 inscripciones sin instructor.
- Añadí 1 inscripción que faltaba.
- Actualicé los 2 registros sin instructor.
- Eliminé 2 inscripciones de prueba.
- Después de las correcciones quedaron 16 inscripciones.

También comparé el progreso medio de las categorías:

| Categoría | Progreso medio |
|---|---:|
| Programming | 65,00 % |
| Data | 47,67 % |
| Marketing | 36,50 % |
| Design | 16,25 % |

La categoría con peor resultado es Design, con un 16,25 % de progreso medio. Creo que sería conveniente revisar estos cursos para entender por qué los estudiantes tienen tan poco progreso.

En cuanto a los ingresos registrados, Programming es la categoría con la mayor cantidad, con 409,93 €.

En general, este ejercicio me ha servido para practicar consultas SQL, trabajar con registros de una base de datos y utilizar funciones como `COUNT`, `AVG` y `SUM`.

También he visto la importancia de comprobar los datos antes de sacar conclusiones, porque los registros incompletos y las cuentas de prueba pueden afectar a los resultados.
