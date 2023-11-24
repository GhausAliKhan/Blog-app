require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'callbacks' do
    it 'increments the post likes_counter after creating a like' do
      user = User.create!(name: 'John Doe', posts_counter: 0)
      post = user.posts.create!(title: 'Sample Post', text: 'This is a sample post', comments_counter: 0,
                                likes_counter: 0)
      expect { post.likes.create!(user:) }.to change { post.reload.likes_counter }.by(1)
    end
  end
end
