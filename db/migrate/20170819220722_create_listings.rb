class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
      t.string :game_title
      t.string :valuation
      t.string :status
      t.string :classification
      t.text :game_content
      t.string :image
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
