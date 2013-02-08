RailsApp::Application.routes.draw do
  github_authenticate    { get '/protected'           => 'application#show' }
  github_authenticated   { get '/conditional'         => 'application#show' }
  github_unauthenticated { get '/conditional_inverse' => 'application#show' }

  github_authenticate(:admin)    { get '/admin/protected'           => 'application#show' }
  github_authenticated(:admin)   { get '/admin/conditional'         => 'application#show' }
  github_unauthenticated(:admin) { get '/admin/conditional_inverse' => 'application#show' }
end
