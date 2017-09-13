class AddColumn2ToListing < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :game_player, :integer
    add_column :listings, :game_time, :integer
    add_column :listings, :game_counting, :integer
  end
end
