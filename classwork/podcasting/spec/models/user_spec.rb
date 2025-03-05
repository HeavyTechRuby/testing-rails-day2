require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Factory" do
    it "generates uniq email each time" do
      expect(FactoryBot.build(:user).email).not_to eq(FactoryBot.build(:user).email)
    end
  end
end
