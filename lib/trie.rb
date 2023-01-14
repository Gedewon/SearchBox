
class Trie
    attr_accessor :root
    
    def initialize
        @root = TrieNode.new;
    end

    def insert(word,frequency=1)
        current_node = @root
        word.chars.each do |char| 
          current_node.child[char] = TrieNode.new unless  current_node.child.key?(char) 
          current_node = current_node.child[char]
        end
        current_node.is_word = true
        current_node.frequency = frequency
    end


    def search(word)
        current_node =@root
      
        word.chars.each do |char| 
            return false unless current_node.child.key?(char) 
            current_node = current_node.child[char] if current_node 
        end

        current_node.is_word 
    end

    # DFS to find the word list 
    def find_words_starting_with(prefix)
       prefix.delete!('?') 
       @completions = []
       @node = @root

       prefix.chars.each do |element| 
        @node = @node.child[element] if @node
       end
       
       traverse(@node, prefix, @completions) if @node
       @completions
    end

    private
    def traverse(node,prefix,completions)
        completions.push([prefix,node.frequency]) if node.is_word

        node.child.keys.each do |char| 
            next_node = node.child[char]
            traverse(next_node, prefix+char, completions)
        end
    end

end