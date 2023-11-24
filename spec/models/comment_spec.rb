require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'callbacks' do
    before(:each) do
      @user = User.create!(name: 'Jane Doe', posts_counter: 0)
      @post = @user.posts.create!(title: 'Sample Post', text: 'This is a sample post', comments_counter: 0,
                                  likes_counter: 0)
    end

    it 'increments the post comments_counter after creating a comment' do
      expect { @post.comments.create!(user: @user, text: 'Sample Comment') }.to change {
                                                                                  @post.reload.comments_counter
                                                                                }.by(1)
    end
  end
end