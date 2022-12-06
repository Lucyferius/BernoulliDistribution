Rails.application.routes.draw do
  get "/", to: "bernoulies#get"
  post "/", to: "bernoulies#post"
end
