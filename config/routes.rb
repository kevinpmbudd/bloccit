Rails.application.routes.draw do
  resources :posts, :advertisements

  get 'about' => 'welcome#about'

  # get 'welcome/contact'

  # get 'welcome/faq'

  root 'welcome#index'
end
