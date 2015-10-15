#!/usr/bin/env ruby

require 'bundler'
Bundler.require
require 'csv'
require 'yaml'

require './persister'

DATA_DIR = 'data'

per = Persister.new "dogs.db"

urls = YAML.load File.read('data.yml')

pool = Thread.pool(2)

urls['data'].each do |row|
  url = row['url']
  year = row['year']
  output_file = "data/#{year}.csv"

  `wget -c -O #{output_file} #{url}`

  pool.process {
    per.save_to_database File.read(output_file)
  }
end

pool.shutdown
