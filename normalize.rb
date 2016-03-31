#!/usr/bin/env ruby -w

require 'csv'

NULL_CUSTOMER_ID = '0'
NULL_IP = '0'

# base_catalog_audience.csv
def audience
  puts %("ID","CUSTOMER_ID","IP","CATALOG_ITEM_ID","CREATED_AT","CREATED_AT_MONTH","CREATED_AT_YEAR","UPDATED_AT")
  CSV.foreach('base_catalog_audience.csv', headers: true) do |row|
    next if row['CATALOG_ITEM_ID'].length.zero?

    arr = [
      row['ID'],
      row['CUSTOMER_ID'].length.zero? ? NULL_CUSTOMER_ID : row['CUSTOMER_ID'],
      row['IP'].length.zero? ? NULL_IP : row['IP'],
      row['CATALOG_ITEM_ID'],
      row['CREATED_AT'],
      row['CREATED_AT_MONTH'],
      row["CREATED_AT_YEAR"],
      row['UPDATED_AT']
    ]
    puts arr.map{|e| '"' + e + '"'}.join(',')
  end
end

# base_catalog_item.csv
def item
  puts %("CATALOG_ITEM_ID","CATEGORY_ID","CATEGORY_NAME","SUBCATEGORY_ID","SUBCATEGORY_NAME","TITLE","TYPE","AUTHOR","NARRATOR","STATUS","FREE_CONTENT","CREATED_AT")
  CSV.foreach('base_catalog_item.csv', headers: true) do |row|
    next if row['CATALOG_ITEM_ID'].length.zero?

    arr = [
      row['CATALOG_ITEM_ID'],
      row['CATEGORY_ID'],
      row['CATEGORY_NAME'],
      row['SUBCATEGORY_ID'],
      row['SUBCATEGORY_NAME'],
      row['TITLE'],
      {'book' => '0', 'podcast' => '1'}[row['TYPE']],
      row['AUTHOR'].split.join(' '),
      row['NARRATOR'].split.join(' '),
      {'inactive' => '0', 'active' => '1', 'deleted' => '2'}[row['STATUS']],
      {'no' => '0', 'yes' => '1'}[row['FREE_CONTENT']],
      row['CREATED_AT']
    ]
    puts arr.map{|e| '"' + e + '"'}.join(',')
  end
end

item
