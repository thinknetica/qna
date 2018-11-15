require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe 'POST #create' do
    let(:question) { create :question }

    context 'with valid attributes' do
      it 'saves the new answer in the database' do
        expect { post :create, params: { answer: attributes_for(:answer), question_id: question } }.to change(question.answers, :count).by(1)
      end

      it 'redirects to question' do
        post :create, params: { answer: attributes_for(:answer), question_id: question }
        expect(response).to redirect_to question
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect { post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question } }.to_not change(Answer, :count)
      end

      it 'renders question show template' do
        post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question }
        expect(response).to render_template 'questions/show'
      end
    end
  end
end
