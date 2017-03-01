class CreateItineraries < ActiveRecord::Migration[5.0]
  def change
    create_table :itineraries do |t|
      t.belongs_to :user,     null: false
      t.string :name,         null: false, default: ""
      t.datetime :start_date, null: false
      t.datetime :end_date,   null: false

      t.timestamps null: false
    end

    add_index :itineraries, :name, unique: true
  end
end
