RailsApp::Application.routes.draw do
  github_authenticate    { get '/protected'           => 'application#show' }
  github_authenticated   { get '/conditional'         => 'application#show' }
  github_unauthenticated { get '/conditional_inverse' => 'application#show' }

  github_authenticate(:admin)    { get '/admin/protected'           => 'application#show' }
  github_authenticated(:admin)   { get '/admin/conditional'         => 'application#show' }
  github_unauthenticated(:admin) { get '/admin/conditional_inverse' => 'application#show' }

  github_authenticate(:team => 123)  { get '/team/protected'   => 'application#show' }
  github_authenticated(:team => 123) { get '/team/conditional' => 'application#show' }

  github_authenticate(:org => :foobar_inc)  { get '/org/protected'   => 'application#show' }
  github_authenticated(:org => :foobar_inc) { get '/org/conditional' => 'application#show' }

  github_authenticate(:organization => 'some_org')  { get '/organization/protected'   => 'application#show' }
  github_authenticated(:organization => 'some_org') { get '/organization/conditional' => 'application#show' }

  match '*all' => lambda { |env| [404, {}, []] }
end
