Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  resources :messages, only: [:new, :create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root('welcome#index')
  get('delete_all_method',to:'addresses#delete_all_method')
 	post 'addresses/favorite/:id' => 'addresses#favorite', as: 'add_favorite'

  resources :welcome, only: [:index]
  resources :addresses
 	resources :password_resets, only: [:new, :create, :edit, :update]
  get('login',to:'sessions#new')
	post('login',to:'sessions#create')
	delete('logout',to:'sessions#destroy')

	get('signup',to:'users#new')
	post('signup',to:'users#create')
	#Profile_edit UsersController
	get('profile',to:'users#edit')
	patch('signup',to:'users#update')
	
end
