class TeamsPolicy < ApplicationPolicy
  attr_reader :user, :team

  def initialize(user, team)
    @user = user
    @team = team
  end

  def index? 
    manager_and_coordinator?
  end 

  def show? 
    manager_and_coordinator?
  end 

  def new?
    manager?
  end 

  def create? 
    manager?
  end 

  def edit?
    manager?
  end 

  def update?
    manager?
  end 

  def update_score? 
    manager?
  end 

  def destroy?
    manager?
  end 
end
