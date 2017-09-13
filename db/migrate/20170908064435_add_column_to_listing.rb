class AddColumnToListing < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :status_have, :string
    add_column :listings, :status_can_instruction, :string
    add_column :listings, :status_verygood, :string
    add_column :listings, :status_want, :string
    
  end
end
