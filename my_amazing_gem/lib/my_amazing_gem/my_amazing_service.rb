require 'sinatra'

class MyAmazingService < Sinatra::Base

  get '/' do
    'hello'.lively
  end

end