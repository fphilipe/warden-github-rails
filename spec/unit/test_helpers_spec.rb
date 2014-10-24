require 'spec_helper'

describe Warden::GitHub::Rails::TestHelpers do
  describe '#github_login' do
    before { allow(self).to receive(:login_as) }

    context 'when no scope is specified' do
      it 'uses the default scope from config to login' do
        allow(Warden::GitHub::Rails).to receive(:default_scope) { :foobar }

        github_login

        expect(self).to have_received(:login_as).with(
          an_instance_of(Warden::GitHub::Rails::TestHelpers::MockUser),
          match(scope: :foobar)
        )
      end
    end

    context 'when a scope is specified' do
      it 'uses that scope to login' do
        github_login(:admin)

        expect(self).to have_received(:login_as).with(
          an_instance_of(Warden::GitHub::Rails::TestHelpers::MockUser),
          match(scope: :admin)
        )
      end
    end
  end
end
