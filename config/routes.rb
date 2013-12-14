Static::Application.routes.draw do
  
  devise_for :users
  
  root to: "home#index"
  
  get "assessments/:assessment_id/users/:user_id/form", to: "scores#edit", as: :assessment_form
  put "assessments/:assessment_id/users/:user_id/form", to: "scores#update"
  
  # Tester Bar
  post "tester_bar/:action", controller: "tester_bar" if Rails.env.development?
  
end
