class CreateTrieDb < ActiveRecord::Migration[7.0]
  def change
    create_table :trie_dbs do |t|
      t.string :key
      t.text :value

      t.timestamps
    end
    add_index :trie_dbs, :key
  end
end
