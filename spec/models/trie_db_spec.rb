require 'rails_helper'

RSpec.describe TrieDb, type: :model do
  before(:example) do
    @triedb = TrieDb.create(key: 'b', value: ['be' => 15, 'bee' => 20, 'beer' => 10])
  end

  it 'is valid Analytics if it\'s two coloumn data' do
    expect(@triedb).to be_valid
  end

  it 'should throw if we miss value coloumn' do
    @triedb.value = nil
    expect(@triedb).to_not be_valid
  end

  it 'should throw if we miss key coloumn' do
    @triedb.key = nil
    expect(@triedb).to_not be_valid
  end
end
