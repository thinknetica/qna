require 'rails_helper'

RSpec.describe Services::FindForOauth do
  let!(:user) {create(:user)}
  let(:auth) {OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456')}
  subject { Services::FindForOauth.new(auth) }

  context 'user already has authorization' do
    it 'returns the user' do
      user.authorizations.create(provider: 'facebook', uid: '123456')
      expect(subject.call).to eq user
    end
  end

  context 'user has not authorization' do
    context 'user already exists' do
      let(:auth) {OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: {email: user.email})}
      it 'does not create new user' do
        expect {subject.call}.to_not change(User, :count)
      end

      it 'creates authorization for user' do
        expect {subject.call}.to change(user.authorizations, :count).by(1)
      end

      it 'creates authorization with provider and uid' do
        authorization = subject.call.authorizations.first

        expect(authorization.provider).to eq auth.provider
        expect(authorization.uid).to eq auth.uid
      end

      it 'returns the user' do
        expect(subject.call).to eq user
      end
    end

    context 'user does not exist' do
      let(:auth) {OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: {email: 'new@user.com'})}

      it 'creates new user' do
        expect {subject.call}.to change(User, :count).by(1)
      end

      it 'returns new user' do
        expect(subject.call).to be_a(User)
      end

      it 'fills user email' do
        user = subject.call
        expect(user.email).to eq auth.info[:email]
      end

      it 'creates authorization for user' do
        user = subject.call
        expect(user.authorizations).to_not be_empty
      end

      it 'creates authorization with provider and uid' do
        authorization = subject.call.authorizations.first

        expect(authorization.provider).to eq auth.provider
        expect(authorization.uid).to eq auth.uid
      end
    end
  end
end