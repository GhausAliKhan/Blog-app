require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it 'validates presence of title' do
      post = Post.new(title: '', text: 'Lorem ipsum', comments_counter: 0, likes_counter: 0)
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include("can't be blank")
    end

    it 'validates length of title' do
      post = Post.new(title: 'a' * 251, text: 'Lorem ipsum', comments_counter: 0, likes_counter: 0)
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include('is too long (maximum is 250 characters)')
    end

    it 'validates numericality of comments_counter' do
      post = Post.new(title: 'Valid Title', text: 'Lorem ipsum', comments_counter: -1, likes_counter: 0)
      expect(post).not_to be_valid
      expect(post.errors[:comments_counter]).to include('must be greater than or equal to 0')
    end

    it 'validates numericality of likes_counter' do
      post = Post.new(title: 'Valid Title', text: 'Lorem ipsum', comments_counter: 0, likes_counter: -1)
      expect(post).not_to be_valid
      expect(post.errors[:likes_counter]).to include('must be greater than or equal to 0')
    end
  end

  describe 'methods' do
    describe '#recent_comments' do
      before(:each) do
        @user = User.create!(name: 'Jane Doe', posts_counter: 0)
        @post = @user.posts.create!(title: 'Sample Post', text: 'This is a sample post', comments_counter: 0, likes_counter: 0)
        6.times do |i|
          comment = @post.comments.create!(user: @user, text: "Comment #{i}", created_at: Time.now + i.seconds)
          puts "Failed to save comment: #{comment.errors.full_messages.join(', ')}" if comment.new_record?
        end
      end

      it 'checks if all comments are saved' do
        expect(@post.comments.count).to eq(6)
      end

      it 'returns the 5 most recent comments' do
        recent_comments = @post.recent_comments
        expect(recent_comments.count).to eq(5)
        expected_comments = @post.comments.order(created_at: :desc).limit(5)
        expect(recent_comments).to match_array(expected_comments)
      end
    end
  end
end
