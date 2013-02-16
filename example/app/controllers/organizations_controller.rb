class OrganizationsController < ApplicationController
  def index
    @orgs = github_user.api.organizations
  end

  def show
    @org = github_user.api.organization(params[:id])
    @members = github_user.api.organization_members(params[:id])
    @repos = github_user.api.organization_repositories(params[:id])
    @teams = github_user.api.organization_teams(params[:id])
  end
end
