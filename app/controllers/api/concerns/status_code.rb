module Api
  module Concerns
    module StatusCode
      STATUS_CODE_TYPE = {
        ActiveRecord::RecordNotFound => :not_found,
        Errors::NotFound => :not_found,
        Errors::Unauthorized => :unauthorized,
        CanCan::AccessDenied => :forbidden,
        Errors::UnprocessableEntity => :unprocessable_entity,
        Errors::BadRequest => :bad_request
      }.freeze
    end
  end
end
