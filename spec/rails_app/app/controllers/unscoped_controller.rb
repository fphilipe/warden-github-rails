class UnscopedController < ActionController::Base
  def authenticate
    github_authenticate!
    render :nothing => true
  end

  def logout
    was_logged_in = !github_user.nil?
    github_logout
    render :text => was_logged_in
  end

  def authenticated
    render :text => github_authenticated?
  end

  def user
    render :text => github_user
  end

  def session
    if (session = github_session)
      session[:foo] = :bar
    end

    render :text => github_session
  end
end
