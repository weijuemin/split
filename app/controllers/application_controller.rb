class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def require_login
    if not session[:user_id]
      redirect_to "/sessions/"
    end
  end

  def logged_in
    result = (session[:user_id] != nil) ? true : false
  end

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
