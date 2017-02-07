class Api::ApiController < ActionController::API
  include Api::Concerns::Paginatable
  include Api::Concerns::BaseEndpoint
  include CanCan::ControllerAdditions
  include Api::Concerns::StatusCode

  rescue_from Exception do |exception|
    status = STATUS_CODE_TYPE[exception.class] || :internal_server_error
    # Rollbar.error(exception) if status == :internal_server_error
    render json: { message: exception.message }, status: status
  end

  private

  def authenticate
    @current_user = CurrentUserService.new(request.headers['HTTP_TOKEN']).authenticate
  end

  def current_ability
    @current_ability ||= ApiUserAbility.new(current_user)
  end

  def populate_user_data
    params[:user_id] = current_user.id.to_s
  end
end
