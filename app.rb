require 'sinatra'
require 'sinatra/reloader'
require 'kramdown'

Encoding.default_external = 'utf-8'

get '/' do
    'this is toppage'
end

get '/files/:name' do
    begin
        File.open "files/#{params[:name]}" do |file|
            @md = file.read
            erb :index
        end
    rescue => e
        e.message
    end
end