require 'rails_helper'


#Feature: Ranking
#In order to display the ranking
#User wants access the page and view the ranking updated by game's results

describe "The ranking view", :type => :feature do
  before :each do
    Team.destroy_all
    User.destroy_all

    @user = create(:user, name: "Juarez", vippredictor_id: 34562)

    create(:score, user: @user, points: 3500)
    Result.destroy_all
    GameScore.destroy_all
    Game.destroy_all
    @home_team = create(:team)
    away_team = create(:team, code_fifa: "COS", code_vippredictor: "COS", name: "Costa Rica")
    @game = create(:game, status: "in progress", weight: 10, away_team: @home_team, home_team: away_team)
    create(:result, game: @game, away_team_goal: 1, home_team_goal: 2)

    User.all.each do |user|
      create(:prediction, user: user, game: @game, away_team_goal: 0, home_team_goal: 0)
    end
    Prediction.where(user_id: @user.id).first.update_attributes(away_team_goal: 5, home_team_goal: 9)

    GameScoreService.new().calculate_daily_score

  end

  it "Should show the live result" do
    visit '/live'
    expect(page).to have_content @home_team.name
    expect(page).to have_content "2 X 1"
    expect(page).to have_content "Jogos Ao Vivo"
  end

  it "Should not show the live result when game over" do
    @game.update_attributes(:status => "completed")
    visit '/live'
    expect(page).not_to have_content @home_team.name
    expect(page).not_to have_content "2 X 1"
    expect(page).not_to have_content "Jogos Ao Vivo"
  end

  it "Should show the ranking" do
    visit '/live'
    expect(page).to have_content "Ranking"
    expect(page).to have_content @user.name
    expect(page).to have_content @user.score.points
    game_points = 100
    expect(page).to have_content (@user.score.points + game_points)
  end

  it "Should show the user's prediction" do
    visit '/live'
    expect(page).to have_content @user.name
    expect(page).to have_content "9x5"
  end


end
