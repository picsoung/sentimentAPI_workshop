require 'rubygems'
require 'grape'
require 'json'

class SentimentApiV1 < Grape::API
    version 'v1', :using => :path, :vendor => '3scale'

    resource :words do
        get ':word' do
            {word: params[:word], sentiment:"unknown"}
        end

        post ':word' do
            {word: params[:word], result: "thinking"}
        end
    end

    resource :sentences do
        get ':sentence' do
            {sentence: params[:sentence], result:"unknown"}
        end
    end
end
