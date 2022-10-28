class CreateTournaments < ActiveRecord::Migration[6.1]
  def change
    create_table :tournaments do |t|
      t.string :title 
      t.date :date_start
      t.date :date_end
      t.string :semi_finals, array: true, default: [] 
      t.string :finals, array: true, defualt: []
      t.string :final_winner, default: ""

      t.timestamps
    end
  end
end
