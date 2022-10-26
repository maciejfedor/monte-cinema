require 'rails_helper'

RSpec.describe '/', type: :request do
  subject(:request) { get root_url }
  before { request }

  it 'renders root template' do
    expect(response).to render_template(:home)
  end

  it 'return successful response' do
    expect(response.status).to eq(200)
  end
end
