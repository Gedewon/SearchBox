class TrieDb < ActiveRecord::Base
    serialize :value
end