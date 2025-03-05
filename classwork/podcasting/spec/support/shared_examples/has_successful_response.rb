RSpec.shared_examples 'has successful status' do
  it do
    make_request
    expect(response).to be_successful
  end
end

