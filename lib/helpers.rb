module Helpers
  def logged_in?
    return !!session[:logged_in]
  end

  def authorize!(options = {})
    options = {:path => "/"}.merge(options)
    unless logged_in?
      flash[:error] = "Please log in!"
      redirect options[:path]
    else
      if options[:require_admin] 
        unless session[:is_admin]
          flash[:error] = "You are not admin."
          redirect options[:path] || "/account"
        end
      end      
    end
  end
  
  def logout!
    session[:user_id], @current_user = nil, nil
  end
  
end