require 'spec_helper'

describe Warden::GitHub::Rails::TestHelpers do
  describe '#github_login' do
    context 'when no scope is specified' do
      it 'uses the default scope from config to login' do
        Warden::GitHub::Rails.stub(:default_scope => :foobar)
        should_receive(:login_as).with do |_, opts|
          opts.fetch(:scope).should be :foobar
        end

        github_login
      end
    end

    context 'when a scope is specified' do
      it 'uses that scope to login' do
        should_receive(:login_as).with do |_, opts|
          opts.fetch(:scope).should be :admin
        end

        github_login(:admin)
      end
    end

    it 'logs in a mock user' do
      expected_user = nil

      should_receive(:login_as).with do |user, _|
        expected_user = user
        user.should be_a Warden::GitHub::Rails::TestHelpers::MockUser
      end

      user = github_login

      user.should be expected_user
    end
  end
end
