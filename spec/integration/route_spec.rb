require 'spec_helper'

describe 'request to a protected resource' do
  subject { get '/protected' }

  context 'when not logged in' do
    it { should be_github_oauth_redirect }
  end

  context 'when logged in' do
    before { github_login }
    it { should be_ok }
  end

  context 'with multiple scopes' do
    subject { get '/admin/protected' }

    context 'when logged in in the wrong scope' do
      before { github_login }
      it { should be_github_oauth_redirect }
    end

    context 'when logged in in the correct scope' do
      before { github_login(:admin) }
      it { should be_ok }
    end
  end
end

describe 'request to a resource that only exists when logged in' do
  subject { get '/conditional' }

  context 'when not logged in' do
    it { should be_not_found }
  end

  context 'when logged in' do
    before { github_login }
    it { should be_ok }
  end

  context 'with mutliple scopes' do
    subject { get '/admin/conditional' }

    context 'when logged in in the wrong scope' do
      before { github_login }
      it { should be_not_found }
    end

    context 'when logged in in the correct scope' do
      before { github_login(:admin) }
      it { should be_ok }
    end
  end
end

describe 'request to a resource that only exists when logged out' do
  subject { get '/conditional_inverse' }

  context 'when not logged in' do
    it { should be_ok }
  end

  context 'when logged in' do
    before { github_login }
    it { should be_not_found }
  end

  context 'with mutliple scopes' do
    subject { get '/admin/conditional_inverse' }

    context 'when logged in in the wrong scope' do
      before { github_login }
      it { should be_ok }
    end

    context 'when logged in in the correct scope' do
      before { github_login(:admin) }
      it { should be_not_found }
    end
  end
end
