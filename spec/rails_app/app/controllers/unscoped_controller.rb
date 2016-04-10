class UnscopedController < ActionController::Base
  def authenticate
    github_authenticate!
    head :ok
  end

  def logout
    was_logged_in = !github_user.nil?
    github_logout
    render plain: was_logged_in
  end

  def authenticated
    render plain: github_authenticated?
  end

  def user
    render plain: github_user
  end

  def session
    if github_session
      github_session[:foo] = :bar
    end

    render json: github_session
  end
end
