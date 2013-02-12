# warden-github-rails

[![Build Status](https://travis-ci.org/fphilipe/warden-github-rails.png)](https://travis-ci.org/fphilipe/warden-github-rails)
[![Gem Version](https://badge.fury.io/rb/warden-github-rails.png)](http://badge.fury.io/rb/warden-github-rails)
[![Dependency Status](https://gemnasium.com/fphilipe/warden-github-rails.png)](https://gemnasium.com/fphilipe/warden-github-rails)
[![Code Climate](https://codeclimate.com/github/fphilipe/warden-github-rails.png)](https://codeclimate.com/github/fphilipe/warden-github-rails)

A gem for rails that provides easy GitHub OAuth integration.
It is built on top of [warden-github](https://github.com/atmos/warden-github), which gives you an easy to use [warden](https://github.com/hassox/warden) strategy to authenticate GitHub users.

## Motivation

**Wouldn't it be nice to**

- use your organization and it's teams for user access control?
- add a new employee to your GitHub organization or team in order to grant them access to your app's admin area?

The motivation for this gem was to provide a very easy authorization (not authentication) mechanism to existing rails apps for admins, especially in combination with organization and team memberships.
The provided routing helpers do exactly that.
They allow you to restrict access to members of your organization or a certain team.

This is how your rails `routes.rb` could look like:

```ruby
constraints(:subdomain => 'admin') do
  github_authenticate(:org => 'my_company_inc') do
    resources :users
    resources :projects

    github_authenticated(:team => 'sysadmins') do
      resource :infrastructure
    end
  end
end
```

Of course, this gem can also be used for user registration and authentication.
Several helper methods are available in the controller to accomplish this:

```ruby
class UsersController < ApplicationController
  # ...

  def new
    github_authenticate! # Performs OAuth flow when not logged in.
    @user = User.new(:name => github_user.name, :email => github_user.email)
  end

  def create
    attrs = params.require(:user).permit(:name, :email).merge(:github_id => github_user.id)
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

### Configuration

First off, you might want to configure this gem by creating an initializer such as `config/initializers/warden_github_rails.rb`.
There you can define:

- various scopes and their configs (scopes are types of users with different configs)
- the default scope (which is `:user` by default)
- team aliases (GitHub teams are identified by a numerical ID; defining an alias for a team makes it easier to use)

Here's how such a config might look like:

```ruby
Warden::GitHub::Rails.setup do |config|
  config.add_scope :user,  :client_id     => 'foo',
                           :client_secret => 'bar',
                           :scope         => 'user'

  config.add_scope :admin, :client_id     => 'abc',
                           :client_secret => 'xyz',
                           :redirect_uri  => '/admin/login/callback',
                           :scope         => 'repo'

  config.default_scope = :admin

  config.add_team :marketing, 456
end
```

For a list of allowed config parameters to use in `#add_scope`, read the [warden-github documentation](https://github.com/atmos/warden-github#parameters).

### Inside `routes.rb`

The available routing helpers are defined and documented in [lib/warden/github/rails/routes.rb](lib/warden/github/rails/routes.rb).
They all accept an optional scope that, when omitted, falls back to the default_scope configured in the initializer.

Examples:

```ruby
# Performs login if not logged in already.
github_authenticate do
  resource :profile
end

# Does not perform login when not logged in.
github_authenticated do
  delete '/logout' => 'sessions#delete'
end

# Only matches when not logged in. Does not perform login.
github_unauthenticated do
  resource :registration
end

# Only matches when member of the organization. Initiates login if not logged in.
github_authenticate(:org => 'my_company') do
  resource :admin
end

# Only matches when member of the team. Does not initiate login if not logged in.
github_authenticated(:team => 'markting') do
  get '/dashboard' => 'dashboard#show'
end
```

### Inside a Controller

The available controller helpers are defined and documented in [lib/warden/github/rails/controller_helpers.rb](lib/warden/github/rails/controller_helpers.rb).
They all accept an optional scope that, when omitted, falls back to the default_scope configured in the initializer.

```ruby
class SomeController < ActionController::Base
  def show
    @is_admin = github_authenticated?(:admin)
  end

  def delete
    github_logout
    redirect_to '/'
  end

  def settings
    github_authenticate!
    @settings = UserSettings.find_by_github_user_id(github_user.id)
  end

  def finish_wizard
    github_session[:wizard_completed] = true
  end

  def followers
    @followers = github_user.api.followers
  end
end
```

### Communicating with the GitHub API

Once a user is logged in, you'll have access to it in the controller using `github_user`. It is an instance of `Warden::GitHub::User` which is defined in the [warden-github](https://github.com/atmos/warden-github/blob/master/lib/warden/github/user.rb) gem. The instance has several methods to access user information such as `#name`, `#id`, `#email`, etc. It also features a method `#api` which returns a preconfigured [Octokit](https://github.com/pengwynn/octokit) client for that user.

## Known Limitations

Currently, this gem does not play nicely with [Devise](https://github.com/plataformatec/devise). Devise is built on top of warden and performs some monkeypatching of warden which breaks this gem. Support will be added as soon as possible.

## Additional Information

### Dependencies

- [warden-github](https://github.com/atmos/warden-github)
    - [warden](https://github.com/hassox/warden)
    - [octokit](https://github.com/pengwynn/octokit)

### Maintainers

- Philipe Fatio ([@fphilipe](https://github.com/fphilipe))

### License

MIT License. Copyright 2013 Philipe Fatio
