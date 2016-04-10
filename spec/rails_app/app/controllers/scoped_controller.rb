class ScopedController < ActionController::Base
  def authenticate
    github_authenticate!(:admin)
    head :ok
  end

  def logout
    was_logged_in = !github_user(:admin).nil?
    github_logout(:admin)
    render plain: was_logged_in
  end

  def authenticated
    render plain: github_authenticated?(:admin)
  end

  def user
    render plain: github_user(:admin)
  end

  def session
    if github_session(:admin)
      github_session(:admin)[:foo] = :bar
    end

    render json: github_session(:admin)
  end
end
