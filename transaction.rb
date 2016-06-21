require 'json'

class Transaction
  attr_accessor :vendor
  attr_reader :date, :amount, :category

  def initialize(hash)
    @date = hash['Date']
    @category = hash['Ledger'].strip
    @amount = hash['Amount'].to_f #cast to float
    @vendor = hash['Company']
  end

  #pass a code block to be executed on the vendor string
  def modify_vendor_name()
    @vendor = yield (@vendor)
  end
end

#Inherit from array class
class TransactionArray < Array
  def total_balance
    total = 0.0
    self.each{|transaction| total += transaction.amount}
    total
  end
end
