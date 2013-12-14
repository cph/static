Static::Application.routes.draw do
  
  devise_for :users
  
  root to: "home#index"
  
  # Tester Bar
  post "tester_bar/:action", controller: "tester_bar" if Rails.env.development?
  
end
