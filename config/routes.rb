Rails.application.routes.draw do
  scope '/api' do
    devise_for :users, controllers: { sessions: 'sessions', registrations: 'registrations' }
    get "/auth/linkedin/callback", to: "authentications#linkedin"
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  mount EmberCLI::Engine => "ember_tests" if Rails.env.development?
  root 'index#index'
end
