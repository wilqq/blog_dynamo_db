class Post < ApplicationRecord
  TABLE_NAME = 'posts'

  class << self
    def create(params)
      item = {
        uuid: 'b33fdc50-4743-4961-90c6-b99c6f7259ce',
        title: params['title'],
        body: params['body'],
        user_email: params['user'][:email],
        user: {
          first_name: params['user'][:first_name],
          last_name: params['user'][:last_name],
        },
        created_at: '1520350652',
      }

      client.put_item({
        item: item,
        table_name: TABLE_NAME,
      })
    end

    def all
      client.scan({
        table_name: TABLE_NAME,
      }).items
    end

    def find_by_uuid(uuid)
      client.get_item({
        key: {
          uuid: uuid
        },
        table_name: TABLE_NAME,
      }).item
    end

    def all_for_user_email(user_email)
      client.query({
        expression_attribute_values: {
          ':user_email' => user_email,
        },
        key_condition_expression: 'user_email = :user_email',
        table_name: TABLE_NAME,
        index_name: 'user_email-created_at-index'
      }).items
    end
  end
end
