require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/api/v1/user'
      expect(response).to have_http_status(:success)
    end
    it 'return new user per call' do
      get '/api/v1/user'
      expect(response.body).to eql(User.last.id.to_s)
    end
  end
end
