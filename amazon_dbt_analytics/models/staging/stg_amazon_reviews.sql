with cleaned as (
	select
		product_id,
		product_name,
		category,
		replace(trim('₹' from discounted_price), ',', '')::decimal(10,2) as discounted_price,
		replace(trim('₹' from actual_price), ',', '')::decimal(10,2) as actual_price,
		(trim('%' from discount_percentage)::decimal(10,4) / 100) as discount_percentage,
		rating::decimal(5,4) as rating,
		(replace(rating_count, ',' , '')::int) as rating_count,
		product_description,
		user_id,
		user_name,
		review_id,
		review_title,
		review_content
	from {{ source('amazon_reviews','raw_amazon_reviews') }}
	where product_id is not null
	and (rating is not null and rating not like '%|%')
	and user_id is not null
	and review_id is not null
) select * from cleaned

