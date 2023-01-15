

## Design Decision 


- our improver  trie have three attributes 
    * is_word - determines if node is word.
    * frequency - determines how much the node is quired for.
    * child - is child node of that specific node in the trie.

```rb
class TrieNode
  attr_accessor :child, :is_word, :frequency

  def initialize
    @is_word = false
    @frequency = 0
    @child = {}
  end
end
```

## Frontend
- frontend makes AJAX request to get autocomplete suggestions for the client.This have benefit of sending/receiving a request/response with out
  refreshing the whole page.
- frontend handles ranking the data set and shows in specific order. ideally we will return at most 5-10 query so we can sort client side.
## Backend
- A search query and userId is sent to back end api route ```search?q=what&user=1```
- The search controller Index action get analytic data and construct Trie globalTrie if it's not in memory already.
- The search controller Index action get user specific data and construct user specif Trie and store it in memory if it's not there.
- When user send query to backend we search on globalTire and User specific Trie and return both of the result 
- The user specific result have priority/ranking that the global Trie data 
- If the data is not in the trie we store it on both history and analytic table and reconstruct the both of the Tries.



### Built With

- Ruby on Rails
- React with webpack
- Postgresql

### Setup

- Open your terminal and navigate to the folder you would like to save the project.type the following commands to your terminal 

```
git clone git@github.com:Gedewon/SearchBox.git
```

- Move into project directory

```
cd SearchBox
```

### Available Scripts

```
bundle install && rails db:create db:migrate db:seed 
```

### Then bootup your database by running the following command 

```
./bin/dev
```


### Testing

```
rspec spec
```

## Authors

👤 **Gedewon Haile**

- GitHub: [@gedewon](https://github.com/gedewon)
- Twitter: [@gedewon](https://twitter.com/gedi_haile)
- LinkedIn: [@gedewon](https://linkedin.com/in/gedewon)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](https://github.com/Gedewon/SearchBox/issues).

## Show your support

Give a ⭐️ if you like this project!

