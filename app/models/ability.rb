class Ability
  include CanCan::Ability

  def initialize(user)

    if user.permissions.include?('contributions')
      can :read, ActiveAdmin::Page, :name => "Contributers"
      can :no_email_breakdown, ActiveAdmin::Page, :name => "Contributers"
      can :manage, Contribution
      can :manage, ContributerEmailAddress
      can :manage, SummaryEmail
    end

    can :manage, AdminUser if user.permissions.include?('admin_users')
    can :manage, AdminUser, :id => user.id

    can :manage, Person
    can :manage, Activity
    can :manage, Import

    can :read, ActiveAdmin::Page, :name => "Dashboard"
  end

end
