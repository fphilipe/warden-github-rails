class ApplicationController < ActionController::Base
  def show
    render :text => 'hello'
  end
end
