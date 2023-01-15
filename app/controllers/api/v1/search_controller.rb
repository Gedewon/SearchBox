class Api::V1::SearchController < ApplicationController
  require 'trie'


  # build trie if it's not in memory already
  # when we finish the search query we can update the frequency of the query or register a new query
  # get a list of auto-completion while typing in real time
  def index
   build unless @trie

   insert_or_update(params[:q]) if params[:q].include?('?')

   @list = @trie.find_words_starting_with(params[:q].capitalize)
   
   return render json:[] if params[:q].eql?('')
   render json: @list
  end


  # get analytic data from DB and build the trie for fast 
  # search on the query and get an auto-completion list
  private 
  def build 
    @trie = Trie.new();
    @analytics = Analytic.all

     @analytics.each do |analytic| 
      @trie.insert(analytic.query.capitalize, analytic.frequency);
    end
  end

  # insert a new query or update the existing query frequency
  # and rebuild the trie in memory
  def insert_or_update(query)
      return unless query.include?('?')

      clean_string = query[0...-1]
     
      if @trie.search(clean_string.capitalize)
        analytic = Analytic.find_by(query:clean_string.capitalize)
        analytic.frequency= analytic.frequency+1
        analytic.save
      else
        Analytic.create(query:clean_string.capitalize, frequency:1)
      end

      build
  end
end
