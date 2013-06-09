class Authentication

  def initialize(params)
    @params = params
  end

  def user
    @user ||= user_with_password
  end

  def authenticated?
    user.present?
  end

  private
  def user_with_password
    user = User.find_by_email(@params[:email])
    user && user.authenticate(@params[:password])
  end
end