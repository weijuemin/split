Rails.application.routes.draw do
	
  root 'sessions#index'

  post '/sessions/login' => 'sessions#login'

  post '/users/create' => 'users#create'

	get 'group/:id' => 'groups#show'
	get 'expense/:id' => 'expenses#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
