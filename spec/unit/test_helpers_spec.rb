require 'spec_helper'

describe Warden::GitHub::Rails::TestHelpers do
  describe '#github_login' do
    context 'when no scope is specified' do
      it 'uses the default scope from config to login' do
        Warden::GitHub::Rails.stub(default_scope: :foobar)
        should_receive(:login_as).with do |_, opts|
          expect(opts.fetch(:scope)).to eq(:foobar)
        end

        github_login
      end
    end

    context 'when a scope is specified' do
      it 'uses that scope to login' do
        should_receive(:login_as).with do |_, opts|
          expect(opts.fetch(:scope)).to eq(:admin)
        end

        github_login(:admin)
      end
    end

    it 'logs in a mock user' do
      expected_user = nil

      should_receive(:login_as).with do |user, _|
        expected_user = user
        expect(user).to be_a(Warden::GitHub::Rails::TestHelpers::MockUser)
      end

      user = github_login

      expect(user).to eq(expected_user)
    end
  end
end
