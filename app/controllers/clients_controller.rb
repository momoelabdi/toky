class ClientsController < ApplicationController
  include ActionController::ConditionalGet

  before_action :set_client, only: [:show, :update, :destroy]

  def index
    @clients = Rails.cache.fetch('clients', expires_in: 5.minutes, skip_nil: true ) do
      clients = Client.order(id: :desc).all
      fresh_when etag: clients
      clients
    end
  end

  def create
    if client.save
      expire_cache_for(client)
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    fresh_when etag: @client
  end

  def update
    if @client.update(client_params)
      expire_cache_for(@client)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if @client.destroy
      expire_cache_for(@client)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def set_client
    @client = Rails.cache.fetch("client:#{params[:id]}", expires_in: 5.minutes, skip_nil: true ) do
      Client.find(params[:id])
    end
  end

  def client_params
    params.permit(:name, :last_name, :addres, :date_of_birth, :comment, :phone, :email)
  end

  def expire_cache_for(client)
    Rails.cache.delete("client:#{client.id}")
    expire_fragment('clients')
  end
end
