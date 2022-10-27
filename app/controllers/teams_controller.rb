class TeamsController < ApplicationController

    def index 
        @teams = Team.all.order("team_score desc")
    end 

    def show 
        @team = Team.find(params[:id])
        @user = User.find(@team.coordinator_id)
    end 

    def new 
        @team = Team.new 
        @users_array = []
        @users = User.all
        @users.each do |user|
            if user.roles == 'coordinator'
                @users_array.push(user)
            end 
        end 
    end 

    def create 
        @team = Team.create(team_params)

        if @team.save
            redirect_to @team
        else 
            render :new
        end 
    end 

    def edit 
        @team = Team.find(params[:id])
        @users_array = []
        @users = User.all
        @users.each do |user|
            if user.roles == 'coordinator'
                @users_array.push(user)
            end 
        end 
    end 

    def update
        @team = Team.find(params[:id])

        if @team.update(team_params)
            redirect_to @team 
        else 
            render :edit 
        end 
    end 

    def update_score 
        @team = Team.find(params[:team_id])
        @match = Match.find(params[:match_id])
        score = @team.team_score 
        @team.update(team_score: score + 3 )
        redirect_to match_path(id: @match.id)
    end 

    def destroy 
        @team = Team.find(params[:id])
        @team.destroy 

        redirect_to teams_path 
    end 

    private 
    def team_params
        params.require(:team).permit(:coordinator_id, :name, :team_score)
    end 
end
