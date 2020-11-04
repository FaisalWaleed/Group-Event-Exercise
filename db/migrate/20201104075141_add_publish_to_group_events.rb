class AddPublishToGroupEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :group_events, :publish, :boolean
  end
end
