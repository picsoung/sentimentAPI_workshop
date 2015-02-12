require 'rubygems'
require 'grape'
require 'json'

class SentimentApiV1 < Grape::API
    version '1', :using => :header, :vendor => '3scale' #hackish
    format :json

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
