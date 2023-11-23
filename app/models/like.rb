class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # Callback to update the likes counter for a post
  after_create :increment_post_likes_counter

  private

  def increment_post_likes_counter
    post.increment!(:likes_counter)
  end
end
