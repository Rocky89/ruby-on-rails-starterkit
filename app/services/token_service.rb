class TokenService
  def self.encode(hash)
    JWT.encode(hash, ENV['TOKEN_SECRET'])
  end

  def self.decode(token)
    JWT.decode(token, ENV['TOKEN_SECRET']).first
  rescue
    raise Errors::Unauthorized, 'Invalid token'
  end
end
