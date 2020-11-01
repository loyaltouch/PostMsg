require 'sinatra'
require 'sinatra/base'
require 'sinatra/config_file'
require 'sinatra/reloader'
require 'kramdown'

Encoding.default_external = 'utf-8'

class MyApp < Sinatra::Base
    register Sinatra::ConfigFile
    config_file './config.yml'

    def initialize
        @filesetting = settings.files || 'files'
    end

    get '/' do
        begin
#            @files = Dir.glob('files/*')
#            @files = Dir.glob(@filesetting + '/*')
            @files = Pathname.glob(@filesetting + "/*").map(&:basename)
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
end
