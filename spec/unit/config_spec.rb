require 'spec_helper'

describe Warden::GitHub::Rails::Config do
  describe '#default_scope' do
    it 'defaults to :user' do
      described_class.default_scope.should be :user
    end
  end
end
