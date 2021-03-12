class ApplicationController < ActionController::API
  rescue_from ErrorHandler, with: :error_handler
  rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid

  before_action :set_locale

  private

  def set_locale
    I18n.locale = I18n.default_locale
  end

  def error_handler(error)
    data = I18n.t(error.message, scope: [:errors])

    if data.include?('translation missing')
      data = I18n.t(:unknown, scope: [:errors])
    end

    error_details = { code: data[:code], message: data[:message] }

    error_details[:field] = data[:field] if data[:field].present?
    
    render json: { errors: error_details }, status: data[:status]
  end

  def handle_record_invalid(error)
    error_list = []
    error.record.errors.details.each do |field, errors|
      errors.each_with_index do |details, i|
        message = error.record.errors.full_messages_for(field.to_sym)[i]
        next unless message.present?

        hash = { code: details[:error].to_s, field: field, message: message }

        error_list << hash
      end
    end
    render json: { errors: error_list }, status: :unprocessable_entity
  end
end
