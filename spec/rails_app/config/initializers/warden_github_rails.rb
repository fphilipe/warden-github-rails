Warden::GitHub::Rails.setup do |config|
  config.add_scope :user,  :client_id     => 'foo',
                           :client_secret => 'bar',
                           :scope         => 'user'
  config.add_scope :admin, :client_id     => 'abc',
                           :client_secret => 'xyz',
                           :redirect_uri  => '/admin/login/callback',
                           :scope         => 'repo'
end
