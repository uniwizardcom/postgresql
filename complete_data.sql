
-- Complete an authors data
insert into public.authors (authors_first_name,authors_surname)
values ('a1','an1'),
       ('a2','an2'),
       ('a3','an3'),
       ('a4','an4'),
       ('a5','an5'),
       ('a6','an6'),
       ('ax1','anx1'),
       ('a7','an7'),
       ('a8','an8'),
       ('a9','an9'),
       ('ax2','anx2'),
       ('a10','an10'),
       ('a11','an11'),
       ('a12','an12')
;

-- Complete a book data
with book_data (auth_first_name, title, iban, publ_year) as (values
                                                                 ('a1', 'title-01', '1234-678-01-3', 2001),
                                                                 ('a1', 'title-02', '1234-678-02-3', 2002),
                                                                 ('a2', 'title-03', '1234-678-03-3', 2003),
                                                                 ('a2', 'title-04', '1234-678-04-3', 2004),
                                                                 ('a3', 'title-05', '1234-678-05-3', 2005),
                                                                 ('a3', 'title-06', '1234-678-06-3', 2006),
                                                                 ('a4', 'title-07', '1234-678-07-3', 2007),
                                                                 ('a4', 'title-08', '1234-678-08-3', 2008),
                                                                 ('a5', 'title-09', '1234-678-09-3', 2009),
                                                                 ('a5', 'title-10', '1234-678-10-3', 2010),
                                                                 ('a6', 'title-11', '1234-678-11-3', 2011),
                                                                 ('a6', 'title-12', '1234-678-12-3', 2012),
                                                                 ('a7', 'title-13', '1234-678-13-3', 2013),
                                                                 ('a7', 'title-14', '1234-678-14-3', 2014),
                                                                 ('a8', 'title-15', '1234-678-15-3', 2015),
                                                                 ('a9', 'title-16', '1234-678-16-3', 2016),
                                                                 ('a10', 'title-17', '1234-678-17-3', 2017),
                                                                 ('a10', 'title-18', '1234-678-18-3', 2018),
                                                                 ('a11', 'title-19', '1234-678-19-3', 2019),
                                                                 ('a11', 'title-20', '1234-678-20-3', 2020),
                                                                 ('a12', 'title-21', '1234-678-21-3', 2021),
                                                                 ('a12', 'title-22', '1234-678-22-3', 2022)
)
insert into public.books (books_author_id, books_title, books_iban, books_publication_year)
select
    a.authors_id,
    book_data.title,
    book_data.iban,
    book_data.publ_year
from public.authors a
left join book_data on book_data.auth_first_name = a.authors_first_name
;

-- Generating a reviews ratings for 10 repetitions of randomized books collections
do
$$
	begin
		for i in 1..10 loop
            with book as (
                select books_id as book_id from public.books order by random()
            )
            insert into public.reviews (reviews_books_id, reviews_rating, reviews_content)
			select
			    b.book_id,
			    1 + trunc(random() * 10)::int,
			    'Review ' || trunc(random()*10 * 2 + 10)
			from book b;
		end loop;
	end;
$$
;
