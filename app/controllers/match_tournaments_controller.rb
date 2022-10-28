class MatchTournamentsController < ApplicationController

    def index 
        @tournament = Tournament.find(params[:id])
        @match_tournaments = @tournament.match_tournaments.all

        @semi_finals = MatchTournament.semi_finals(@match_tournaments)
        @finals = MatchTournament.finals(@semi_finals)
    end 

    def create 
        @tournament = Tournament.find(params[:id])

        @all_team_ids = @tournament.team_ids

        @all_teams = []
        @all_team_ids.each do |id|
            team = Team.find(id)
            @all_teams.push(team.name)
        end 

        len = @all_teams.length 
        range = (0..len-2).step(2)

        for i in range
            @match_tournament = @tournament.match_tournaments.create(match_tournament_params)

            @match_tournament.update(team_one: @all_teams[i])
            @match_tournament.update(team_two: @all_teams[i + 1])
        end 

        redirect_to match_tournaments_path(id: @tournament.id)
    end 

    def create_semi_finals
        @tournament = Tournament.find(params[:id])

        @semi_final_names = @tournament.semi_finals.uniq

        len = @semi_final_names.length 
        range = (0..len-2).step(2)

        for i in range
            @match_tournament = @tournament.match_tournaments.create(match_tournament_params)

            @match_tournament.update(team_one: @semi_final_names[i])
            @match_tournament.update(team_two: @semi_final_names[i + 1])
        end 

        redirect_to match_tournaments_path(id: @tournament.id)
    end 

    def create_finals
        @tournament = Tournament.find(params[:id])

        @finals_names = @tournament.finals.uniq

        len = @finals_names.length 
        range = (0..len - 2)

        for i in range
            @match_tournament = @tournament.match_tournaments.create(match_tournament_params)

            @match_tournament.update(team_one: @finals_names[i])
            @match_tournament.update(team_two: @finals_names[i + 1])
        end 

        redirect_to match_tournaments_path(id: @tournament.id)
    end 

    def edit 
        @tournament = Tournament.find(params[:tournament_id])
        @match_tournament = @tournament.match_tournaments.find(params[:id])
    end 

    def update 
        @tournament = Tournament.find_by(id: params[:match_tournament][:tournament_id])
        @match_tournament = @tournament.match_tournaments.find(params[:id])

        @semi_finals = []

        @match_tournament.update(team_one_score: params[:match_tournament][:team_one_score], team_two_score: params[:match_tournament][:team_two_score])
        if @match_tournament.team_one_score.to_i > @match_tournament.team_two_score.to_i
            @match_tournament.update(winner: @match_tournament.team_one)
            @semi_finals.push(@match_tournament.team_one)
        elsif @match_tournament.team_one_score.to_i < @match_tournament.team_two_score.to_i
            @match_tournament.update(winner: @match_tournament.team_two)
            @semi_finals.push(@match_tournament.team_two)
        end 

        @tournament.update(semi_finals: @tournament.semi_finals + @semi_finals)

        redirect_to match_tournaments_path(id: @tournament.id)
    end 

    def edit_semi_finals
        @tournament = Tournament.find(params[:tournament_id])
        @match_tournament = @tournament.match_tournaments.find(params[:match_tournament_id])
    end 

    def update_semi_finals
        @tournament = Tournament.find_by(id: params[:match_tournament][:tournament_id])
        @match_tournament = @tournament.match_tournaments.find(params[:match_tournament_id])

        @finals = []

        @match_tournament.update(team_one_score: params[:match_tournament][:team_one_score], team_two_score: params[:match_tournament][:team_two_score])
        if @match_tournament.team_one_score.to_i > @match_tournament.team_two_score.to_i
            @match_tournament.update(winner: @match_tournament.team_one)
            @finals.push(@match_tournament.team_one)
        elsif @match_tournament.team_one_score.to_i < @match_tournament.team_two_score.to_i
            @match_tournament.update(winner: @match_tournament.team_two)
            @finals.push(@match_tournament.team_two)
        end 

        @tournament.update(finals: @tournament.finals + @finals)

        redirect_to match_tournaments_path(id: @tournament.id)
    end 

    def edit_finals
        @tournament = Tournament.find(params[:tournament_id])
        @match_tournament = @tournament.match_tournaments.find(params[:match_tournament_id])
    end 

    def update_finals
        @tournament = Tournament.find_by(id: params[:match_tournament][:tournament_id])
        @match_tournament = @tournament.match_tournaments.find(params[:match_tournament_id])

        @final_winner = ""

        @match_tournament.update(team_one_score: params[:match_tournament][:team_one_score], team_two_score: params[:match_tournament][:team_two_score])
        if @match_tournament.team_one_score.to_i > @match_tournament.team_two_score.to_i
            @match_tournament.update(winner: @match_tournament.team_one)
            @final_winner = @match_tournament.team_one
        elsif @match_tournament.team_one_score.to_i < @match_tournament.team_two_score.to_i
            @match_tournament.update(winner: @match_tournament.team_two)
            @final_winner = @match_tournament.team_two
        end 

        @tournament.update(final_winner: @final_winner)

        redirect_to match_tournaments_path(id: @tournament.id)
    end 

    private 
    def match_tournament_params 
        params.permit(:team_one, :team_two, :winner, :team_one_score, :team_two_score)
    end 
end