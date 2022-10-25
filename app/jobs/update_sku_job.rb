class UpdateSkuJob < ApplicationJob
  queue_as :default

  def perform(book_name)
    # Do something later
    # uri = URI('some loc al host')
    # Net::HTTP::Post.new(uri, 'Content-Type'=> 'application/json')
    # req.body = {sku:'123', name: book_name}.to_json
    # res =  Net::HTTP.start(URI.hostname, uri.port) do |http|
    #   http.request(req)
    # end

  end
end
