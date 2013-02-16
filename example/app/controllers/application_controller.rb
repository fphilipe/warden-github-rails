class ApplicationController < ActionController::Base
  def not_found
    render :status => 404
  end
end
