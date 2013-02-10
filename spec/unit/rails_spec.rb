require 'spec_helper'

describe Warden::GitHub::Rails do
  describe '.setup' do
    it 'yields the a config instance' do
      described_class.setup do |config|
        config.should be_a described_class::Config
      end
    end
  end
end
