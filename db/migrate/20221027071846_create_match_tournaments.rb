class CreateMatchTournaments < ActiveRecord::Migration[6.1]
  def change
    create_table :match_tournaments do |t|
      t.belongs_to :tournament
      t.string :team_one, default: ""
      t.string :team_two, default: ""
      t.string :team_one_score, default: 0 
      t.string :team_two_score, default: 0 
      t.string :winner, default: ""

      t.timestamps
    end
  end
end
