require 'rails_helper'

describe AuthenticationTokenService do
    describe '.call' do
        let(:token) {described_class.call}
        it 'returns an authentication token' do
            # secret = "verysneaky"
            decoded_token = JWT.decode(
                token, 
                described_class::TOP_SECRET, 
                true, 
                {algorithm: described_class::ALGORITHM}
            )
             
            expect(decoded_token).to eq(
                [
                    {"test" => "hhmmm"},#payload
                    {"alg"=>"HS256"}
                ]
            )
        end
    end
end 