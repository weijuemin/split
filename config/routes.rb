Rails.application.routes.draw do
	get 'group/:id' => 'groups#show'
	get 'expense/:id' => 'expenses#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
