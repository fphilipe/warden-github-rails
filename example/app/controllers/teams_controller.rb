class TeamsController < ApplicationController
  def show
    @team = github_user.api.team(params[:id])
    @repos = github_user.api.team_repositories(params[:id])
    @members = github_user.api.team_members(params[:id])
  end
end
