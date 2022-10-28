class TournamentsController < ApplicationController
    def index 
        @tournaments = Tournament.all 
    end 

    def show 
        @tournament = Tournament.find(params[:id])
        @teams = Team.all.order("team_score desc")

        @all_teams = []
        @teams.each do |team|
            @all_teams.push(team.name)
        end 
    end 

    def new 
        @tournament = Tournament.new
    end 

    def create 
        @tournament = Tournament.create(tournament_params)

        if @tournament.save 
            redirect_to @tournament
        else 
            render :new 
        end 
    end 

    private 
    def tournament_params 
        params.require(:tournament).permit(:title, :date_start, :date_end, :semi_finals, :finals, team_ids: [])
    end 
end
