Warden::GitHub::Rails.setup do |config|
  config.add_scope :user,  :client_id     => ENV['GITHUB_CLIENT_ID'] || 'foo',
                           :client_secret => ENV['GITHUB_CLIENT_SECRET'] || 'bar',
                           :scope         => 'user'

  config.add_scope :admin, :client_id     => ENV['GITHUB_CLIENT_ID'] || 'abc',
                           :client_secret => ENV['GITHUB_CLIENT_SECRET'] || 'xyz',
                           :redirect_uri  => '/admin/login/callback',
                           :scope         => 'repo'

  config.add_team :marketing, 456
end
