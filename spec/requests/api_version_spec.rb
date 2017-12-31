require 'rails_helper'

RSpec.feature 'Version API', type: :request do
  context 'GET /version' do
    context 'without params' do
      scenario {
        get '/version'
        expect(response).to have_http_status :ok
        expect(response).to render_template 'api/version'
        expect(response.body).to match /APP_VERSION: #{Rails520v::VERSION}$/
        expect(response.body).to_not match /DB_VERSION:/
        expect(response).to be_successful
      }
    end

    context 'with details=1' do
      scenario {
        get '/version?details=1'
        expect(response).to have_http_status :ok
        expect(response).to render_template 'api/version'
        expect(response.body).to match /APP_VERSION: #{Rails520v::VERSION}$/
        expect(response.body).to match /DB_VERSION:  \d+$/
        expect(response).to be_successful
      }
    end
  end
end
