class TrieDb < ActiveRecord::Base
  serialize :value
  validates :key, :value, presence: true
end
