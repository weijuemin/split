class ExpensesController < ApplicationController
	def new
		@group = Group.find(params[:group_id])
	end
	def create
		group = Group.find(params[:group_id])
		expense = Expense.create(name:params[:name], amount:params[:amount], completed:false, group:group)
		if expense.valid?
			amount = params[:amount].to_f / group.users.count
			group.users.each do |user|
				paid = params["u#{ user.id }"].to_f
				diff = paid - amount
				Record.create(user:user, expense:expense, paid:paid, amount:amount, diff:diff)
			end
			redirect_to "/groups/#{ params[:group_id] }"
		else
			flash[:errors] = expense.errors.full_messages
			redirect_to "/expenses/#{ params[:group_id] }/new"
		end
	end

	def show
	    @exp = Expense.find(params[:expense_id])
	    @group = @exp.group
	    @counter = (0...@group.users.count).to_a

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
