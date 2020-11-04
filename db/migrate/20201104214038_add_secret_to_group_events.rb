class AddSecretToGroupEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :group_events, :secret, :string
  end
end
