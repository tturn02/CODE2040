require 'net/http'
require 'uri'
require 'json'
require 'time'

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

def indexed (needHay)
  needle = needHay[1]
  haystack = needHay[3]
  return haystack.index(needle)
end

def removePrefix (prefix, arr)
  removed = Array.new
  arr.each{ |val|
    if val.start_with?(prefix) == false
      removed.push(val)
    end
  }
  return removed
end

def addTime (timeStamp, seconds)
 t = Time.parse(timeStamp)
 t + seconds

end

#Part 1
info = { token: '47fca5347f70962e6faac4fae4cb75cd',
  github: 'https://github.com/tturn02/CODE2040' }

uri = URI("http://challenge.code2040.org/api/register")




#Part2
info = {token: '47fca5347f70962e6faac4fae4cb75cd'}
uri = URI("http://challenge.code2040.org/api/reverse")
stringtoReverse = GithubPost(info, uri)
reversedString = reverse (stringtoReverse)
info = {token: '47fca5347f70962e6faac4fae4cb75cd', string: reversedString}
uri = URI("http://challenge.code2040.org/api/reverse/validate")



#Part3
info = {token: '47fca5347f70962e6faac4fae4cb75cd'}
uri = URI("http://challenge.code2040.org/api/haystack")
needleHayStackHash = JSON.parse(GithubPost(info, uri))
index = indexed(needleHayStackHash.flatten)
info = {token: '47fca5347f70962e6faac4fae4cb75cd', needle: index}
uri = URI("http://challenge.code2040.org/api/haystack/validate")


#Part4
info = {token: '47fca5347f70962e6faac4fae4cb75cd'}
uri = URI("http://challenge.code2040.org/api/prefix")
prefixHash = JSON.parse(GithubPost(info, uri))
pref = prefixHash["prefix"]
prefixArray = prefixHash["array"]
gone = removePrefix(pref, prefixArray)
info = {token: '47fca5347f70962e6faac4fae4cb75cd', array: gone}
uri = URI("http://challenge.code2040.org/api/prefix/validate")

#Part5
info = {token: '47fca5347f70962e6faac4fae4cb75cd'}
uri = URI("http://challenge.code2040.org/api/dating")
timeStampHash = JSON.parse(GithubPost(info, uri))
time = timeStampHash["datestamp"]
interval = timeStampHash["interval"]
addTime(time, interval)
