class AddRateToTalk < ActiveRecord::Migration[5.1]
  def change
    add_column :talks, :rate, :integer, default: 100
  end
end
