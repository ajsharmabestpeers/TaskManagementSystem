# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
  
    user ||= User.new
    if user.admin?      # Admin can manage all resources
      can :manage, :all
    elsif user.project_manager?  # Author manage own posts (create,edit , update, destroy)
      can :create, Project , user_id: user.id
      can :manage, Project, user_id: user.id
      can :manage, Task, project: { user_id: user.id }
    else
      can :update, Task, user_id: user.id
      cannot :create, Project
      cannot :destroy, Project
    end
  end
  
end
