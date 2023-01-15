class Api::V1::SearchController < ApplicationController
  include ManageTrie
  require 'trie'
  # build trie if it's not in memory already
  # when we finish the search query we can update the frequency of the query or register a new query
  # get a list of auto-completion while typing in real time
  def index
    p params
    return render json: [] if params[:q].eql?('')

    build unless @trie
    build_user_specfic_trie(params[:user]) unless @user_trie

    insert_or_update(params[:q], params[:user]) if params[:q].include?('?')

    @list = @trie.find_words_starting_with(params[:q].capitalize)
    @history_list = @user_trie.find_words_starting_with(params[:q].capitalize)
    render json: { global_history: @list, user_history: @history_list }
  end

  def build_user_specfic_trie(user_id)
    return unless user_id

    @user_trie = Trie.new
    @history = SearchHistorie.where(user_id:)
    return unless @history

    @history.each do |history|
      @user_trie.insert(history.query.capitalize, history.frequency)
    end
  end
end
