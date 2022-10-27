class CreateMatches < ActiveRecord::Migration[6.1]
  def change
    create_table :matches do |t|
      t.integer :team_one_id 
      t.integer :team_two_id 
      t.date :match_date
      t.integer :team_one_score
      t.integer :team_two_score

      t.timestamps
    end
  end
end
