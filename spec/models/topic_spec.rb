require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:public) { true }
  let(:topic) { create(:topic) }

  it { should have_many(:posts) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }

  it { should validate_length_of(:name).is_at_least(5) }
  it { should validate_length_of(:description).is_at_least(15) }

  describe "attributes" do
    it "has name, description, and public attributes" do
      expect(topic).to have_attributes(name: topic.name, description: topic.description, public: public)
    end

    it "is public by default" do
      expect(topic.public).to be(true)
    end
  end
end
