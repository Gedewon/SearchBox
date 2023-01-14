class TrieNode
    attr_accessor :child, :is_word, :frequency

    def initialize
        @is_word = false
        @frequency = 0
        @child = {} 
    end

end