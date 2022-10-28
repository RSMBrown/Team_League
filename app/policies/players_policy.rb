class PlayersPolicy < ApplicationPolicy
  attr_reader :user, :player

  def initialize(user, player)
    @user = user
    @player = player
  end

  def show?
    coordinator?
  end 

  def new?
    coordinator?
  end 

  def create?
    coordinator?
  end 

  def edit?
    coordinator?
  end 

  def update?
    coordinator?
  end 

  def destory? 
    coordinator?
  end 
end
