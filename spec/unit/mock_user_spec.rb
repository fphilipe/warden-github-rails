require 'spec_helper'

describe Warden::GitHub::Rails::TestHelpers::MockUser do
  it { should be_a Warden::GitHub::User }

  describe '#stub_membership' do
    subject(:user) { described_class.new }

    it 'stubs memberships' do
      user.should_not be_team_member(123)
      user.should_not be_organization_member('foobar')

      user.stub_membership(:team => 123)
      user.stub_membership(:org => 'foobar')

      user.should be_team_member(123)
      user.should be_organization_member('foobar')
    end
  end
end
