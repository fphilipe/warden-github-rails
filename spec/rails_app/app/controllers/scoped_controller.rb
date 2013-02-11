class ScopedController < ActionController::Base
  def authenticate
    github_authenticate!(:admin)
    render :nothing => true
  end

  def logout
    was_logged_in = !github_user(:admin).nil?
    github_logout(:admin)
    render :text => was_logged_in
  end

  def authenticated
    render :text => github_authenticated?(:admin)
  end

  def user
    render :text => github_user(:admin)
  end

  def session
    if (session = github_session(:admin))
      session[:foo] = :bar
    end

    render :text => github_session(:admin)
  end
end
