require 'sinatra'
require_relative 'bench-client'

get '/' do
  client = BenchClient.new
  @transaction_array = TransactionArray.new

  #Get all transactions from rest api and
  #scrub the company descriptions of garbage that starts with '#' or 'xx'
  client.populate_transaction_array(@transaction_array)
  @transaction_array.each do |transaction|
    transaction.modify_vendor_name { |vendor| vendor.gsub(/(#\w+|xx*.*)/, '').strip }
  end

  erb :index
end

get '/categories' do
  client = BenchClient.new
  transaction_array = TransactionArray.new

  #Get all transactions from rest api and
  #scrub the company descriptions of garbage that starts with '#' or 'xx'
  client.populate_transaction_array(transaction_array)
  transaction_array.each do |transaction|
    transaction.modify_vendor_name { |vendor| vendor.gsub(/(#\w+|xx*.*)/, '').strip }
  end

  #create a hash that has Category key and array values
  @category_hash = Hash.new{|hash,key| hash[key] = []}
  transaction_array.each do |t|
    @category_hash[t.category].push (t)
  end

  erb :categories
end
