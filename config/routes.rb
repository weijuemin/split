Rails.application.routes.draw do
	
  root 'sessions#index'

  post '/sessions/login' => 'sessions#login'

  post '/users/create' => 'users#create'

  get '/users/' => 'users#show'

	get '/group/:group_id' => 'groups#show'
	get '/expense/:expense_id' => 'expenses#show'
	get '/expense/:group_id/new' => 'expenses#new'
	post '/group/:group_id' => 'expenses#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
