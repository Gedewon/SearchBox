require 'rails_helper'

RSpec.describe Analytic, type: :model do
  before(:example) do
    @analytic = Analytic.create(query: 'test query1', frequency: 1)
  end

  it 'is valid Analytics if it\'s two coloumn data' do
    expect(@analytic).to be_valid
  end

  it 'should throw if we miss frequency coloumn' do
    @analytic.frequency = nil
    expect(@analytic).to_not be_valid
  end

  it 'should throw if we miss query coloumn' do
    @analytic.query = nil
    expect(@analytic).to_not be_valid
  end
end
