class CreateAnalytics < ActiveRecord::Migration[7.0]
  def change
    create_table :analytics do |t|
      t.string :query
      t.integer :frequency

      t.timestamps
    end
    add_index :analytics, :query
  end
end
