class ClientsController < ApplicationController
  def index
    @clients = Client.all
  end

  def create
  end

  def show
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])
    @client.update(client_params)
    redirect_to root_path
  end
  private

  def client_params
    params.require(:client).permit(:name, :last_name, :addres, :date_of_birth, :comment, :phone, :email)
  end
end
