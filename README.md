# warden-github-rails

[![Build Status](https://travis-ci.org/fphilipe/warden-github-rails.png)](https://travis-ci.org/fphilipe/warden-github-rails)
[![Gem Version](https://badge.fury.io/rb/warden-github-rails.png)](http://badge.fury.io/rb/warden-github-rails)
[![Dependency Status](https://gemnasium.com/fphilipe/warden-github-rails.png)](https://gemnasium.com/fphilipe/warden-github-rails)
[![Code Climate](https://codeclimate.com/github/fphilipe/warden-github-rails.png)](https://codeclimate.com/github/fphilipe/warden-github-rails)

**WORK IN PROGRESS** --- The content in this README might not be implemented yet.

A gem for rails that provides easy GitHub OAuth integration.
It is built on top of [warden-github](https://github.com/atmos/warden-github), which gives you an easy to use [warden](https://github.com/hassox/warden) strategy to authenticate GitHub users.

## Motivation

The motivation for this gem was to provide a very easy authorization (not authentication) mechanism to existing rails apps, especially in comination with organization and team memberships.
The provided routing helpers allow you to restrict the access to resources to members of your organization or a certain team.

This is how it could look like:

```ruby
github_authenticate(:org => 'my_company_inc') do
  constraints(:subdomain => 'admin') do
    resources :users
    resources :projects

    github_authenticated(:team => :sysadmins) do
      resource :infrastructure
    end
  end
end
```

Of course, this gem can also be used for user registration and authentication.
The authenticated user is available in the controllers through a helper method.

```ruby
class UsersController < ApplicationController
  # ...

  def new
    @user = User.new(:name => current_github_user.name, :email => current_github_user.email)
  end

  def create
    attrs = params.require(:user).permit(:name, :email).merge(:github_id => current_github_user.id)
    @user = User.create(attrs)

    if @user
      redirect_to :show
    else
      render :new
    end
  end

  # ...
end
```

## Usage

Currently, the only way to enforce authentication is through the routing helpers, i.e. there are no methods or filters available in the controller to enforce authentication.

The available routing helpers are defined and documented in [lib/warden/github/rails/routes.rb](lib/warden/github/rails/routes.rb).
They all accept an optional scope.
