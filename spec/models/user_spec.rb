require 'rails_helper'

RSpec.describe User, type: :model do
  context "methods" do
    it "should have subreddits" do
      user = User.create(name: 'iungere', provider: "reddit", uid: "a1z5y", token: "Y6U8WBVO6SnGuriG8Q0M5Bi_0ic", karma: 4, refresh_token: "16888390-nljBZBj2C1TdEK8PyT1-6PPGYtM")
      user.refresh_tokens

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      expect(user.subreddits.count).to eq(25)
    end

    it "should create itslef from the hash output from reddit_data" do
      data = {"link_karma" => 4, "name" => "iungere", "id" => "abc"}
      access_token = ["random_string", "another_random_string"]

      User.from_reddit(data, access_token)

      expect(User.first.karma).to eq(4)
      expect(User.first.name).to eq("iungere")
      expect(User.first.uid).to eq("abc")
      expect(User.first.token).to eq("random_string")
      expect(User.first.refresh_token).to eq("another_random_string")
      expect(User.count).to eq(1)
    end
  end
end
