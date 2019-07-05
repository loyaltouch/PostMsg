require 'sinatra'
require 'sinatra/reloader'
require 'kramdown'

Encoding.default_external = 'utf-8'

get '/' do
    begin
        @files = Dir.glob('files/*')
        erb :index
    rescue => e
        e.message
    end
end

get '/files/:name' do
    begin
        File.open "files/#{params[:name]}" do |file|
            @md = file.read
            erb :content
        end
    rescue => e
        e.message
    end
end