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
end
