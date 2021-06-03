class PostsController < ApplicationController
	before_action :authorized
	before_action :set_post, only: [:show, :update, :destroy]

	def index
		@posts = Post.all
	end

	def show
		unless @post
			render json: { message: 'Post não existe' }, status: :not_found
		end
	end

	def edit
	end

	def create
		if logged_in_user
			@post = Post.new(title: params[:title], content: params[:content], user: logged_in_user, published: DateTime.now)
			if @post.save
				render :create, status: :created
			else
				render json: {message: @post.errors.messages.values.flatten.first}, status: :bad_request
			end
		end
	end

	def update
		if @post
			if @post.user == logged_in_user
				if @post.update(title: params[:title], content: params[:content])
					render :create, status: :ok
				else
					render json: {message: @post.errors.messages.values.flatten.first}, status: :bad_request
				end
			else
				render json: {message: "unauthorized"}, status: :unauthorized
			end
		else
			render json: {message: "Post não existe"}, status: :not_found
		end
	end

	def destroy
		if @post
			if @post.user == logged_in_user
				@post.destroy
			else
				render json: {message: @post.errors.messages.values.flatten.first}, status: :bad_request
			end
		else
			render json: {message: "Post não existe"}, status: :not_found
		end
	end

	def search
		if params[:q]
			@posts = Post.where('lower(title) LIKE ? OR lower(content) LIKE ?', "%#{params[:q].downcase}%", "%#{params[:q].downcase}%")
			render :index, status: :ok
		end
	end

	private
		def set_post
			@post = Post.find_by(id: params[:id])
		end

		def post_params
			params.permit(:title, :content, :user_id, :published)
		end
end
