class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role == 'admin'
      can :manage, :all
    else
      user.role
      can :read, :all
      can %i[update destroy create], Post, author_id: user.id
      can %i[update destroy create], Comment, user_id: user.id
    end
  end
end
