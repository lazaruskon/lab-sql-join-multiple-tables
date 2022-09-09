-- Lab | SQL Joins on multiple tables --
use sakila;

	-- Write a query to display for each store its store ID, city, and country.
select * from store;
select * from address;
select * from city;
select * from country; #identifying which tables we need

select s.store_id, ci.city, co.country from store s
join address a
on s.address_id = a.address_id
join city ci
on ci.city_id = a.city_id
join country co
on ci.country_id = co.country_id;

    -- Write a query to display how much business, in dollars, each store brought in.
select * from store;
select * from payment;
select * from staff; -- I thought I would need this but I don't think I do actually

select s.store_id, sum(p.amount) as total_amount from store s
join payment p
on p.staff_id = s.manager_staff_id
group by s.store_id;

    -- What is the average running time of films by category?
select * from film;
select * from film_category;
select * from category;

select c.category_id, c.name, avg(f.length) as average_running_time from film_category fc
join film f
on f.film_id = fc.film_id
join category c
on c.category_id = fc.category_id
group by c.category_id;

    -- Which film categories are longest?
select c.category_id, c.name, avg(f.length) as average_running_time from film_category fc
join film f
on f.film_id = fc.film_id
join category c
on c.category_id = fc.category_id
group by c.category_id
order by avg(f.length) desc
limit 5; #top 5 longest categories are sports, games, foreign, drama, comedy.


    -- Display the most frequently rented movies in descending order.
select * from rental;
select * from inventory;
select * from film;

select f.film_id, f.title, count(r.inventory_id) as frequency from film f
join inventory i
on f.film_id = i.film_id
join rental r
on i.inventory_id = r.inventory_id
group by f.film_id
order by frequency desc
limit 5; #top 5 most rented movies are BUCKET BROTHERHOOD, ROCKETEER MOTHER, GRIT CLOCKWORK, FORWARD TEMPLE and JUGGLER HARDLY.

    -- List the top five genres in gross revenue in descending order.
select * from payment;
select * from rental;
select * from inventory;
select * from film_category;
select * from category;

select c.name, count(p.amount) as gross_revenue from category c
join film_category fc
on c.category_id = fc.category_id
join inventory i 
on i.film_id = fc.film_id
join rental r
on r.inventory_id = i.inventory_id
join payment p
on p.rental_id = r.rental_id
group by c.name
order by gross_revenue desc
limit 5 #top 5 most rented movies are Sports, Animation, Action, SciFi, Family
;

    -- Is "Academy Dinosaur" available for rent from Store 1?
select * from film;
select * from inventory;
select * from rental;
select * from payment; -- checking potentially useful tables

select f.title, i.store_id, count(i.film_id) as copies_of_film from film f
join inventory i
on i.film_id = f.film_id
where i.film_id = 1 and i.store_id = 1; 
# We now know that store 1 has 4 copies of "Academy Dinosaur".

select * from rental where inventory_id < 5 order by return_date desc limit 5; -- this query is also showing the rental history of these 4 copies
-- considering that the last update was in February 2006 and that there were two copies returned on August the 30th we could infer that there are copies available to rent.

