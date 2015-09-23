require 'spec_helper'

describe 'request to a protected resource' do
  context 'that requires a team membership' do
    context 'which is specified by a numeric team id' do
      subject { get '/team/protected' }

      context 'when not logged in' do
        it { is_expected.to be_github_oauth_redirect }
      end

      context 'when logged in' do
        context 'and team member' do
          before do
            user = github_login
            user.stub_membership(team: 123)
          end

          it { is_expected.to be_ok }
        end

        context 'and not team member' do
          before { github_login }
          it { is_expected.to be_not_found }
        end
      end
    end

    context 'which is specified by multiple numeric team ids' do
      subject { get '/multi_team/protected' }

      context 'when not logged in' do
        it { is_expected.to be_github_oauth_redirect }
      end

      context 'when logged in' do
        context 'and a first team member' do
          before do
            user = github_login
            user.stub_membership(team: 123)
          end

          it { is_expected.to be_ok }
        end

        context 'and another team member' do
          before do
            user = github_login
            user.stub_membership(team: 345)
          end

          it { is_expected.to be_ok }
        end

        context 'and not team member' do
          before { github_login }
          it { is_expected.to be_not_found }
        end
      end
    end

    context 'which is specified by a team alias' do
      subject { get '/multi_team_alias/protected' }

      context 'when not logged in' do
        it { is_expected.to be_github_oauth_redirect }
      end

      context 'when logged in' do
        context 'and a first team member' do
          before do
            user = github_login
            user.stub_membership(team: 456)
          end

          it { is_expected.to be_ok }
        end

        context 'and another team member' do
          before do
            user = github_login
            user.stub_membership(team: 789)
          end

          it { is_expected.to be_ok }
        end

        context 'and not team member' do
          before { github_login }
          it { is_expected.to be_not_found }
        end
      end
    end

    context 'which is specified by multiple team aliases' do
      subject { get '/team_alias/protected' }

      context 'when not logged in' do
        it { is_expected.to be_github_oauth_redirect }
      end

      context 'when logged in' do
        context 'and team member' do
          before do
            user = github_login
            user.stub_membership(team: 456)
          end

          it { is_expected.to be_ok }
        end

        context 'and not team member' do
          before { github_login }
          it { is_expected.to be_not_found }
        end
      end
    end

    context 'which is specified by a lambda' do
      subject { get '/dynamic_team/123' }

      context 'when logged in' do
        context 'and team member' do
          before do
            user = github_login
            user.stub_membership(team: 123)
          end

          it { is_expected.to be_ok }
        end

        context 'and not team member' do
          before { github_login }
          it { is_expected.to be_not_found }
        end
      end
    end
  end

  context 'that requires an organization membership' do
    { org: :foobar_inc, organization: 'some_org' }.each do |key, value|
      context "which is specified as #{key}" do
        subject { get "/#{key}/protected" }

        context 'when not logged in' do
          it { is_expected.to be_github_oauth_redirect }
        end

        context 'when logged in' do
          context 'and organization member' do
            before do
              user = github_login
              user.stub_membership(org: value)
            end

            it { is_expected.to be_ok }
          end

          context 'and not organization member' do
            before { github_login }
            it { is_expected.to be_not_found }
          end
        end
      end
    end

    context 'which is specified by a lambda' do
      subject { get '/dynamic_org/some_org' }

      context 'when logged in' do
        context 'and organization member' do
          before do
            user = github_login
            user.stub_membership(org: 'some_org')
          end

          it { is_expected.to be_ok }
        end

        context 'and not organization member' do
          before { github_login }
          it { is_expected.to be_not_found }
        end
      end
    end
  end
end

describe 'request to a resource that only exists when logged in' do
  context 'that requires a team membership' do
    context 'which is specified by a numeric team id' do
      subject { get '/team/conditional' }

      context 'when team member' do
        before do
          user = github_login
          user.stub_membership(team: 123)
        end

        it { is_expected.to be_ok }
      end

      context 'when not team member' do
        before { github_login }
        it { is_expected.to be_not_found }
      end
    end

    context 'which is specified by multiple numeric team ids' do
      subject { get '/multi_team/conditional' }

      context 'when a first team member' do
        before do
          user = github_login
          user.stub_membership(team: 123)
        end

        it { is_expected.to be_ok }
      end

      context 'when another team member' do
        before do
          user = github_login
          user.stub_membership(team: 345)
        end

        it { is_expected.to be_ok }
      end

      context 'when not team member' do
        before { github_login }
        it { is_expected.to be_not_found }
      end
    end

    context 'which is specified by a team alias' do
      subject { get '/team_alias/conditional' }

      context 'when team member' do
        before do
          user = github_login
          user.stub_membership(team: 456)
        end

        it { is_expected.to be_ok }
      end

      context 'when not team member' do
        before { github_login }
        it { is_expected.to be_not_found }
      end
    end

    context 'which is specified by multiple team aliases' do
      subject { get '/multi_team_alias/conditional' }

      context 'when a member of the first team' do
        before do
          user = github_login
          user.stub_membership(team: 456)
        end

        it { is_expected.to be_ok }
      end

      context 'when a member of another team' do
        before do
          user = github_login
          user.stub_membership(team: 789)
        end

        it { is_expected.to be_ok }
      end

      context 'when not a team member' do
        before { github_login }
        it { is_expected.to be_not_found }
      end
    end
  end

  context 'that requires an organization membership' do
    { org: :foobar_inc, organization: 'some_org' }.each do |key, value|
      context "which is specified as #{key}" do
        subject { get "/#{key}/conditional" }

        context 'when organization member' do
          before do
            user = github_login
            user.stub_membership(org: value)
          end

          it { is_expected.to be_ok }
        end

        context 'when not organization member' do
          before { github_login }
          it { is_expected.to be_not_found }
        end
      end
    end
  end
end
