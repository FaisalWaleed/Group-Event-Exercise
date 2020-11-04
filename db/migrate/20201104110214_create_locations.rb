class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.string :state
      t.string :street
      t.string :city
      t.string :zipcode
      t.references :group_event, null: false, foreign_key: true
      t.timestamps
    end
  end
end
