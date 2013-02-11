require 'spec_helper'

describe 'controller helpers' do
  {
    :scoped   => :admin,
    :unscoped => Warden::GitHub::Rails.default_scope
  }.each do |type, scope|
    context "when using #{type}" do
      describe '#github_authenticate!' do
        subject(:request) { get "/#{type}/authenticate" }

        context 'when not logged in' do
          it 'initiates the oauth flow' do
            request.should be_github_oauth_redirect
          end
        end

        context 'when logged in' do
          before { github_login(scope) }
          it 'does nothing' do
            request.should be_ok
          end
        end
      end

      describe '#github_logout' do
        context 'when not logged in' do
          it 'does nothing' do
            get("/#{type}/logout").body.should eq 'false'
          end
        end

        context 'when logged in' do
          it 'logs out the user' do
            github_login(scope)
            get("/#{type}/logout").body.should eq 'true'
            get("/#{type}/logout").body.should eq 'false'
          end
        end
      end

      describe '#github_authenticated?' do
        subject(:request) { get "/#{type}/authenticated" }

        context 'when not logged in' do
          it 'returns false' do
            request.body.should eq 'false'
          end
        end

        context 'when logged in' do
          it 'returns true' do
            github_login(scope)
            request.body.should eq 'true'
          end
        end
      end

      describe '#github_user' do
        subject(:request) { get "/#{type}/user" }

        context 'when not logged in' do
          it 'returns nil' do
            request.body.should be_blank
          end
        end

        context 'when logged in' do
          it 'returns the logged in user' do
            github_login(scope)
            request.body.
              should include 'Warden::GitHub::Rails::TestHelpers::MockUser'
          end
        end
      end

      describe '#github_session' do
        subject(:request) { get "/#{type}/session" }

        context 'when not logged in' do
          it 'should be nil' do
            request.body.should be_blank
          end
        end

        context 'when logged in' do
          it "returns the user's session" do
            github_login(scope)
            request.body.should == { :foo => :bar }.to_s
          end
        end
      end
    end
  end
end
