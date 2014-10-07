Opinionated Syntax Highlighting For PostgreSQL In Vim!
====

I started with Devrim Gunduz' psql.vim at http://www.gunduz.org/postgresql/pgsql.vim, but very little of that remains. This is PG highlighting the way I use it. It may be useful to you, it may not. I suspect it will work very well for most, and if not, it's not too hard to fork.

Some improvements:

Syntax Highlighting For Function Bodies
----

    CREATE FUNCTION foo(_x INTEGER) RETURNS INTEGER
    STRICT IMMUTABLE
    AS $$
    BEGIN
    	RETURN _x;
    END;
    $$;

The text inside the $$ delimiters will be highlighted. Of course, the syntax highlighting is _always_ more PostgreSQL highlighting, since that's all I ever use. (I've considered conventions such as $PYTHON$ or $PGSQL$ with $PGSQL$ being the default, but since I don't use Python in PG, I never had the motivation.) 

A Broader Set Of Keywords
----

I've done a good, but probably imperfect job of adding far more keywords and trying to get them to work contextually.

Variables
---

One of the things I've always liked about Microsoft's SQL Server is the @ sigil it uses for variables. This makes them stand out and prevents collisions with field names. Sadly, PG has no such sigil, and its parser won't allow you to use one. As a compromise, I always prefix my variables with an underscore, e.g., \_foo. _If you do this, you will get syntax highlighting for variables._ They will stand out nicely, depending upon your color scheme. 

