require 'rubygems'
require 'grape'
require 'json'
require '3scale_client'

class SentimentApiV1 < Grape::API
    version '1', :using => :header, :vendor => '3scale' #hackish
    format :json
    
    helpers do
        def authenticate!
            client = ThreeScale::Client.new(:provider_key => '53b85a912ba3596fd1bc7fdbaf07afa9' )
            response = client.authrep( :user_key => params[:user_key] ,:usage => { :hits => 1 })
            error!('403 Unauthorized', 403) unless response.success?
        end
    end

    resource :words do
        get ':word' do
            authenticate!
            {word: params[:word], sentiment:"unknown"}
        end

        post ':word' do
            authenticate!
            {word: params[:word], result: "thinking"}
        end
    end

    resource :sentences do
        get ':sentence' do
            authenticate!
            {sentence: params[:sentence], result:"unknown"}
        end
    end
end
