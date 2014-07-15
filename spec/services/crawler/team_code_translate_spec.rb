require 'rails_helper'

RSpec.describe TeamCodeTranslate, :type => :service do

  before do
    @translator = TeamCodeTranslate
  end

  it "should return a Fifa code when the Vippredictor is diferent from Fifa code" do
    expect(@translator.get_fifa_code "COS").to be_eql "CRC"
  end

  it "should return the same code when the Vippredictor is equal from Fifa code" do
    expect(@translator.get_fifa_code "BRA").to be_eql "BRA"
  end

end
