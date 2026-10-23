# Rich Many-to-Many Associations

If when you are modelling a many-to-many association and need to put additional data on the join model. The `had_and_belongs_to_many` association falls short, because it uses a join table and does not have a model on which to operate.

To achieve this a *rich* many-to-many association using `has_many :through` can be created.
