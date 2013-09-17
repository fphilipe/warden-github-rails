require 'spec_helper'

# Test if the configs in rails_app/config/initializers/warden_github_rails.rb
# are actually being set and used by warden.
describe 'request to custom configured scope' do
  def test_redirect(url, args)
    request = get url
    params = Addressable::URI.parse(request.location).query_values

    expect(request).to be_github_oauth_redirect
    expect(params.fetch('client_id')).to eq(args.fetch(:client_id))
    expect(params.fetch('redirect_uri')).to match(args.fetch(:redirect_uri))
    expect(params.fetch('scope')).to eq(args.fetch(:scope))
  end

  context 'user' do
    it 'passes the correct configs to the oauth flow' do
      test_redirect('/protected',
                    client_id: 'foo',
                    redirect_uri: /\/protected$/,
                    scope: 'user')
    end
  end

  context 'admin' do
    it 'passes the correct configs to the oauth flow' do
      test_redirect('/admin/protected',
                    client_id: 'abc',
                    redirect_uri: /\/admin\/login\/callback$/,
                    scope: 'repo')
    end
  end
end
