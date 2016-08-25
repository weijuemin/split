Rails.application.routes.draw do
	
  root 'sessions#index'
  get '/sessions/' => 'sessions#loginPage'
  get '/sessions/new' => 'sessions#registerPage'
  post '/sessions/login' => 'sessions#login'

  post '/users/create' => 'users#create'
  get '/users/' => 'users#show'
  get '/users/edit' => 'users#edit'
  patch "/users/" => "users#update"
  get '/users/logout' => 'sessions#reset'

  get '/groups' => 'groups#display'
  get '/groups/:group_id' => 'groups#show'
  post "/groups" => "groups#create"
  patch "/groups" => "groups#addmember"
  get "/getusers" => "groups#getUsers"
  patch "/groups/:g_id/members" => "groups#membership_create"

  get '/expenses/:expense_id' => 'expenses#show'
  get '/expenses/:group_id/new' => 'expenses#new'
  post '/expenses/:group_id' => 'expenses#create'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
