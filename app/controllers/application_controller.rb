class ApplicationController < ActionController::API
	include Knock::Authenticable

	def encode_token(payload)
		JWT.encode payload, Rails.application.credentials.secret_key_base, 'HS256'
	end

	def auth_header
		request.headers['Authorization']
	end

	def decoded_token
		if auth_header
			token = auth_header.split(' ')[1]
			begin
				JWT.decode token, Rails.application.credentials.secret_key_base, true, { algorithm: 'HS256' }
			rescue JWT::DecodeError
				nil
			end
		end
	end

	def logged_in_user
		if decoded_token
			user_id = decoded_token[0]['user_id']
			@user = User.find_by(id: user_id)
		end
	end

	def logged_in?
		!!logged_in_user
	end

	def authorized
		if !auth_header
			render json: { message: 'Token não encontrado' }, status: :unauthorized
		else
			render json: { message: 'Token expirado ou inválido' }, status: :unauthorized unless logged_in?
		end
	end
end
