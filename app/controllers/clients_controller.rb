class ClientsController < ApplicationController
  # include ActionController::ConditionalGet
  def index
    @clients = Rails.cache.fetch('clients', expires_in: 5.minutes ) do
      clients = Client.all.to_a
    end
  end

  def create
  end

  def show
    @client = Rails.cache.fetch('client:#{params[:id]}', expires_in: 5.minutes ) do
      Client.find(params[:id])
    end
  end

  def update
    @client = Client.find(params[:id])
    if  @client.update(client_params)
      Rails.cache.delete('client:#{params[:id]}') 
    end
    redirect_to root_path
  end

  def destroy
    @client = Client.find(params[:id])
   if @client.destroy
    Rails.cache.delete('client:#{params[:id]}')
    end
    redirect_to root_path
  end

  private
  def client_params
    params.permit(:name, :last_name, :addres, :date_of_birth, :comment, :phone, :email)
  end  
end
