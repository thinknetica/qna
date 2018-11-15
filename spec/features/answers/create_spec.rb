require 'rails_helper'

feature 'User can give an answer', %q{
  In order to share my knowledge
  As an authenticated user
  I want to be able to create answers
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }

  scenario 'Authenticated user create answer' do
    sign_in(user)
    visit question_path(question)

    fill_in 'Your answer', with: 'My answer'
    click_on 'Create'

    expect(current_path).to eq question_path(question)
    within '.answers' do # чтобы убедиться, что ответ в списке, а не в форме
      expect(page).to have_content 'My answer'
    end
  end
end