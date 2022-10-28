class MatchPolicy < ApplicationPolicy
  attr_reader :user, :match

  def initialize(user, match)
    @user = user
    @match = match
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
end
