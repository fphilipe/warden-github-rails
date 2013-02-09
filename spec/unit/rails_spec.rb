require 'spec_helper'

describe Warden::GitHub::Rails do
  describe '.setup' do
    it 'yields the Config module' do
      described_class.setup do |config|
        config.should be described_class::Config
      end
    end
  end
end
