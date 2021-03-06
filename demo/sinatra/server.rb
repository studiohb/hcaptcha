require 'bundler/setup'
require 'sinatra'
require 'hcaptcha'

set :bind, 'test.mydomain.com'
set :port, 3000

Hcaptcha.configure do |config|
  config.site_key  = 'abc'
  config.secret_key = '123'
end

include Hcaptcha::Adapters::ControllerMethods
include Hcaptcha::Adapters::ViewMethods

get '/' do
  <<-HTML
    <form action="/verify">
      #{hcaptcha_tags}
      <input type="submit"/>
    </form>
  HTML
end

get '/verify' do
  if verify_hcaptcha
    'YES!'
  else
    'NO!'
  end
end
