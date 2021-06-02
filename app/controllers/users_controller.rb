class UsersController < ApplicationController
	before_action :authorized, except: [:create, :login]
	before_action :set_user, only: [:show, :update]

	def index
		@users = User.all
	end

	def show
		unless @user
			render json: { message: 'Usuário não existe' }, status: :not_found
		end
	end

	def create
		@user = User.find_by(email: params[:email])
		if @user
			render json: { message: "Usuário já existe"}, status: :unauthorized
		else
			@user = User.create(user_params)
			if @user.valid? and @user.authenticate(params[:password])
				token = encode_token({user_id: @user.id})
				render json: { token: token }, status: :created
			elsif @user.errors
				render json: { message: @user.errors.messages.values.flatten.first }, status: :bad_request
			else
				render json: { message: 'unauthorized' }, status: :unauthorized
			end
		end
	end

	def update
	end

	def destroy
		if logged_in_user.present?
			logged_in_user.destroy
		end
	end

	def login
		if params[:email].blank?
			render json: { message: "\"email\" is not allowed to be blank" }, status: :bad_request
		elsif params[:password].blank?
			render json: { message: "\"password\" is not allowed to be blank" }, status: :bad_request
		elsif !params[:email]
			render json: { message: "\"email\" is required" }, status: :bad_request
		elsif !params[:password]
			render json: { message: "\"password\" is required" }, status: :bad_request
		else
			@user = User.find_by(email: params[:email])
			if @user and @user.authenticate(params[:password])
				token = encode_token({user_id: @user.id})
				render json: { token: token }, status: :ok
			else
				render json: { message: "Campos inválidos" }, status: :bad_request
			end
		end
	end

	private
		def set_user
			@user = User.find_by(id: params[:id])
		end

		def user_params
			params.permit(:displayName, :password, :password_confirmation, :email, :image)
		end
end
