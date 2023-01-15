require 'rails_helper'

RSpec.describe 'Api::V1::Searches', type: :request do
  describe 'GET /index' do
    before(:example) do
      @analytic = Analytic.create(query: 'test query', frequency: 1)
      @user = User.create()
      @history = SearchHistorie.create(user_id:@user.id, query:'test query', frequency:1)
    end
    it 'returns a 200' do
      get '/api/v1/search', params: { q: 'a' ,user:@user}
      expect(response).to have_http_status(:ok)
    end

    it 'empty query should not search trie' do
      get '/api/v1/search', params: { q: '' }
      expect(response.body).to eql('[]')
    end

    it 'valid query string should search the trie and retun capitalize version and frequency count' do
      get '/api/v1/search', params: { q: 'test query', user: @user.id }
      expect(response.body).to eql("{\"global_history\":[[\"Test query\",1]],\"user_history\":[[\"Test query\",1]]}")
    end

    it 'new query ending in ? should be persisted to db and rebuild the trie' do
      get '/api/v1/search', params: { q: 'new test query?', user:@user.id }
      expect(response.body).to eql("{\"global_history\":[[\"New test query\",1]],\"user_history\":[[\"New test query\",1]]}")
    end
  end
end
