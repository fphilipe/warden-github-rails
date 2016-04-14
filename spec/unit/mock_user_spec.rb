require 'spec_helper'

describe Warden::GitHub::Rails::TestHelpers::MockUser do
  it { is_expected.to be_a Warden::GitHub::User }

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

  it 'can be serialized and deserialized with JSON' do
    user = described_class.new
    user.stub_membership(org: ['apple', 'facebook'], team: [12, 34])

    json = ActiveSupport::JSON.encode(user.marshal_dump)
    marshaled_user = described_class.new.tap do |u|
      u.marshal_load(ActiveSupport::JSON.decode(json))
    end

    expect(marshaled_user.memberships).to eq(user.memberships)
  end
end
