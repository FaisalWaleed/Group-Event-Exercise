class CreateGroupEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :group_events do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.timestamp :started_at
      t.timestamp :ended_at
      t.timestamp :deleted_at
      t.timestamps
    end
  end
end
