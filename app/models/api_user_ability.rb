class ApiUserAbility
  include CanCan::Ability

  def initialize(user)
    if user.nil?
      can [:sign_up, :create, :sign_in, :forgot_password], User
      return
    end
    can :read, :all
    can [:update, :notifications], User
  end
end
