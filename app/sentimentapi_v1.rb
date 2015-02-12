require 'rubygems'
require 'grape'
require 'json'
require '3scale_client'

class SentimentApiV1 < Grape::API
    version '1', :using => :header, :vendor => '3scale' #hackish
    format :json

    @@client = ThreeScale::Client.new(:provider_key => '53b85a912ba3596fd1bc7fdbaf07afa9' )

    helpers do
        def authenticate!
            response = @@client.authrep( :user_key => params[:user_key] ,:usage => { :hits => 1 })
            error!('403 Unauthorized', 403) unless response.success?
        end

        def report!(method_name='hits', usage_value=1)
            p params[:user_key]
            response = @@client.report( {:user_key => params[:user_key],  :usage => {method_name => usage_value}})
            error!('505 Reporting Error', 505) unless response.success?
        end
    end

    resource :words do
        get ':word' do
            authenticate!
            report!('word_get', 1)
            {
                code: status,
                status: "success",
                data: {
                    word: params[:word],
                    sentiment:"unknown"
                    }
            }
        end

        post ':word' do
            authenticate!
            report!('word/post', 1)
            {
                code: status,
                status: "success",
                data: {word: params[:word], result: "thinking"}
            }
        end
    end

    resource :sentences do
        get ':sentence' do
            authenticate!
            report!('sentence/get', 1)
            {sentence: params[:sentence], result:"unknown"}
        end
    end
end
