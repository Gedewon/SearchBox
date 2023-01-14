class Api::V1::SearchController < ApplicationController
  def index
    @a =  ['sofi','sssfadf','sdfasfds']
   render json: @a.select {|ele| ele.include?(params[:q])}
  end
end
