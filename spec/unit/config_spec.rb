require 'spec_helper'

describe Warden::GitHub::Rails::Config do
  subject(:config) { described_class.new }

  describe '#default_scope' do
    it 'defaults to :user' do
      expect(config.default_scope).to eq(:user)
    end
  end

  describe '#scopes' do
    it 'defaults to an empty hash' do
      expect(config.scopes).to eq({})
    end
  end

  describe '#teams' do
    it 'defaults to an empty hash' do
      expect(config.scopes).to eq({})
    end
  end

  describe '#add_scope' do
    it 'adds a scope with its configs' do
      scope_config = double
      config.add_scope :admin, scope_config
      expect(config.scopes[:admin]).to eq(scope_config)
    end
  end

  describe '#add_team' do
    it 'adds a name mapping for a team' do
      config.add_team :marketing, 1234
      expect(config.teams[:marketing]).to eq(1234)
    end

    it 'normalizes the input' do
      config.add_team 'marketing', '1234'
      expect(config.teams[:marketing]).to eq(1234)
    end
  end

  describe '#team_id' do
    context 'when passed a numeric value' do
      it 'returns that value' do
        expect(config.team_id('1234')).to eq(1234)
        expect(config.team_id(1234)).to eq(1234)
      end
    end

    context 'when passed an alias' do
      it 'returns the id for the alias' do
        config.add_team :marketing, 1234
        expect(config.team_id(:marketing)).to eq(1234)
        expect(config.team_id('marketing')).to eq(1234)
      end
    end

    context 'when no mapping exists' do
      it 'raises a BadConfig' do
        expect { config.team_id(:foobar) }.
          to raise_error(Warden::GitHub::Rails::Config::BadConfig)
      end
    end
  end
end
