class MatchesController < ApplicationController
    def index 
        @matches = Match.all
    end 

    def show 
        @match = Match.find(params[:id])
        @team_one = Team.find(@match.team_one_id)
        @team_two = Team.find(@match.team_two_id)
        @team_one_score = @match.team_one_score
        @team_two_score = @match.team_two_score
        if @team_one_score > @team_two_score
            @winner = @team_one.name 
        elsif @team_two_score > @team_one_score
            @winner = @team_two.name
        else  
            @winner = "No score...yet"
        end 
    end 

    def new 
        @match = Match.new 
    end

    def create 
        @match = Match.create(matches_params)

        if @match.save 
            redirect_to @match
        else 
            render :new 
        end 
    end 

    def edit 
        @match = Match.find(params[:id])
    end 

    def update 
        @match = Match.find(params[:id])

        @team_one = Team.find(@match.team_one_id)
        @team_two = Team.find(@match.team_two_id)

        @team_one_score = @match.team_one_score
        @team_two_score = @match.team_two_score

        @match.update(matches_params)

        if @team_one_score > @team_two_score
            redirect_to team_update_score_path(team_id: @match.team_one_id, match_id: @match.id)
        elsif @team_two_score > @team_one_score
            redirect_to team_update_score_path(team_id: @match.team_two_id, match_id: @match.id)
        end 
    end

    private 
    def matches_params 
        params.require(:match).permit(:team_one_id, :team_two_id, :match_date, :team_one_score, :team_two_score)
    end 
end