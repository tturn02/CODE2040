require 'net/http'
require 'uri'
require 'json'

def GithubPost (info, uri)


  header = {'Content-Type' => 'application/json'}


# Create the HTTP objects
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new(uri.request_uri, header)
  request.body = info.to_json

# Send the request
  response = http.request(request)
  return response.body
end

def reverse (reverseMe)
  return reverseMe.reverse
end

#Part 1
info = { token: '47fca5347f70962e6faac4fae4cb75cd',
  github: 'https://github.com/tturn02/CODE2040' }

uri = URI("http://challenge.code2040.org/api/register")

GithubPost(info, uri)


#Part2
info = {token: '47fca5347f70962e6faac4fae4cb75cd'}
uri = URI("http://challenge.code2040.org/api/reverse")
stringtoReverse = GithubPost(info, uri)
reversedString = reverse (stringtoReverse)
info = {token: '47fca5347f70962e6faac4fae4cb75cd', string: reversedString}
uri = URI("http://challenge.code2040.org/api/reverse/validate")
puts GithubPost(info, uri)


#Part3
info = {token: '47fca5347f70962e6faac4fae4cb75cd'}
uri = URI("http://challenge.code2040.org/api/haystack")
dictionary =
