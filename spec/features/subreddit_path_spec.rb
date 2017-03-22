require "rails_helper"

describe "when user is on their dashboard" do
  it "and they click on a subreddit they are directed to that subreddit show" do
    user = User.create(name: 'iungere', provider: "reddit", uid: "a1z5y", token: "Y6U8WBVO6SnGuriG8Q0M5Bi_0ic", karma: 4, refresh_token: "16888390-nljBZBj2C1TdEK8PyT1-6PPGYtM")
    user.refresh_tokens

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path
    click_on('politics')
    # byebug
  end
end
