require 'net/http'
require 'uri'
require 'json'
require 'time'

#Thought that the challenege was fairly simple. Although this project really did give me a chance to learn about how POSTing
#to an API works and how to go about getting the returned data. I also learned a lot about working with JSON objects which
#is usful because that's how many API's return data. The library for most of the languages contain ways to do most of the
#required steps painlessly. Although they all could have been acheieved even without some of the helpful methods.
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
 time = Time.parse(timeStamp)
 t = time + seconds
 timeArray = t.to_s.split(" ")
 timeString = timeArray[0] + "T" + timeArray[1] + "Z"
 return timeString
end

def part1()
  info = { token: '47fca5347f70962e6faac4fae4cb75cd',
    github: 'https://github.com/tturn02/CODE2040' }
  uri = URI("http://challenge.code2040.org/api/register")
  puts GithubPost(info, uri)
end

def part2()
  info = {token: '47fca5347f70962e6faac4fae4cb75cd'}
  uri = URI("http://challenge.code2040.org/api/reverse")
  stringtoReverse = GithubPost(info, uri)
  info = {token: '47fca5347f70962e6faac4fae4cb75cd', string: stringtoReverse.reverse}
  uri = URI("http://challenge.code2040.org/api/reverse/validate")
  puts GithubPost(info, uri)
end

def part3()
  info = {token: '47fca5347f70962e6faac4fae4cb75cd'}
  uri = URI("http://challenge.code2040.org/api/haystack")
  needleHayStackHash = JSON.parse(GithubPost(info, uri))
  index = indexed(needleHayStackHash.flatten)
  info = {token: '47fca5347f70962e6faac4fae4cb75cd', needle: index}
  uri = URI("http://challenge.code2040.org/api/haystack/validate")
  puts GithubPost(info, uri)
end

def part4()
  info = {token: '47fca5347f70962e6faac4fae4cb75cd'}
  uri = URI("http://challenge.code2040.org/api/prefix")
  prefixHash = JSON.parse(GithubPost(info, uri))
  pref = prefixHash["prefix"]
  prefixArray = prefixHash["array"]
  gone = removePrefix(pref, prefixArray)
  info = {token: '47fca5347f70962e6faac4fae4cb75cd', array: gone}
  uri = URI("http://challenge.code2040.org/api/prefix/validate")
  puts GithubPost(info, uri)
end

def part5()
  info = {token: '47fca5347f70962e6faac4fae4cb75cd'}
  uri = URI("http://challenge.code2040.org/api/dating")
  timeStampHash = JSON.parse(GithubPost(info, uri))
  time = timeStampHash["datestamp"]
  interval = timeStampHash["interval"]
  addedTime = addTime(time, interval)
  info = {token: '47fca5347f70962e6faac4fae4cb75cd', datestamp: addedTime}
  uri = URI("http://challenge.code2040.org/api/dating/validate")
  puts GithubPost(info, uri)
end

part1()
part2()
part3()
part4()
part5()
