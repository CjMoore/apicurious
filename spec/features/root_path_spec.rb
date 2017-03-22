require "rails_helper"

describe "when user visits root path" do
  it "they see the root path stuff" do

    visit root_path

    expect(page).to have_content("Are you curious?")
    expect(page).to have_link("I am curious")
  end
end
