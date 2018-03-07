class User < ApplicationRecord
  TABLE_NAME = 'users'

  class << self
    def create(params)
      item = {
        email: params['email'],
        first_name: params['first_name'],
        last_name: params['last_name'],
      }

      client.put_item({
        item: item,
        table_name: TABLE_NAME,
      })
    end

    def find_by_email(email)
      client.get_item({
        key: {
          email: email
        },
        table_name: TABLE_NAME,
      }).item
    end
  end
end
