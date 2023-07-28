class SearchesController < ApplicationController
  
  def search
    @range = params[:range]
    @searchword = params[:searchword]
    
    if @range == "User"
      @users = User.looks(params[:search], params[:searchword])
      
    else
      @books = Book.looks(params[:search], params[:searchword])
      
    end
    
  end
  
end
