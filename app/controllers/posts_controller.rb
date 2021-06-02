class PostsController < ApplicationController
	before_action :authorized
	before_action :set_post, only: [:show, :update]

	def index
	end

	def new
	end

	def show
	end

	def edit
	end

	def create
		if params[:title].nil? or params[:content].nil?
			render json: { message: 'Campos inválidos' }, status: :bad_request
		else
			if logged_in_user
				@post = Post.new(title: params[:title], content: params[:content], user: logged_in_user)
				if @post.save
					render :show, status: :created
				end
			end
		end
	end

	def update
	end

	def destroy
	end

	private
		def set_post
			@post = Post.find(id: params[:id])
		end

		def post_params
			params.require(:post).permit(:title, :content, :user_id, :published)
		end
end
