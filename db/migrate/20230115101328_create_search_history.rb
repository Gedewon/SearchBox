class CreateSearchHistory < ActiveRecord::Migration[7.0]
  def change
    create_table :search_histories do |t|
      t.string :query
      t.integer :frequency
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :search_histories, :query
  end
end
