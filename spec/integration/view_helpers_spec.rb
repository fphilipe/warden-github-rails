require 'spec_helper'

describe 'view helpers' do
  describe '#github_user' do
    subject(:request) { get "/view_tests/user" }

    it 'is defined' do
      request.body.should include 'true'
    end
  end

  describe '#github_authenticated?' do
    subject(:request) { get "/view_tests/authenticated" }

    it 'is defined' do
      request.body.should include 'true'
    end
  end
end
