class UsersController < ApplicationController
  def show
    @user = github_user.api.user(params[:id])
    @repos = github_user.api.repos(params[:id])
  end
end
