require 'spec_helper'

describe Warden::GitHub::Rails::Config do
  subject(:config) { described_class.new }

  describe '#default_scope' do
    it 'defaults to :user' do
      config.default_scope.should be :user
    end
  end

  describe '#scopes' do
    it 'defaults to an empty hash' do
      config.scopes.should == {}
    end
  end

  describe '#teams' do
    it 'defaults to an empty hash' do
      config.scopes.should == {}
    end
  end

  describe '#add_scope' do
    it 'adds a scope with its configs' do
      scope_config = double
      config.add_scope :admin, scope_config
      config.scopes[:admin].should eq scope_config
    end
  end

  describe '#add_team' do
    it 'adds a name mapping for a team' do
      config.add_team :marketing, 1234
      config.teams[:marketing].should eq 1234
    end

    it 'normalizes the input' do
      config.add_team 'marketing', '1234'
      config.teams[:marketing].should eq 1234
    end
  end

  describe '#team_id' do
    context 'when passed a numeric value' do
      it 'returns that value' do
        config.team_id('1234').should eq 1234
        config.team_id(1234).should eq 1234
      end
    end

    context 'when passed an alias' do
      it 'returns the id for the alias' do
        config.add_team :marketing, 1234
        config.team_id(:marketing).should eq 1234
        config.team_id('marketing').should eq 1234
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
