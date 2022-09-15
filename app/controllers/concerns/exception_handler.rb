module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      error_handler({ :'Record error:' => [e.message] }, :not_found)
    end
  end
end
