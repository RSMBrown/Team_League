class Team < ApplicationRecord
    has_many :players 
    has_many :team_tournaments
    has_many :tournaments, through: :team_tournaments
    has_many :match_teams
    has_many :matches, through: :match_teams
end
