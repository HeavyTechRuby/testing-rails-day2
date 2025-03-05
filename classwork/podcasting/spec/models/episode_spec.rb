require 'rails_helper'

RSpec.describe Episode do
  subject(:episode) { FactoryBot.build(:episode) }
  describe 'validations' do
    context 'when valid attributes' do
      it 'should be valid' do
        expect(episode.valid?).to eq(true)
        expect(episode).to be_valid
      end
    end

    describe 'on title' do
      it 'should be invalid when no title'
      it 'should be invalid with empty title'
      it 'should be invalid title has no text'
    end

    describe 'on podcast' do
      it 'should be invalid when no podcast'
      it 'should be invalid when podcast is archived'
    end
  end

  describe '.popluar scope' do
    it 'should not include episode'

    context 'when user liked' do
      it 'should include episode'

      context 'when user removed his like' do
        it 'should not include episode'
      end
    end
  end

  describe 'comments' do
    it 'should be empty when no comments'
    it 'should be possible to add comment'
    it 'should be possible to remove comment'

    context 'when episode archived' do
      it 'should be possible to add comment'
    end
  end

  describe 'stats' do
    context 'when user played episode' do
      it 'should increase plays_count'
    end

    context 'when user paused episode' do
      it 'should not change plays_count'
      it 'should save position'
    end
  end
end
