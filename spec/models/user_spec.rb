require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'validates presence of name' do
      user = User.new(name: nil, posts_counter: 0)
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'validates numericality of posts_counter' do
      user = User.new(name: 'John Doe', posts_counter: -1)
      expect(user).not_to be_valid
      expect(user.errors[:posts_counter]).to include('must be greater than or equal to 0')
    end
  end

  describe 'methods' do
    describe '#recent_posts' do
      before(:each) do
        @user = User.create(name: 'John Doe', posts_counter: 0)
        4.times do |i|
          @user.posts.create(title: "Post #{i}", body: "This is post No: #{i}", comments_counter: 0, likes_counter: 0)
        end
      end

      it 'returns the 3 most recent posts' do
        expect(@user.recent_posts.count).to eq(3)
        expect(@user.recent_posts.first.title).to eq('Post 3')
        expect(@user.recent_posts.last.title).to eq('Post 1')
      end
    end
  end
end
