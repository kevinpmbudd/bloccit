require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:user_with_invalid_name) { build(:user, name: "") }
  let(:user_with_invalid_email) { build(:user, email: "") }
  let(:user_with_caps_name) { User.create!(name: "BLOCCIT USER", email: "user1@bloccit.com", password: "password") }
  let(:user_with_lowercase_name) { User.create!(name: "bloccit user", email: "user2@bloccit.com", password: "password") }

  it { should have_many(:posts) }
  it { should have_many(:comments) }
  it { should have_many(:votes) }
  it { should have_many(:favorites) }

  # shoulda tests for name
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(1) }

  # shoulda tests for email
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_length_of(:email).is_at_least(3) }
  it { should allow_value("user@bloccit.com").for(:email) }

  # shoulda tests for password
  it { should validate_presence_of(:password) }
  it { should have_secure_password }
  it { should validate_length_of(:password).is_at_least(6) }

  describe "attributes" do
    it "should have name and email attributes" do
      expect(user).to have_attributes(name: user.name, email: user.email)
    end

    it "responds to role" do
      expect(user).to respond_to(:role)
    end

    it "responds to admin?" do
      expect(user).to respond_to(:admin?)
    end

    it "responds to member?" do
      expect(user).to respond_to(:member?)
    end
  end

  describe "roles" do
    it "is member by default" do
      expect(user.role).to eql("member")
    end

    context "member user" do
      it "returns true for #member?" do
        expect(user.member?).to be_truthy
      end

      it "returns false for #admin?" do
        expect(user.admin?).to be_falsey
      end
    end

    context "admin user" do
      before do
        user.admin!
      end

      it "returns true for #admin?" do
        expect(user.admin?).to be_truthy
      end

      it "returns false for #member?" do
        expect(user.member?).to be_falsey
      end
    end
  end

  describe "invalid user" do
    it "should be an invalid user due to blank name" do
      expect(user_with_invalid_name).to_not be_valid
    end

    it "should be an invalid user due to blank email" do
      expect(user_with_invalid_email).to_not be_valid
    end
  end

  describe "#normalize_name" do
    it "should capitalize first and last names" do
      expect(user_with_caps_name).to have_attributes(name: "Bloccit User")
      expect(user_with_lowercase_name).to have_attributes(name: "Bloccit User")
    end
  end

  describe "#favorite_for(post)" do
    before do
      topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)
      @post = topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user)
    end

    it "returns 'nil' if the user has not favorited the post" do
      expect(user.favorite_for(@post)).to be_nil
    end

    it "returns the appropriate favorite if it exists" do
      favorite = user.favorites.where(post: @post).create
      expect(user.favorite_for(@post)).to eq(favorite)
    end
  end

  describe ".avatar_url" do
    let(:known_user) { create(:user, email: "blochead@bloc.io") }

    it "returns the proper Gravatar url for a known email entity" do
      expected_gravatar = "http://gravatar.com/avatar/bb6d1172212c180cfbdb7039129d7b03.png?s=48"
      expect(known_user.avatar_url(48)).to eq(expected_gravatar)
    end
  end
end
