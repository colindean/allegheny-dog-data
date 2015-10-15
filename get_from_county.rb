#!/usr/bin/env ruby

require 'bundler'
Bundler.require
require 'csv'

require './county_retriever'
require './persister'

ret = CountyRetriever.new

first_page = ret.get_first_page

first_csv_page = ret.get_csv_data first_page

csv_data = first_csv_page.body

File.open("#{ret.year first_page}.csv", 'w') do |file|
  file.write csv_data
end

per = Persister.new "dogs.db"

per.save_to_database csv_data
