class Comment < ApplicationRecord
  TABLE_NAME = 'comments'

  class << self
    def create(params)
      item = {
        post_uuid: params[:post_uuid],
        body: params[:body],
        user_email: params[:user]['email'],
        user: {
          first_name: params[:user]['first_name'],
          last_name: params[:user]['last_name'],
        },
        created_at: Time.now.to_i.to_s,
      }

      client.put_item({
        item: item,
        table_name: TABLE_NAME,
      })
    end

    def all_for_post(post_uuid)
      client.query({
        expression_attribute_values: {
          ':post_uuid' => post_uuid,
        },
        key_condition_expression: 'post_uuid = :post_uuid',
        table_name: TABLE_NAME,
      }).items
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
