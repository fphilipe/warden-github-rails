require 'spec_helper'

describe 'controller helpers' do
  {
    scoped:   :admin,
    unscoped: Warden::GitHub::Rails.default_scope
  }.each do |type, scope|
    context "when using #{type}" do
      describe '#github_authenticate!' do
        subject(:request) { get "/#{type}/authenticate" }

        context 'when not logged in' do
          it 'initiates the oauth flow' do
            expect(request).to be_github_oauth_redirect
          end
        end

        context 'when logged in' do
          before { github_login(scope) }
          it 'does nothing' do
            expect(request).to be_ok
          end
        end
      end

      describe '#github_logout' do
        context 'when not logged in' do
          it 'does nothing' do
            expect(get("/#{type}/logout").body).to eq('false')
          end
        end

        context 'when logged in' do
          it 'logs out the user' do
            github_login(scope)
            expect(get("/#{type}/logout").body).to eq('true')
            expect(get("/#{type}/logout").body).to eq('false')
          end
        end
      end

      describe '#github_authenticated?' do
        subject(:request) { get "/#{type}/authenticated" }

        context 'when not logged in' do
          it 'returns false' do
            expect(request.body).to eq('false')
          end
        end

        context 'when logged in' do
          it 'returns true' do
            github_login(scope)
            expect(request.body).to eq('true')
          end
        end
      end

      describe '#github_user' do
        subject(:request) { get "/#{type}/user" }

        context 'when not logged in' do
          it 'returns nil' do
            expect(request.body).to be_blank
          end
        end

        context 'when logged in' do
          it 'returns the logged in user' do
            github_login(scope)
            expect(request.body).to \
              include('Warden::GitHub::Rails::TestHelpers::MockUser')
          end
        end
      end

      describe '#github_session' do
        subject(:request) { get "/#{type}/session" }

        context 'when not logged in' do
          it 'returns nil' do
            expect(request.body).to eq('null')
          end
        end

        context 'when logged in' do
          it "returns the user's session" do
            github_login(scope)
            expect(request.body).to eq({ foo: :bar }.to_json)
          end
        end
      end
    end
  end
end
