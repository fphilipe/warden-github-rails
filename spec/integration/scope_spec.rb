require 'spec_helper'

# Test if the configs in rails_app/config/initializers/warden_github_rails.rb
# are actually being set and used by warden.
describe 'request to custom configured scope' do
  def test_redirect(url, args)
    request = get url
    params = Addressable::URI.parse(request.location).query_values

    request.should be_github_oauth_redirect
    params.fetch('client_id').should eq args.fetch(:client_id)
    params.fetch('redirect_uri').should =~ args.fetch(:redirect_uri)
    params.fetch('scope').should eq args.fetch(:scope)
  end

  context 'user' do
    it 'passes the correct configs to the oauth flow' do
      test_redirect('/protected',
                    :client_id => 'foo',
                    :redirect_uri => /\/protected$/,
                    :scope => 'user')
    end
  end

  context 'admin' do
    it 'passes the correct configs to the oauth flow' do
      test_redirect('/admin/protected',
                    :client_id => 'abc',
                    :redirect_uri => /\/admin\/login\/callback$/,
                    :scope => 'repo')
    end
  end
end
