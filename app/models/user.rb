class User < ApplicationRecord
    has_many :group_events
    validates :name,:email, presence: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
end
