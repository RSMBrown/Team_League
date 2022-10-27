class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.belongs_to :team
      t.string :fname 
      t.string :sname
      t.string :gamer_tag 

      t.timestamps
    end
  end
end
