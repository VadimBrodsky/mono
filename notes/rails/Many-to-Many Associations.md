# Many-to-Many Associations

Two tables are connected to multiple rows on both sides, categories and articles in a blog.

The has_and_belongs_to_many (habtm) association works by relying on a join table that keeps a reference to the foreign keys involved in the relationship.

The table name is formed from the names of each table in alphabetical order, separated by an underscore.
