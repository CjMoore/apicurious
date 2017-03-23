require "rails_helper"

describe "when user is on their dashboard" do
  it "and they click on a subreddit they are directed to that subreddit show" do
    user = User.create(name: 'iungere', provider: "reddit", uid: "a1z5y", karma: 4, refresh_token: ENV['refresh_token'])
    user.refresh_tokens

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    click_on('politics')

    expect(current_path).to eq(subreddit_path)
    expect(page).to have_content("politics")
  end
end
