class CurrentUserService
  def initialize(token)
    raise Errors::Unauthorized, 'Token is missing from header' unless token.present?
    @token = token
  end

  def authenticate
    hash = TokenService.decode(@token)
    user = User.find_by_email hash['email']
    raise Errors::Unauthorized, 'Invalid token' unless user.present?
    user
  end
end
