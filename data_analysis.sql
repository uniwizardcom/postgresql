
-- Books counter of each author
select
    a.authors_first_name as author_first_name,
    a.authors_surname as author_surname,
    count(b.books_id) as books_count
from public.authors a
left join public.books b on b.books_author_id = a.authors_id
group by
    a.authors_first_name ,
    a.authors_surname
;


-- The view (perspective) with top 5 maximum rating average of all books reviews
create or replace view averages as
with averages_table as (
    select
        a.authors_first_name as "author first name",
        a.authors_surname as "author surname",
        avg(r.reviews_rating) as "average value"
    from public.reviews r
    left join public.books b on r.reviews_books_id = b.books_id
    left join public.authors a on b.books_author_id = a.authors_id
    group by
        a.authors_first_name ,
        a.authors_surname
)
select a_t.*
from averages_table a_t
order by a_t."average value" desc
limit 5
;
