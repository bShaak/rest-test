require_relative './transaction'
require 'rest-client'
require 'json'

class BenchClient
  attr_reader :num_pages, :total_count

  def initialize
    @base_url = 'http://resttest.bench.co/transactions/'
    @total_count = 0
    @num_pages = 0
  end

  #takes TransactionArray and populates it with the transaction data
  #This will also work with a regular Array type
  def populate_transaction_array(transaction_arr)
    res = get_page(1)
    unless res.code == 404
      page_1_data = JSON.parse(res)

      #calculate the number of pages to get based on number of transactions on the first page
      @total_count = page_1_data['totalCount'].to_i
      transactions = page_1_data['transactions']
      add_transactions(transaction_arr, res)
      @num_pages = (Float(@total_count) / transactions.size).ceil

      #get the remaining transactions pages and add to array
      (2..@num_pages).each do |page_id|
        res = get_page(page_id)
        unless res.code == 404
          add_transactions(transaction_arr, res)
        end
      end

    end
  end

  private

  #Get page by the resource id
  #Throws excpetion of the request fails
  def get_page(page_id)
    page_url = @base_url + "#{page_id}.json"
    RestClient.get(page_url) {|response, request, result| response}
  end

  def add_transactions(list, res)
    unless res.code == 404
      page_data = JSON.parse(res)
      page_data['transactions'].each do |transaction_json|
        transaction = Transaction.new(transaction_json)
        list << transaction
      end
    end
  end

end
