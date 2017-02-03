class Api::V1::SessionsController < ApplicationController
  def log_in code
    puts '?>>>>>>>>>>>>>>>>>>>'
    puts params[:code]
  end
end