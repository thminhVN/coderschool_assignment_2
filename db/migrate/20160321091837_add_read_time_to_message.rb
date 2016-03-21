class AddReadTimeToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :read_at, :timestamp
  end
end
