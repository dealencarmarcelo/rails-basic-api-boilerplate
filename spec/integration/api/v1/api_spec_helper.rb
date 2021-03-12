require "spec_helper"
  def json
    JSON.parse(response.body)
  end

  def validate_api_error(response, status, code)
    expect(response.status).to eq(status)
    expect(json_errors['code']).to eq(code)
  end

  def json_data
    json['data']
  end

  def json_errors
    json['errors']
  end