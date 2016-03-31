#!/usr/bin/env ruby -w

require 'csv'

NULL_CUSTOMER_ID = '0'
NULL_IP = '0'

$titles = {}
CSV.foreach('base_catalog_item.csv', headers: true) do |row|
  next if row['CATALOG_ITEM_ID'].length.zero?
  $titles[row['CATALOG_ITEM_ID']] = row['TITLE']
end

# base_catalog_audience.csv
def audience
  puts %("ID","CUSTOMER_ID","IP","CATALOG_ITEM_ID","CREATED_AT","CREATED_AT_MONTH","CREATED_AT_YEAR","UPDATED_AT","TITLE")
  CSV.foreach('base_catalog_audience.csv', headers: true) do |row|
    next if row['CATALOG_ITEM_ID'].length.zero?
    next if row['CATALOG_ITEM_ID'] == '0'

    arr = [
      row['ID'],
      row['CUSTOMER_ID'].length.zero? ? NULL_CUSTOMER_ID : row['CUSTOMER_ID'],
      row['IP'].length.zero? ? NULL_IP : row['IP'],
      row['CATALOG_ITEM_ID'],
      row['CREATED_AT'],
      row['CREATED_AT_MONTH'],
      row["CREATED_AT_YEAR"],
      row['UPDATED_AT'],
      $titles[row['CATALOG_ITEM_ID']]
    ]
    puts arr.map{|e| '"' + e + '"'}.join(',')
  end
end

audience
