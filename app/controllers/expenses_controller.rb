class ExpensesController < ApplicationController
	def new
		@group = Group.find(params[:group_id])
	end
	def create
		redirect_to "/group/#{ params[:group_id] }"
	end

	def show
    @exp = Expense.find(params[:expense_id])
    allrecord = Record.where(expense: @exp).all
    owes, owed = [], []

    allrecord.each do |r|
      diff = r.paid - r.amount
      if diff < 0
        owes << {:user => r.user, :diff => diff}
      elsif diff > 0
        owed << {:user => r.user, :diff => diff}
      end
    end

    @output =[]
    p, n = owed, owes

    puts p
    puts n
    while 0<p.length || 0<n.length
      if p[0][:diff] < n[0][:diff].abs
        amt = p[0][:diff]
        @output << {:owes =>n[0][:user], :owed =>p[0][:user], :amt => amt}
        n[0][:diff] += p[0][:diff]
        p.shift
      elsif p[0][:diff] > n[0][:diff].abs
        amt = n[0][:diff].abs
        @output << {:owes =>n[0][:user], :owed =>p[0][:user], :amt => amt}
        p[0][:diff] += n[0][:diff]
        n.shift
      elsif p[0][:diff] = n[0][:diff].abs
        amt = p[0][:diff]
        @output << {:owes =>n[0][:user], :owed =>p[0][:user], :amt => amt}
        p.shift
        n.shift
      end
    end
    @output
	end
end
