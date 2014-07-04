require 'rails_helper'

RSpec.describe UserParser, :type => :model do

  before do
    @html = '
      <html>
        <body>
          <div class="geral_padd">
            <ul class="list_palpite_partida">
              <li class="palpite_item">
                  <span style="width: 50px;" class="float_l">1</span>
                  <div style="width: 370px;" class="float_l">
                    <td class="tbl_bolao_td">
                      <a class="ranking_mob_img">
                        <img src="http://vippredictorstorage.blob.core.windows.net/vippredictor-user/min-noimage.jpg" class="tbl_bolao_avatar">
                      </a>
                    </td>
                    <td class="tbl_bolao_td">
                        <a>Saulo</a>
                    </td>
                  </div>
                  <div style="width: 180px;" class="float_l">06/12/2014 10:35:06 </div>

                  <div style="width: 150px; font-size: 18px; font-weight: bold; text-align: center;" class="float_l">
                      <strong>2 x 1</strong>
                  </div>

                  <div style="width: 60px; text-align: center;" class="float_l">120 </div>
                  <div style="width: 60px; text-align: center;" class="float_l">6846 </div>
                <div style="width: 60px; text-align: center;" class="float_l">
                  <a href="/en-US/Prediction/Look/34531?uId=348210">
                    <img src="http://vippredictorstorage.blob.core.windows.net/content-theme-20140619/ico_palpites_bt.png" title="Predictions">
                  </a>
                </div>
                <div class="limpa"></div>
              </li>
              <li class="palpite_item">
                  <span style="width: 50px;" class="float_l">1</span>
                  <div style="width: 370px;" class="float_l">
                    <td class="tbl_bolao_td">
                      <a class="ranking_mob_img">
                        <img src="http://vippredictorstorage.blob.core.windows.net/vippredictor-user/min-noimage.jpg" class="tbl_bolao_avatar">
                      </a>
                    </td>
                    <td class="tbl_bolao_td">
                        <a>Kamilla</a>
                    </td>
                  </div>
                  <div style="width: 180px;" class="float_l">06/12/2014 10:35:06 </div>

                  <div style="width: 150px; font-size: 18px; font-weight: bold; text-align: center;" class="float_l">
                      <strong>2 x 1</strong>
                  </div>

                  <div style="width: 60px; text-align: center;" class="float_l">120 </div>
                  <div style="width: 60px; text-align: center;" class="float_l">6846 </div>
                <div style="width: 60px; text-align: center;" class="float_l">
                  <a href="/en-US/Prediction/Look/34531?uId=348210">
                    <img src="http://vippredictorstorage.blob.core.windows.net/content-theme-20140619/ico_palpites_bt.png" title="Predictions">
                  </a>
                </div>
                <div class="limpa"></div>
              </li>
            </ul>
          </div>
        </body>
      </html>
    '
    crawler = double("VippredictorCrawler")
    allow(crawler).to receive(:get_users_html_page).and_return(@html)

    @parser = UserParser.new(crawler)
  end


  it "should find an Array of Hash" do
    hash = @parser.get_users_hash
    expect(hash).to be_a_kind_of(Array)
    expect(hash[0]).to be_a_kind_of(Hash)
  end

  it "should extract all the lines of users" do
    hash = @parser.get_users_hash
    expect(hash.size).to be_eql 2
  end

  it "should extract the name" do
    hash = @parser.get_users_hash

    expect(hash[0][:name]).to be_eql "Saulo"
  end

  it "should extract the image" do
    hash = @parser.get_users_hash

    expect(hash[0][:image]).to be_eql "http://vippredictorstorage.blob.core.windows.net/vippredictor-user/min-noimage.jpg"
  end

  it "should extract the vip_predictor_id" do
    hash = @parser.get_users_hash

    expect(hash[0][:vippredictor_id]).to be_eql "348210"
  end




  it "should generate a hash with user structury" do
    hash = @parser.get_users_hash

    expect(hash[0]).to have_key :name
    expect(hash[0]).to have_key :vippredictor_id
    expect(hash[0]).to have_key :image
  end

end
