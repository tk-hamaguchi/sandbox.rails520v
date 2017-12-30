class ApiController < ActionController::API
  def version
    @version = Rails520v::Version
  end
end
