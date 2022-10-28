class MatchTournamentPolicy < ApplicationPolicy
  attr_reader :user, :match_tournament

  def initialize(user, match_tournament)
    @user = user
    @match_tournament = match_tournament
  end

  def index?
    manager_and_coordinator?
  end 

  def create?
    manager?
  end 

  def create_semi_finals?
    manager?
  end 

  def create_finals?
    manager?
  end 

  def edit?
    manager?
  end 

  def update? 
    manager?
  end 
end
