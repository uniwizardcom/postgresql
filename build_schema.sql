
CREATE TABLE public.authors (
                                authors_id bigserial NOT NULL,
                                authors_first_name varchar NOT NULL,
                                authors_surname varchar NOT NULL,
                                CONSTRAINT authors_id_pk PRIMARY KEY (authors_id)
);

CREATE TABLE public.books (
                              books_id bigserial NOT NULL,
                              books_author_id bigint NOT NULL,
                              books_title varchar NOT NULL,
                              books_iban char(13) NOT NULL,
                              books_publication_year int NOT NULL DEFAULT 0,
                              CONSTRAINT books_id_pk PRIMARY KEY (books_id)
);
ALTER TABLE public.books ADD CONSTRAINT books_author_id_fk FOREIGN KEY (books_author_id) REFERENCES public.authors(authors_id);


CREATE TABLE public.reviews (
    reviews_id bigserial NOT NULL,
    reviews_books_id bigint not null,
    reviews_rating int,
    reviews_content varchar NULL,
    CONSTRAINT reviews_id_pkey PRIMARY KEY (reviews_id),
    CONSTRAINT reviews_rating_check check (reviews_rating > 0 and reviews_rating <= 10)
);
ALTER TABLE public.reviews ADD CONSTRAINT reviews_books_id_fk FOREIGN KEY (reviews_books_id) REFERENCES public.books(books_id);

