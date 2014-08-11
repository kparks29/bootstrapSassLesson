class StoresController < ApplicationController

  def index
    @stores = Store.all
  end

  def new
    @store = Store.new
  end

  def create
    @store = Store.new(store_params)

    if @store.save
      @stores = Store.all
      render action: 'index'
    else
      render action: 'new'
    end
  end



private

  def store_params
    params.require(:store).permit(:name)
  end


end










