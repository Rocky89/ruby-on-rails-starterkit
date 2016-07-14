class ValidateParameterService
  def initialize(params, required_params = [])
    @params = params
    @required_params = required_params
  end

  def validate!
    @required_params.each do |req_par|
      raise Errors::BadRequest,
            "#{req_par.to_s.capitalize} parameter is missing" unless
              @params.key?(req_par)
    end
    true
  end
end
