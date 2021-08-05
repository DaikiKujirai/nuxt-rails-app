class ApplicationController < ActionController::API
  include Firebase::Auth::Authenticable
end
