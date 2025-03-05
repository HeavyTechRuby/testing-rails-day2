require "rails_helper"

RSpec.describe Podcast do
  describe 'validations' do
    context 'when valid attributes' do
      it 'should be valid' do
        podcast = FactoryBot.build(:podcast)
        expect(podcast).to be_valid
      end
    end

    describe 'on title' do
      it 'should be invalid when no title' do
        podcast = FactoryBot.build(:podcast, title: nil)
        expect(podcast).not_to be_valid
      end

      it 'should be invalid with empty title' do
        podcast = FactoryBot.build(:podcast, title: "")
        expect(podcast).not_to be_valid
      end

      it 'should be invalid title has no text' do
        podcast = FactoryBot.build(:podcast, title: "123")
        expect(podcast).not_to be_valid
      end
    end

    describe 'on author' do
      it 'should be invalid when no author' do
        podcast = FactoryBot.build(:podcast, author: nil)
        expect(podcast).not_to be_valid
      end

      it 'should be invalid when user is blocked' do
        blocked_user = FactoryBot.build(:user, :blocked)
        expect(blocked_user).to be_blocked
        podcast = FactoryBot.build(:podcast, author: blocked_user)
        expect(podcast).not_to be_valid

        expect(podcast.errors.messages[:author]).to include(/blocked/)
      end
    end
  end

  describe 'subscriptions' do
    subject { podcast.subscriptions.map(&:user) }

    let(:podcast) { FactoryBot.build :podcast }
    let(:user) { FactoryBot.build :user }

    it { is_expected.to be_empty }

    context 'when user subscribed' do
      before { podcast.subscribe user }

      it 'should include user' do
        is_expected.to include(user)
      end

      context 'and then unsubscribed' do
        before { podcast.unsubscribe user }

        it 'should not include user' do
          is_expected.not_to include(user)
        end
      end
    end

    context 'when user NOT subscribed' do
      it 'should not include user' do
        is_expected.not_to include(user)
      end
    end
  end

  describe "Factory" do
    xit "works with custom params" do
      FactoryBot.build :podcast, with_n_subscribers: 3
    end
  end

  describe 'episodes' do
    it 'should be possible to publish episode'
    it 'should be possible to add draft episode'
    it 'should be possible to unpublish episode'
    it 'should be possible to delete episode'

    describe '#episodes.published' do
      context 'when no episodes' do
        it "is expected to be empty"
      end

      context 'when has published episode' do
        it "is expected to include episode"
      end
    end
  end

  describe 'author account creation' do
    it "expect author account to be empty"

    context 'when no user account' do
      it 'should add account to user after podcast created'
    end

    context 'when user account exists' do
      it 'should NOT add account to user after podcast created'
    end
  end
end
