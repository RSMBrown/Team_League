 class MatchTournamentService
  def initialize(tournament)
    @tournament = tournament 
  end

  def self.all_teams(tournament)
    @all_matches = []
    @all_ids = tournament.all_teams_matches
    @all_ids.each do |id|
        id.to_i
        match = MatchTournament.find(id)
        @all_matches.push(match)
    end 
    return @all_matches  
  end 

  def self.semi_finals(tournament)
    @semi_finals = []
    @all_ids = tournament.semi_finals_matches
    @all_ids.each do |id|
        id.to_i
        match = MatchTournament.find(id)
        @semi_finals.push(match)
    end 
    return @semi_finals  
  end 

  def self.finals(tournament)
    @final = []
    @id = tournament.finals_matches
    if @id != []
        @id = @id.first.to_i
        match = MatchTournament.find(@id)
        @final.push(match)
    end 
    return @final
  end 

  def self.winner(tournament)
    @final_match_id = tournament.finals_matches
    if @final_match_id != []
        id = @final_match_id.first.to_i
        @final_match = MatchTournament.find(id)
        winner = @final_match.winner
    end 

    tournament.update(final_winner: winner)
  end 

  def self.create_all(tournament)
    @all_team_ids = tournament.team_ids

    @all_teams = []
    @all_team_ids.each do |id|
        team = Team.find(id)
        @all_teams.push(team.name)
    end 

    len = @all_teams.length 
    range = (0..len-2).step(2)
    @matches = []

    for i in range
        @match_tournament = tournament.match_tournaments.create

        @match_tournament.update(team_one: @all_teams[i])
        @match_tournament.update(team_two: @all_teams[i + 1])
        @matches.push(@match_tournament)
    end 

    @matches_ids = []
    @matches.each do |match|
        @matches_ids.push(match.id)
    end 

    tournament.update(all_teams_matches: @matches_ids)
  end 

  def self.create_semi_finals(tournament)
    @all_team_ids = tournament.all_teams_matches

    @all_team_matches = []
    @all_team_ids.each do |id|
        id.to_i
        match = MatchTournament.find(id)
        @all_team_matches.push(match)
    end

    len = @all_team_matches.length 
    range = (0..len-2).step(2)
    @matches = []

    for i in range 
        @match_tournament = tournament.match_tournaments.create

        team_one = @all_team_matches[i].winner
        team_two = @all_team_matches[i + 1].winner
        @match_tournament.update(team_one: team_one)
        @match_tournament.update(team_two: team_two)
        @matches.push(@match_tournament)
    end 

    @matches_ids = []
    @matches.each do |match|
        @matches_ids.push(match.id)
    end 

    tournament.update(semi_finals_matches: @matches_ids)
  end 

  def self.create_finals(tournament)
    @semi_final_ids = tournament.semi_finals_matches
    @semi_final_matches = []
    @semi_final_ids.each do |id|
        id.to_i
        match = MatchTournament.find(id)
        @semi_final_matches.push(match)
    end 

    @match = []

    @match_tournament = tournament.match_tournaments.create

    team_one = @semi_final_matches[0]
    team_two = @semi_final_matches[1]

    @match_tournament.update(team_one: team_one.winner)
    @match_tournament.update(team_two: team_two.winner)
    @match.push(@match_tournament)

    @match_id = []
    @match.each do |match|
        @match_id.push(match.id)
    end 

    tournament.update(finals_matches: @match_id)
  end
end