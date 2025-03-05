RSpec.shared_context 'authenticated user' do
  before { sign_in current_user }
  let(:current_user) { FactoryBot.create :user }
end
