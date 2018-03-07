class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  class << self
    def client
      @client ||= Aws::DynamoDB::Client.new
    end
  end
end
