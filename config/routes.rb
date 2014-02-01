Static::Application.routes.draw do
  
  devise_for :users
  
  root to: "home#index"
  
  get "assessments/:assessment_id", to: "assessment#edit", as: :edit_assessment
  put "assessments/:assessment_id", to: "assessment#update"
  
  get "assessments/:assessment_id/users/:user_id", to: "assessment#show", as: :user_assessment
  
  get "manager_reviews", to: "manager_reviews#index", as: :manager_reviews
  post "manager_reviews", to: "manager_reviews#create"
  get "manager_reviews/new", to: "manager_reviews#new", as: :new_manager_review
  get "manager_reviews/:id", to: "manager_reviews#show", as: :manager_review
  
  get "manager_reviewer/:token", to: "manager_reviewer#new", as: :review_manager
  post "manager_reviewer/:token", to: "manager_reviewer#create"
  
  # get "assessments/:assessment_id/users/:user_id/form", to: "scores#edit", as: :assessment_form
  # put "assessments/:assessment_id/users/:user_id/form", to: "scores#update"
  
  # Tester Bar
  post "tester_bar/:action", controller: "tester_bar" if Rails.env.development?
  
end
