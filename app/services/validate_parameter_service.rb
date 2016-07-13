class ValidateParameterService
  def initialize(params, required_params = [])
    @params = params
    @required_params = required_params
  end

  def validate!
    @required_params.each do |req_par|
      raise Errors::BadRequest.new("#{req_par.to_s.capitalize} parameter is missing") if !@params.has_key?(req_par)
    end
    return true
  end
end
