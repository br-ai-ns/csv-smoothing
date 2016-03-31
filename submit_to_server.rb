#!/usr/bin/env ruby -w

require 'csv'
require 'predictionio'

# Define environment variables.
ENV['PIO_THREADS'] ||= '50' # For async requests.
ENV['PIO_EVENT_SERVER_URL'] ||= 'http://localhost:7070/'
ENV['PIO_ACCESS_KEY'] ||= ''

# Create PredictionIO event client.
client = PredictionIO::EventClient.new(ENV['PIO_ACCESS_KEY'], ENV['PIO_EVENT_SERVER_URL'], Integer(ENV['PIO_THREADS']))

CSV.foreach('base_catalog_audience_title_norm.csv', headers: true) do |row|
  next if row['CATALOG_ITEM_ID'].length.zero?

  row['CUSTOMER_ID']
  row['TITLE']

  client.create_event(
    'rate',
    'user',
    row['CUSTOMER_ID'], {
      'targetEntityType' => 'item',
      'targetEntityId' => row['TITLE'],
      'properties' => { 'rating' => 5 }
    }
  )
  print '.'
end
puts

item
