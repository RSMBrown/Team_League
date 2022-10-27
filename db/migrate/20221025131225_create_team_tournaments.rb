class CreateTeamTournaments < ActiveRecord::Migration[6.1]
  def change
    create_table :team_tournaments do |t|
      t.belongs_to :team
      t.belongs_to :tournament 
      
      t.timestamps
    end
  end
end
