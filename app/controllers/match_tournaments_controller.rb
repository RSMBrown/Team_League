class MatchTournamentsController < ApplicationController

    def index 
        @tournament = Tournament.find(params[:id])

        @all_teams = MatchTournamentService.all_teams(@tournament)
        @semi_finals = MatchTournamentService.semi_finals(@tournament)
        @finals = MatchTournamentService.finals(@tournament)

        MatchTournamentService.winner(@tournament)
    end 

    def create 
        @tournament = Tournament.find(params[:id])
        MatchTournamentService.create_all(@tournament)

        redirect_to match_tournaments_path(id: @tournament.id)
    end 

    def create_semi_finals
        @tournament = Tournament.find(params[:id])
        MatchTournamentService.create_semi_finals(@tournament)

        redirect_to match_tournaments_path(id: @tournament.id)
    end 

    def create_finals
        @tournament = Tournament.find(params[:id])
        MatchTournamentService.create_finals(@tournament)

        redirect_to match_tournaments_path(id: @tournament.id)
    end 

    def edit 
        @tournament = Tournament.find(params[:tournament_id])
        @match_tournament = @tournament.match_tournaments.find(params[:id])
    end 

    def update 
        @tournament = Tournament.find_by(id: params[:match_tournament][:tournament_id])
        @match_tournament = @tournament.match_tournaments.find(params[:id])


        @match_tournament.update(team_one_score: params[:match_tournament][:team_one_score], team_two_score: params[:match_tournament][:team_two_score])

        if @match_tournament.team_one_score.to_i > @match_tournament.team_two_score.to_i
            @match_tournament.update(winner: @match_tournament.team_one)
        elsif @match_tournament.team_one_score.to_i < @match_tournament.team_two_score.to_i
            @match_tournament.update(winner: @match_tournament.team_two)
        end 

        redirect_to match_tournaments_path(id: @tournament.id)
    end 

    private 
    def match_tournament_params 
        params.permit(:team_one, :team_two, :winner, :team_one_score, :team_two_score)
    end 
end