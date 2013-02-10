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

  describe '#add_scope' do
    it 'adds a scope with its configs' do
      scope_config = double
      config.add_scope :admin, scope_config
      config.scopes[:admin].should eq scope_config
    end
  end
end
