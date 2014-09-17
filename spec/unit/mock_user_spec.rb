require 'spec_helper'

describe Warden::GitHub::Rails::TestHelpers::MockUser do
  it { should be_a Warden::GitHub::User }

  describe '#stub_membership' do
    subject(:user) { described_class.new }

    it 'stubs memberships' do
      expect(user).not_to be_team_member(123)
      expect(user).not_to be_team_member(456)
      expect(user).not_to be_organization_member('foobar')

      user.stub_membership(org: 'foobar', team: [123, '456'])

      expect(user).to be_team_member(123)
      expect(user).to be_team_member(456)
      expect(user).to be_organization_member('foobar')
    end
  end
end
