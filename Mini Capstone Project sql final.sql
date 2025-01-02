use mavenmovies;
-- 1. Rental Trends:

-- 1.a Analyze the monthly rental trends over the available data period.
select 
	date_format(rental_date,'%y-%m') as monthly_rentals,
    count(rental_id) as total_rentals 
from rental
group by 
	monthly_rentals
order by 
	total_rentals asc;


-- 1.b Determine the peak rental hours in a day based on rental transactions.
select 
    count(rental_id) as total_rentals,hour(rental_date) as rental_hour
from 
    rental
group by
   rental_hour                      
order by
    total_rentals desc
    limit 1;              
                           
--  2. Film Popularity:	

-- Identify the top 10 most rented films.
select 
	film.title,
    film.film_id,
	count(rental.rental_id) as no_of_times_rented 
from 
	rental 
  join inventory on inventory.inventory_id=rental.inventory_id
  join film on film.film_id=inventory.film_id
group by 
	title,film.film_id
order by 
	no_of_times_rented desc
limit 10;


-- Determine which film categories have the highest number of rentals.
select 
	category.name as category,count(*) as rental_count
	from category  left join film_category on category.category_id=film_category.category_id
	left join inventory on inventory.film_id=film_category.film_id
    left join rental on inventory.inventory_id=rental.inventory_id
    group by category.name
	order by rental_count desc;

-- 3. Store Performance:

-- Identify which store generates the highest rental revenue.
select 
	store.store_id,
    sum(amount) as rental_revenue from store 
left join staff on store.store_id=staff.store_id
left join payment on payment.staff_id=staff.staff_id
group by 
	store.store_id
order by 
	rental_revenue desc
;


-- Determine the distribution of rentals by staff members to assess performance.
select 
    staff.first_name,last_name,staff.staff_id,
    count(rental_id) as total_rentals
from
    rental  join staff on rental.staff_id=staff.staff_id
group by
    staff.first_name,last_name,staff_id
order by 
    total_rentals desc;












