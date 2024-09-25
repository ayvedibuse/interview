select * from users;

-- US01-1
   -- OPT 1
    select count(id) from users;           -- 138  -- ACTUAL
    select  count(distinct id) from users; -- 138  -- EXPECTED

   -- OPT 2
    select id from users;
    -- getAllColumnAsList --> List --> size  --> EXPECTED
    -- getAllColumnAsList --> Set  --> size  --> EXPECTED
    select * from users;

select count(*) from book_borrow where is_returned=0;

select name from book_categories;

select * from books where name = 'Clean Code';
select b.name as name, b.isbn as isbn, b.year as year, b.author as author,
       bc.name as bookCategory, b.description as description
from books b left join book_categories bc on b.book_category_id = bc.id
where b.name = 'Clean Code';

select count(*), bc.name as categoryName from book_borrow bb left join books b on bb.book_id = b.id
left join book_categories bc on b.book_category_id = bc.id
group by categoryName
order by count(*) DESC
limit 1;
