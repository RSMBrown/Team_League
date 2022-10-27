class CreateMatchTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :match_teams do |t|
      t.belongs_to :match
      t.belongs_to :team

      t.timestamps
    end
  end
end
