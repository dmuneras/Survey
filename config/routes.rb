# -*- coding: utf-8 -*-
ActionController::Routing::Routes.draw do |map|

 # -> Definicion de las rutas del proyecto. POSDATA: todo esta dentro del path_names porque deseamos que las rutas fueran
 # en español.

  # map.with_options :path_names => {:new => 'nuevo', :show => 'mostrar', :edit => 'editar',:create => 'crear'} do |r|

  # #definicion de la ruta anidad /empresa/usuarios
  # r.resources :companies,:as=> 'empresas' do |company|
  # company.resources :users, :as => 'usuarios',
  # :path_names => {:new => 'nuevo', :edit => 'editar', :create => 'crear'}, :shallow => true
  # end
  # r.resources :surveys, :as => 'encuestas'
  # r.resources :surveys, :member => {:next_question => :get}
  # r.resources :answers, :as => 'respuestas'
  # r.resources :questions, :as => 'preguntas'
  # r.resources :subsectors, :as => 'subsectores'
  # r.resources :chart, :as => 'resultados'
  # end
  map.resources :questions
  map.resources :answers
  map.resources :companies ,:has_many => :users, :shallow => true
  map.resources :subsectors
  map.resources :surveys, :member => {:next_question => :get}
  map.resources :chart
  map.resources :user_sessions
  map.resources :company_sessions
  map.resources :survey_records
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
