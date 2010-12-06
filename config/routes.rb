# -*- coding: utf-8 -*-
ActionController::Routing::Routes.draw do |map|

  map.resources :base
  map.resources :questions
  map.resources :answers
  map.resources :companies ,:has_many => :users, :shallow => true
  map.resources :subsectors
  map.resources :surveys, :member => {:next_question => :get}
  map.resources :chart
  map.resources :user_sessions
  map.resources :company_sessions
  map.resources :survey_records, :member => {:compare => :get}
  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"
  map.admin_company "admin_company", :controller => "company_sessions", :action => "new"
  map.logout_company "logout_company", :controller => "company_sessions", :action => "destroy"
  
  #--> PAGINA INICIAL
  map.root :controller => 'base', :action => 'index'

  #-> Forma por defecto como rails conecta los urls.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
