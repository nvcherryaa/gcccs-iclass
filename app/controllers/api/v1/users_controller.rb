class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  after_action :set_access_control_headers

  def index
    payload = {}

    begin

      payload[:errors] = 0
      payload[:data] = User.all

    rescue Exception => e

      payload[:errors] = 1
      payload[:message] = e.message

    end

    render json: payload
  end

  def show
    payload = {}

    begin
      payload[:errors] = 0
      payload[:data] = User.find(params[:id])

    rescue Exception => e

      payload[:errors] = 1
      payload[:message] = e.message

    end

    render json: payload
  end

  def create

    payload = {}

    begin

      user = User.create(username: params[:username], account_type: params[:account_type])

      payload[:errors] = 0
      payload[:data] = user

      if user.errors.any?
        payload[:errors1]
        payload[:data] = user.errors.full_messages
      end

    rescue Exception => e

      payload[:errors] = 1
      payload[:message] = e.message

    end

    render json: payload
  end

  def edit_data

    payload = {}

    begin
      user = User.find(params[:user][:id]).update(user_params)
      payload[:errors] = 0
      payload[:data] = user

    rescue Exception => e

      payload[:errors] = 1
      payload[:message] = e.message

    end

    render json: payload

  end

  def delete
    payload = {}

    begin

      payload[:errors] = 0
      payload[:data] = User.find(params[:id]).destroy

    rescue Exception => e

      payload[:errors] = 1
      payload[:message] = e.message
    end

    render json: payload
  end

  def login
    payload = {}

    begin
      user =  User.where(username: params[:username], password: params[:password]).limit(1)[0]
      payload[:errors] = 0
      payload[:data] = user
    rescue Exception => e
      payload[:errors] = 1
      payload[:message] = e.message
    end

    render json: payload
  end

  private

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = "*"
    headers['Access-Control-Request-Method'] = ['OPTIONS', 'GET', 'POST', 'PUT', 'DELETE']
  end

  def user_params
    params.require(:user).permit(:username, :password, :first_name, :last_name, :middle_name, :course, :age, :gender)
  end

end
