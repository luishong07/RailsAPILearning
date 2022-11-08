class AuthenticationTokenService
    TOP_SECRET = 'verysneaky'
    ALGORITHM = 'HS256'
    def self.call(user_id)
        
        payload = {user_id: user_id}
        JWT.encode payload, TOP_SECRET, ALGORITHM
    end

    def self.decode(token)
        decoded_token = JWT.decode token, TOP_SECRET, true, {algorithm: ALGORITHM}
        decoded_token[0]['user_id']
    end
end