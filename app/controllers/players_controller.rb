class PlayersController < ApplicationController

    def show 
        @player = Player.find(params[:id])
    end 

    def new 
        @player = Player.new 
        @team = Team.find(params[:team_id])
    end 

    def create 
        @team = Team.find(player_params[:team_id])
        @player = @team.players.create(player_params)
        if @player.save 
            redirect_to @player 
        else 
            render :new 
        end 
    end 

    def edit 
        @player = Player.find(params[:id])
    end 

    def update
        @player = Player.find(params[:id])

        if @player.update(team_params)
            redirect_to @player 
        else 
            render :edit 
        end 
    end 

    def destory 
        @player = Player.find(params[:id])
        @player.destroy 

        redirect_to teams_path 
    end 

    private 
    def player_params
        params.require(:player).permit(:fname, :sname, :gamer_tag, :team_id)
    end 
end
