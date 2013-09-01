class Post < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  validates :title, presence: true

  after_validation :generate_slug

  def total_votes
    self.votes.where(vote: true).size - self.votes.where(vote: false).size
  end

  def generate_slug
    self.slug = self.title.gsub(" ", "-").downcase
  end

  def to_param
    self.slug
  end
end
