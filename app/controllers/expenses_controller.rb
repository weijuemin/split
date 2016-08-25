class ExpensesController < ApplicationController
	def new
		@group = Group.find(params[:group_id])
	end

	def create
		group = Group.find(params[:group_id])
		if params[:split] == nil
			flash[:errors] = ["Please select split option!"]
			redirect_to "/expenses/#{ params[:group_id] }/new"
			return
		elsif params[:split] == "percent"
			p = 0
			group.users.each do |user|
				p += params["u#{ user.id }%"].to_i
			end
			if p != 100
				flash[:errors] = ["Percentages must add up to 100%!"]
				redirect_to "/expenses/#{ params[:group_id] }/new"
				return
			end
		elsif params[:split] == "custom"
			total = 0
			group.users.each do |user|
				total += params["u#{ user.id }ca"].to_i
			end
			if total != params[:amount]
				flash[:errors] = ["Custom Amounts must add up to $#{ params[:amount] }!"]
				redirect_to "/expenses/#{ params[:group_id] }/new"
				return
			end
		end
		expense = Expense.create(name:params[:name], amount:params[:amount], completed:false, group:group)
		if expense.valid?
			group.users.each do |user|
				paid = params["u#{ user.id }"].to_f
				amount = 0
				if params[:split] == "equal"
					amount = (params[:amount].to_f / group.users.count).round(2)
				elsif params[:split] == "percent"
					amount = ((params[:amount].to_f * params["u#{ user.id }%"].to_i).floor) / 100.0
				else
					amount = params["u#{ user.id }ca"]
				end			
				diff = paid - amount.to_f
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
	    @record = Record.where(expense:@exp)
	    outstanding(@exp)
	end

	private
	def outstanding exp
	    allrecord = Record.where(expense: exp)
	    owes, owed = [], []

	    allrecord.each do |r|
	      if r.diff < 0
	        owes << {:user => r.user, :diff => r.diff}
	      elsif r.diff > 0
	        owed << {:user => r.user, :diff => r.diff}
	      end
	    end

	    @output = []

	    while 0!=owed.length && 0!=owes.length
	      if owed[0][:diff] < owes[0][:diff].abs
	        amt = owed[0][:diff]
	        @output << {:owes =>owes[0][:user], :owed =>owed[0][:user], :amt => amt}
	        owes[0][:diff] += owed[0][:diff]
	        owed.shift
	      elsif owed[0][:diff] > owes[0][:diff].abs
	        amt = owes[0][:diff].abs
	        @output << {:owes =>owes[0][:user], :owed =>owed[0][:user], :amt => amt}
	        owed[0][:diff] += owes[0][:diff]
	        owes.shift
	      else
	        amt = owed[0][:diff]
	        @output << {:owes =>owes[0][:user], :owed =>owed[0][:user], :amt => amt}
	        owed.shift
	        owes.shift
	      end
	    end
	    @output
	end
end
