class ErrorsController < ApplicationController
  def error_404
    render 'pages/404'
  end
end