# Enhancing the Models: Declaring Associations

Model associations are creating using methods:

- `has_one`
- `has_many`
- `belongs_to`
- `has_and_belongs_to_many`

```ruby
class Message < ActiveRecord::Base
  has_many :attachments
end

class Attachment < ActiveRecord::Base
  belongs_to :message
end
```

Active Record expects to find a table called attachments that has a field `message_id`. Associations work in both directions `Message.first.attachments` and `Attachment.first.message`.
