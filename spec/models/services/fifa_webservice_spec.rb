require 'rails_helper'

RSpec.describe FifaWebservice, :type => :service do

  before do
    @webservice = FifaWebservice.new()
  end


  it "should find an Array of Hash" do
    hash = @webservice.get_hash_teams
    expect(hash).to be_a_kind_of(Array)
    expect(hash[0]).to be_a_kind_of(Hash)
  end

  it "should get all teams" do
    hash = @webservice.get_hash_teams
    expect(hash.size).to be_eql 32
  end

  it "should generate a hash with code and name" do
    hash = @webservice.get_hash_teams

    expect(hash[0]).to have_key :code
    expect(hash[0]).to have_key :name
  end

end
