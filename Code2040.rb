require 'net/http'
require 'uri'
require 'json'

def GithubPost ()
  uri = URI("http://challenge.code2040.org/api/register")

  header = {'Content-Type' => 'application/json'}
  info = {         token: '47fca5347f70962e6faac4fae4cb75cd',
                    github: 'https://github.com/tturn02/CODE2040'
                        }

# Create the HTTP objects
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new(uri.request_uri, header)
  request.body = info.to_json

# Send the request
  response = http.request(request)
  return response.to_s
end

GithubPost()
