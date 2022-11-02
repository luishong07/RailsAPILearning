class AuthenticationTokenService
    TOP_SECRET = 'verysneaky'
    ALGORITHM = 'HS256'
    def self.call(user_id)
        
        payload = {user_id: user_id}
        JWT.encode payload, TOP_SECRET, ALGORITHM
    end
end