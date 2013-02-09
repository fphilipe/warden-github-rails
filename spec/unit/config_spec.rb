require 'spec_helper'

describe Warden::GitHub::Rails::Config do
  describe '#default_scope' do
    it 'defaults to :user' do
      described_class.default_scope.should be :user
    end
  end

  describe '#scopes' do
    it 'defaults to an empty hash' do
      described_class.scopes.should == {}
    end
  end

  describe '#add_scope' do
    it 'adds a scope with its configs' do
      config = double
      described_class.add_scope :admin, config
      described_class.scopes[:admin].should eq config
    end
  end
end
