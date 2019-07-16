Rails.application.routes.draw do
  
	post 'insta_follower/find_followers'
	get 'insta_follower/find_followers'
  	root 'insta_follower#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
