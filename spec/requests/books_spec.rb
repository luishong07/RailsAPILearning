require 'rails_helper'

describe 'Books API', type: :request do
    let(:first_author) {FactoryBot.create(:author, first_name:'Neil', last_name:'Gaiman',age: 60)}
    let(:second_author) {FactoryBot.create(:author, first_name:'J.K.', last_name:'Rowling',age: 55)}
    describe 'GET /books' do
        before do 
            FactoryBot.create(:book, title: 'Harry Potter', author: second_author )
            FactoryBot.create(:book, title: 'Sandman', author: first_author)
        end
         
        it 'returns all books' do
            get '/api/v1/books'
    
            expect(response).to have_http_status(:success)
            expect(response_body.size).to eq(2) 
            expect(response_body).to eq(
                [
                    {
                        'id' => 1,
                        'title' => "Harry Potter",
                        'author_name' => "J.K. Rowling",
                        'author_age' => 55 
                    },
                    {
                        'id' => 2,
                        'title' => "Sandman",
                        'author_name' => "Neil Gaiman",
                        'author_age' => 60 
                    }
                ]
            )
        end

        it "returns a subset of books based on pagination" do
            get '/api/v1/books', params: {limit: 1}

            expect(response).to have_http_status(:success)
            expect(response_body.size).to eq(1)
            expect(response_body).to eq([
                {
                    'id' => 1,
                    'title' => "Harry Potter",
                    'author_name' => "J.K. Rowling",
                    'author_age' => 55 
                }
            ])
        end

        it "returns a subset based on limit and offset" do
            get '/api/v1/books', params: {limit: 1, offset: 1}

            expect(response).to have_http_status(:success)
            expect(response_body.size).to eq(1)
            expect(response_body).to eq([
                {
                    'id' => 2,
                    'title' => "Sandman",
                    'author_name' => "Neil Gaiman",
                    'author_age' => 60 
                } 
            ])




        end

         
    
    end

    describe 'POST /books' do
        it 'creates a new book' do
            expect { 
                post '/api/v1/books', params: {
                    book: {title: "The Martian"}, 
                    author: {first_name: "Andy", last_name:"Weir", age: 48}
                }, headers: {"Authorization" => "Bearer 123"}
            }.to change {Book.count}.from(0).to(1)

            expect(response).to have_http_status(:created)
            expect(Author.count).to eq(1)
            expect(JSON.parse(response.body)).to eq(
                {
                    'id' => 1,
                    'title' => "The Martian",
                    'author_name' => "Andy Weir",
                    'author_age' => 48
                }
            )
        end
    end

    describe 'DELETE /books/:id' do
        let!(:book) {FactoryBot.create(:book, title: '1984', author: first_author)}
        it 'deletes a book' do
            expect {
                delete "/api/v1/books/#{book.id}"
                
        }.to change {Book.count}.from(1).to(0)

            expect(response).to have_http_status(:no_content)
        end
    end
end 

 