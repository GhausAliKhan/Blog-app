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
end
