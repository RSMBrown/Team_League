class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.string :name 
      t.integer :coordinator_id 
      t.integer :team_score

      t.timestamps
    end
  end
end
