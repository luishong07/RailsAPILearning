class AuthenticationTokenService
    TOP_SECRET = 'verysneaky'
    ALGORITHM = 'HS256'
    def self.call
        payload = {"test" => "hhmmm"}
        JWT.encode payload, TOP_SECRET, ALGORITHM
    end
end