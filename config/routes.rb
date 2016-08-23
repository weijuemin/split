Rails.application.routes.draw do
	get 'group/:group_id' => 'groups#show'
	get 'expense/:expense_id' => 'expenses#show'
	get 'expense/:group_id/new' => 'expenses#new'
	post 'group/:group_id' => 'expenses#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
