require "pry"
class Transfer
  # your code here
  attr_accessor :status, :last_amount, :last_sender, :last_receiver
  attr_writer :count
  attr_reader :sender, :receiver, :amount
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
    @count = 0
  end

  def valid?
    @sender.valid? && @receiver.valid? ? true : false
  end

  def execute_transaction
    # binding.pry
    #binding.pry
    if @sender.valid? == true && @count == 0 && @sender.balance > @amount
        @last_amount = @amount
        @last_sender = @sender
        @last_receiver = @receiver
        @sender.balance -= @amount
        @receiver.balance += @amount
        #binding.pry
        @count += 1
        @status = "complete"

    else#if @sender.valid?
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @count == 1
      reverse = Transfer.new(@last_receiver, @last_sender, @last_amount)
      reverse.execute_transaction
      @status = "reversed"
      @count += 1
      reverse
    end
  end

end
