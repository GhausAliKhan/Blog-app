class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  # Attributes
  attribute :title, :string
  attribute :text, :text
  attribute :comments_counter, :integer, default: 0
  attribute :likes_counter, :integer, default: 0

  # Callback to update the posts counter for a user
  after_create :increment_user_posts_counter

  # A method which returns the 5 most recent comments for a given post
  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def increment_user_posts_counter
    author.increment!(:posts_counter)
  end
end
