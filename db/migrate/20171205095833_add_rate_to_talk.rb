class AddRateToTalk < ActiveRecord::Migration[5.1]
  def change
    add_column :talks, :rate, :integer
  end
end
