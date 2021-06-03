class UserTokenController < Knock::AuthTokenController
	before_action :authenticate_user, except: [:create]

	def create
		render json: encode_token({user_id: @user.id}), status: :created
	end
end
