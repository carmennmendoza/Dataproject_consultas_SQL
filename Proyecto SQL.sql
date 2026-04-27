-- 2. Muestra los nombres de todas las películas con una clasificación por edades de ‘R’

select 
	f.title , 
	f.rating 
from film f  
where rating = 'R' ;


--3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.

select *
from actor a
where a.actor_id BETWEEN 30 and 40;

--4. Obtén las películas cuyo idioma coincide con el idioma original. 

select *
from film
where language_id is null and original_language_id is null; -- Todos los campos del "original_language" son NULL por lo tanto no devuelve resultados

--5. Ordena las películas por duración de forma ascendente.

select 
	title, 
	length 
from film f
order by f.length asc ;



--6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.

select 
	a.first_name , 
	a.last_name 
from actor a
where a.last_name = 'ALLEN';


--7. Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.

select 
	count(film_id) as recuento, 
	f.rating as clasificacion
from film f 
group by f.rating ;

--8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.

select 
	f.title , 
	rating, 
	f.length 
from film f 
where f.length > 180
or
rating = 'PG-13'
order by length desc;

--9. Encuentra la variabilidad de lo que costaría reemplazar las películas.

SELECT 
	VARIANCE(replacement_cost) AS varianza_total
FROM film;

--10. Encuentra la mayor y menor duración de una película de nuestra BBDD.

select 
	MAX(length) as mayor_duracion, 
	MIN (f.length) as menor_duracion
from film f ;


--11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.

select r.rental_date , 
from rental r  
order by r.rental_date;


SELECT 
	f.title, 
	p.amount, 
	p.payment_date
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
ORDER BY p.payment_date DESC
LIMIT 1 OFFSET 2;

SELECT 
    r.rental_date,
    f.title,
    f.rental_rate as costo_alquiler
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
ORDER BY r.rental_date DESC
LIMIT 1 OFFSET 2;


--12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-17’ ni ‘G’ en cuanto a su clasificación.

SELECT 
	title, 
	rating
FROM film
WHERE rating NOT IN ('NC-17', 'G');


--13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con elpromedio de duración.

select 
	AVG(length) as promedio_duración, 
	rating
from film
group by rating;


--14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.

select 
	title, 
	length
from film
where length > 180;


--15. ¿Cuánto dinero ha generado en total la empresa?

select 
	SUM(amount) as total_ingresos
from payment;

--16. Muestra los 10 clientes con mayor valor de id.

select 
	CONCAT(c.first_name ,' ', c.last_name) as nombre_completo_cliente, 
	c.customer_id 
from customer c 
order by c.customer_id desc
limit 10;


--17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.

select 
	CONCAT(a.first_name, ' ', a.last_name) as nombre_actores
from actor a
join film_actor fa on a.actor_id = fa.actor_id 
join film f on fa.film_id = f.film_id 
where f.title = 'EGG IGBY';


--18. Selecciona todos los nombres de las películas únicos.

select distinct f.title 
from film f ;


--19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.

select 
	f.title , 
	c."name" as category, 
	f.length 
from film f 
join film_category fc on f.film_id = fc.film_id 
join category c  on fc.category_id   = c.category_id 
where 
	c.category_id = 5
	and f.length > 180;


--20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.
	
select 
	c."name" as category, 
	ROUND(AVG(f.length), 2) as promedio_duracion
from film f 
join film_category fc on f.film_id = fc.film_id 
join category c  on fc.category_id   = c.category_id 
group by c."name" 
having AVG(f.length) > 110;


--21. ¿Cuál es la media de duración del alquiler de las películas?

select 
	AVG(rental_duration ) as media_duracion_alquiler
from film;

--22. Crea una columna con el nombre y apellidos de todos los actores y actrices.

select 
	CONCAT(first_name , ' ', last_name) as nombre_completo
from actor;


--23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.

select 
	DATE(rental_date) as dia, 
	COUNT(*) as total_por_dia
from rental
group by DATE(rental_date)
order by total_por_dia desc;

--24. Encuentra las películas con una duración superior al promedio.

select 
	title, 
	length
from film
where 	
	length > (select AVG(length) from film);

--25. Averigua el número de alquileres registrados por mes.

select 
    extract(month from rental_date) as month,
    COUNT(*) as total_alquileres
from rental
group by extract(month from rental_date)
order by month;


--26.Encuentra el promedio, la desviación estándar y varianza del total pagado.

select 
	ROUND(avg(amount), 2) as promedio, 
	ROUND(stddev(amount), 2) as desviacion_std,
	ROUND(variance(amount), 2)as varinaza
from payment;


--27. ¿Qué películas se alquilan por encima del precio medio?

select 
	title, 
	rental_rate
from film
where 	
	rental_rate > (select AVG(rental_rate) from film);


--28. Muestra el id de los actores que hayan participado en más de 40 películas.

select 
	actor_id, 
	COUNT(fa.film_id) as total_pelis
from film_actor fa
group by actor_id 
having COUNT(fa.film_id) > 40;
 

--29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.

select 
	f.title, 
	f.film_id , 
	COUNT(i.film_id) as cantidad_disp 
from film f 
left join inventory i on f.film_id = i.film_id
group by f.title , f.film_id ;


--30. Obtener los actores y el número de películas en las que ha actuado.

select 
	CONCAT(a.first_name, '  ', a.last_name) as nombre_actor, 
	count(fa.film_id )  
from actor a 
left join film_actor fa on a.actor_id = fa.actor_id 
group by a.actor_id , a.first_name , a.last_name ;



--31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.

select 
	f.title, 
	CONCAT(a.first_name , ' ', a.last_name) as nombre_actor
from film f
left join film_actor fa on f.film_id = fa.film_id 
left join actor a on a.actor_id  = fa.actor_id ;

--32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.

select 
    CONCAT(a.first_name, ' ', a.last_name) as nombre_actor, 
    f.title as titulo_pelicula
from actor a
left join film_actor fa on a.actor_id = fa.actor_id
left join film f on fa.film_id = f.film_id
group by a.first_name, a.last_name, f.title;


--33. Obtener todas las películas que tenemos y todos los registros de alquiler.

select 
    f.title, 
    COUNT(distinct i.inventory_id) as total_inventario, 
    COUNT(r.rental_id) as total_alquileres
from film f 
left join inventory i on f.film_id = i.film_id
left join rental r on r.inventory_id = i.inventory_id 
group by f.title;



--34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.

select 
	CONCAT(c.first_name, ' ', c.last_name) as nombre_cliente,
	p.amount
from customer c 
join payment p on c.customer_id = p.customer_id 
group by c.first_name , c.last_name, p.amount 
order by p.amount desc
limit 5;


--35. Selecciona todos los actores cuyo primer nombre es ' Johnny'.

select 
	a.first_name , 
	a.last_name 
from actor a 
where a.first_name = 'JOHNNY';

--36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.

select 
	first_name as Nombre,
	last_name as Apellido
from actor;

--37. Encuentra el ID del actor más bajo y más alto en la tabla actor.

select 
	MIN(actor_id) as min_ID,
	MAX(actor_id) as max_ID
from actor;

--38. Cuenta cuántos actores hay en la tabla “actor”

select 
	COUNT(actor_id) as total_actores
from actor;


--39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.

select 
	first_name as nombre, 
	last_name as apellido
from actor
order by last_name asc;

--40. Selecciona las primeras 5 películas de la tabla “film”

select 
	title
from film
limit 5;

--41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?

select 
	first_name,
	count(*) as total_actores
from actor 
group by first_name
order by total_actores desc; 

--42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.

select 
	r.rental_date, 
	r.rental_id, 
	c.first_name, 
	c.last_name 
from customer c 
join rental r on c.customer_id = r.customer_id ;


--43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.

SELECT 
    c.first_name, 
    c.last_name, 
    r.rental_id, 
    r.rental_date
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id;


--44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.


select *
from film f 
cross join category c ;

/*
COMENTARIO: 
No, no aporta valor real.
Crea datos inventados: El CROSS JOIN une cada película con todas las categorías que existen. 
Muestra que una película de dibujos animados es también de "Terror", "Documental" y "Acción", aunque no sea cierto.
Es puro cálculo matemático: No consulta la relación real de la base de datos; simplemente multiplica las filas. 
Si tienes 1,000 películas y 16 categorías, te genera 16,000 filas de combinaciones aleatorias.
En resumen: Solo sirve para ver "qué pasaría si todas las películas pertenecieran a todas las categorías", 
pero no sirve para sacar un informe real del catálogo.
*/


--45. Encuentra los actores que han participado en películas de la categoría 'Action'.

select distinct
	CONCAT (first_name, ' ', last_name) as nombre_actor
from actor a
join film_actor fa on a.actor_id = fa.actor_id 
join film_category fc on fa.film_id = fc.film_id 
join category c on fc.category_id = c.category_id 
where c."name" = 'Action'
order by nombre_actor asc;


--46. Encuentra todos los actores que no han participado en películas.

select 
    CONCAT(a.first_name, ' ', a.last_name) as nombre_actor
from actor a
left join film_actor fa on a.actor_id = fa.actor_id 
where fa.actor_id is null
order by nombre_actor asc;


--47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.

select  
    CONCAT(a.first_name, ' ', a.last_name) as nombre_actor,
    COUNT(fa.actor_id) as total_peliculas -- Aquí está el truco
from actor a
left join film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id, a.first_name, a.last_name
order by total_peliculas asc;


--48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado.

create view actor_num_peliculas as 
select  
    CONCAT(a.first_name, ' ', a.last_name) as nombre_actor,
    COUNT(fa.actor_id) as total_peliculas 
from actor a
left join film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id, a.first_name, a.last_name;

select * 
from actor_num_peliculas;

--49. Calcula el número total de alquileres realizados por cada cliente.

select
	c.customer_id, 
	CONCAT(c.first_name, ' ', c.last_name) as nombre_cliente, 
	COUNT(r.rental_id ) as total_alquileres
from customer c
left join rental r on c.customer_id = r.customer_id 
group by c.customer_id 
order by c.customer_id , total_alquileres ;


--50. Calcula la duración total de las películas en la categoría 'Action'.

select 
    SUM(f.length) AS duracion_total
from film f
join film_category fc ON f.film_id = fc.film_id
join category c ON fc.category_id = c.category_id
where c.name = 'Action';

--51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.


CREATE TEMPORARY TABLE cliente_rentas_temporal as
select
	c.customer_id, 
	CONCAT(c.first_name, ' ', c.last_name) as nombre_cliente, 
	COUNT(r.rental_id ) as total_alquileres
from customer c
left join rental r on c.customer_id = r.customer_id 
group by c.customer_id;


SELECT * FROM cliente_rentas_temporal;


--52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces.


select 
	f.title,
	COUNT(r.rental_id) as total_alquileres
from film f 
join inventory i on f.film_id = i.film_id 
join rental r on i.inventory_id = r.inventory_id 
group by f.film_id , f.title 
having COUNT(r.rental_id) >= 10;


--53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.

select
	title
from film f 
join inventory i on f.film_id = i.film_id 
join rental r on i.inventory_id = r.inventory_id 
join customer c on r.customer_id = c.customer_id 
where c.first_name = 'TAMMY' 
	and c.last_name = 'SANDERS'
	and r.return_date is null
order by title asc;



--54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados alfabéticamente por apellido.

select distinct 
	a.first_name, 
	a.last_name
from actor a
join film_actor fa on a.actor_id = fa.actor_id 
join film f on fa.film_id = f.film_id 
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
where c.name = 'Sci-Fi'
order by a.last_name asc;


--55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaper’ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.


select distinct
	a.first_name,
	a.last_name 
from actor a
join film_actor fa on a.actor_id = fa.actor_id 
join inventory i on fa.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id 
where r.rental_date > (
	select MIN(r2.rental_date)
	from rental r2
	join inventory i2 on r2.inventory_id = i2.inventory_id
	join film f2 on i2.film_id = f2.film_id
	where f2.title  = 'SPARTACUS CHEAPER'
)
order by a.last_name asc;

	
--56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.

select
	a.first_name,
	a.last_name
from actor a
where a.actor_id not in (
	select fa.actor_id
    from film_actor fa
    join film_category fc on fa.film_id = fc.film_id
    join category c on fc.category_id = c.category_id
    where c.name = 'Music');


--57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.

select distinct
	f.title 
from film f
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
where extract(day from (r.return_date - r.rental_date)) > 8;
--Le he puesto distinct porque una peli se puede aliquilar muchas veces entonces me salían varios nombres repetidos.


--58. Encuentra el título de todas las películas que son de la misma categoríaque ‘Animation’.


select 
    f.title
from film f
join film_category fc on f.film_id = fc.film_id
where fc.category_id = (
    select category_id 
    from category 
    where name = 'Animation'
);


--59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’. Ordena los resultados alfabéticamente por título de película.


select 
    title
from film
where length = (
    select length 
    from film 
    where title = 'DANCING FEVER'
)
and title != 'DANCING FEVER'
order by title asc;


--60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.


select 
	c.first_name, 
	c.last_name 
from customer c 
join rental r on c.customer_id = r.customer_id
join inventory i on r.inventory_id = i.inventory_id
group by c.customer_id, c.first_name, c.last_name
having count(distinct i.film_id) >= 7
order by c.last_name asc;


--61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

select 
    c.name as categoria,
    count(r.rental_id) as total_alquileres
from category c
join film_category fc on c.category_id = fc.category_id
join film f on fc.film_id = f.film_id
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
group by c.name
order by total_alquileres desc;


--62. Encuentra el número de películas por categoría estrenadas en 2006.

select 
    c.name as categoria, 
    count(f.film_id) as total_estrenos
from category c
join film_category fc on c.category_id = fc.category_id
join film f on fc.film_id = f.film_id
where f.release_year = '2006'
group by c.name, f.release_year ;


--63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.

select 
    s.first_name, 
    s.last_name, 
    st.store_id
from staff s
cross join store st;


--64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.

select 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    count(r.rental_id) as total_alquileres
from customer c
join rental r on c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name
order by total_alquileres asc;





