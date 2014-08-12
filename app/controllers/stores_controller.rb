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
      redirect_to action: 'index'
    else
      render action: 'new'
    end
  end

  def show
    @store = Store.find(params[:id])
  end

  def edit
    @store = Store.find(params[:id])
  end

  def update
    @store = Store.find(params[:id])

    if @store.update(store_params)
      redirect_to action: 'show'
    else
      render action: 'edit'
    end

  end

  def destroy
    @store = Store.find(params[:id])

    if @store.destroy
      redirect_to action: 'index'
    else
      render action: 'show'
    end
  end


private

  def store_params
    params.require(:store).permit(:name)
  end


end










