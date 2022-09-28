class TweetsController < ApplicationController
    def index
        @tweets = Tweet.all
        @tweet = Tweet.new
        logger.debug @tweets.count
    end
    def show
        @tweet = Tweet.find(params[:id])
    end
    def new
        @tweet = Tweet.new
    end
    def create
        image = params[:tweet][:image]
        if image != nil
            image = image.read
        end
        @tweet = Tweet.new(message: params[:tweet][:message], tdate: Time.current, image: image)
        if @tweet.save
            #redirect_to '/'
            redirect_to root_path
            #redirect_to controller: :tweets, action: :index #=>一覧ページにリダイレクトする
        else
            render 'new'
        end
    end
    def delete
        @tweets = Tweet.all
    end
    def destroy
        tweet = Tweet.find(params[:id])
        tweet.destroy
        redirect_to root_path
    end
    def edit 
        @tweet = Tweet.find(params[:id])
    end
    def update
        @tweet = Tweet.find(params[:id])
        @tweet.update(message: params[:tweet][:message])
        redirect_to root_path
    end
    def get_image
        image = Tweet.find(params[:id]) 
        send_data image.image, disposition: :inline, type: 'image/png'
    end
end
