require 'rails_helper'

RSpec.describe 'home/index', type: :view do
  it 'renders the home page' do
    render
    assert_select 'h1', text: 'Subs', count: 1
  end
end
