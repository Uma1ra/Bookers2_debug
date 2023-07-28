class SearchesController < ApplicationController
  
  def search
    @searchword = params[:searchword]
    @range = params[:range]
    @search = params[:search]
    
    if @range == "User"
      @users = User.looks(@searchword, @search)
      
    else
      @books = Book.looks(@searchword, @search)
      
    end
    
  end
  
end
