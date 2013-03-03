#!ruby
# coding: utf-8

require 'net/http'
require 'uri'
require "rexml/document"
require 'kconv'

	#address = "New York"
	#url = "http://maps.google.com/maps/api/geocode/xml?address=" + address + "&sensor=false"

def request_address(address)

	puts address
	address = URI.encode(address.toutf8)
	url = "http://maps.googleapis.com/maps/api/geocode/xml?address="
	url2 = "&sensor=false"
	
	request_url = url + address + url2

	return request_url
end

def geocorder(address)
	#HTTP Client
	#URI.parse: uri object

	#url_object = URI.parse('http://maps.googleapis.com/maps/api/geocode/xml?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&sensor=true')

	url_object = URI.parse(request_address(address))
	puts url_object

	Net::HTTP.version_1_2
	response = Net::HTTP.get_response(url_object)
	
	case

	when Net::HTTPSuccess
		response
	when Net::HTTPRedirection
		fetch(response['location'], limit - 1)
	else
		response.error!
	end
	



	doc = REXML::Document.new(response.body)

	location = doc.elements['GeocodeResponse/result/geometry/location']

	lat = location.elements['lat'].text
	lng = location.elements['lng'].text

	return lat + "," + lng
end

print "Input:"
input_data = "input your txt or csv file"

puts ""
puts "------------------------------"


newdata = open(input_data)
n1 = 0
array = []

while text = newdata.gets do
	tmp = []
	tmp = text.chomp.split(',')

	array[n1] = tmp[5].to_s

	#n1 = 1
	n1 = n1 + 1

end

n=0
address_list = []
array.each{|rows|
	row = rows.to_s
	address_list[n] = row + "," + geocorder(row)
	puts address_list[n]
	n = n + 1
	sleep 0.1
}

output_data = "address_list.csv"

fileout = open(output_data, "w")
ii = 0
final_no = address_list.size
final_no = final_no - 1

while ii <= final_no
   fileout.puts address_list[ii]
   ii = ii + 1
end

fileout.close

puts "Compete!"


