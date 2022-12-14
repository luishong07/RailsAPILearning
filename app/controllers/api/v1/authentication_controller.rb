module Api
    module V1
        class AuthenticationController < ApplicationController
            class AuthenticationError < StandardError; end

            rescue_from ActionController::ParameterMissing, with: :parameter_missing


            def create
                # p params.require(:username).inspect
                p params.require(:password).inspect
                user = User.find_by(username: params.require(:username))
                raise AuthenticationError unless user.authenticate(params.require(:password))
                token = AuthenticationTokenService.call(user.id)


                render json: {token: token}, status: :created


            end 
            private
            def parameter_missing(e)
                render json: {error: e.message}, status: :unprocessable_entity

            end
        
        end
    end
end