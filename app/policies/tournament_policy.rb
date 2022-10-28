class TournamentPolicy < ApplicationPolicy
  attr_reader :user, :tournament

  def initialize(user, tournament)
    @user = user
    @tournament = tournament
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
end
