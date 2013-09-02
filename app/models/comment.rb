class Comment < ActiveRecord::Base
  include VoteableSsk

  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  belongs_to :post

  validates :body, presence: true

end
