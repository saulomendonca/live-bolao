require 'rails_helper'

RSpec.describe GamePontuationTranslate, :type => :service do

  before do
    @translator = GamePontuationTranslate
  end

  it "should return the pontuation when receive a date" do
    expect(@translator.get_pontuation_by_date Date.parse("13/07/2014")).to be_eql 34
  end

  it "should return zero when date have no game" do
    expect(@translator.get_pontuation_by_date Date.parse("15/07/2014")).to be_eql 0
  end

end
