# Dataproject_consultas_SQL

Este repositorio contiene la resolución de **64 ejercicios de SQL** aplicados sobre la base de datos **Shakila**. El objetivo del proyecto es demostrar habilidades en la consulta, filtrado, agregación y manipulación de datos relacionales en un entorno de videoclub.

## 🚀 Tecnologías utilizadas
* **Motor de Base de Datos:** PostgreSQL 
* **Herramienta de Gestión:** DBeaver
* **Lenguaje:** SQL Estándar

## 📊 Resumen del trabajo
A lo largo del proyecto, he trabajado en:
1. **Consultas Básicas:** Selección de actores, películas y clientes.
2. **Filtrado Avanzado:** Uso de `WHERE` e `IN` para segmentar datos.
3. **Joins Complejos:** Conexión de hasta 5 tablas (ej. desde `Category` hasta `Rental`) para obtener informes detallados.
4. **Lógica de Negocio:**
   - Cálculo de duraciones reales de alquiler.
   - Identificación de clientes frecuentes.
   - Análisis de inventario por categoría y año.

## 🛠️ Problemas encontrados y soluciones

### 1. Lógica de Negación (`NOT IN` vs `JOIN`)
* **Problema:** Al intentar encontrar actores que *no* habían actuado en una categoría (ej. 'Music'), el uso de `JOIN` con `!=` devolvía resultados falsos.
* **Solución:** Implementé subconsultas con `NOT IN` para crear una "lista negra" de IDs y filtrar correctamente al resto de actores.

### 2. Diferencias entre motores (MySQL vs PostgreSQL)
* **Problema:** Algunas funciones como `DATEDIFF` no son universales. Al trabajar en PostgreSQL, el motor lanzaba errores de sintaxis.
* **Solución:** Adapté las consultas usando la función de `EXTRACT(DAY FROM ...)`.

### 3. El orden de las fechas
* **Problema:** Al calcular la duración de los alquileres, obtenía resultados negativos o cero.
* **Solución:** Corregí el orden de los operandos en las restas de fechas, asegurando que la fecha de devolución (`return_date`) fuera el minuendo.

## 📈 Ejemplos destacados
He aquí una de las consultas más completas realizadas (Categorías con más alquileres):

select c.name, count(r.rental_id) as total
from category c
join film_category fc on c.category_id = fc.category_id
join inventory i on fc.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
group by c.name
order by total desc;

# Proyecto realizado por Carmen Mendoza Martos con fines académicos.
