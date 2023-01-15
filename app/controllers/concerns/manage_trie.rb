module ManageTrie
  extend ActiveSupport::Concern
  require 'trie'

  # get analytic data from DB and build the trie for fast
  # search on the query and get an auto-completion list
  def build
    @trie = Trie.new
    @analytics = Analytic.all

    @analytics.each do |analytic|
      @trie.insert(analytic.query.capitalize, analytic.frequency)
    end
  end

  # insert a new query or update the existing query frequency
  # and rebuild the trie in memory
  def insert_or_update(query, user_id)
    return unless query.include?('?')

    clean_string = query[0...-1]

    if @trie.search(clean_string.capitalize)
      analytic = Analytic.find_by(query: clean_string.capitalize)
      analytic.frequency = analytic.frequency + 1
      analytic.save
    else
      Analytic.create(query: clean_string.capitalize, frequency: 1)
    end

    if @user_trie.search(clean_string.capitalize)
      user_history = SearchHistorie.find_by(user_id:, query: clean_string.capitalize)
      user_history.frequency = user_history.frequency + 1
      user_history.save
    else
      SearchHistorie.create(user_id:, query: clean_string.capitalize, frequency: 1)
    end

    build
    build_user_specfic_trie(user_id)
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
