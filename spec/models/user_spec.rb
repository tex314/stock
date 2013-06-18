# -*- coding: utf-8 -*-
require 'spec_helper'

describe User do

  describe '#valid?' do
    context 'email, password, password_confirmation が与えられたとき' do
      subject(:user) { FactoryGirl.build(:user) }
      specify { expect(subject).to be_valid }
    end

    context 'email が空のとき' do
      subject(:user) { FactoryGirl.build(:user, email: nil) }
      specify { expect(subject).not_to be_valid }
    end

    context 'email が既に使用されているものであるとき' do
      subject(:user) { FactoryGirl.build(:user) }
      before do
        FactoryGirl.create(:user, email: user.email)
      end
      specify { expect(subject).not_to be_valid }
    end

    context 'passwordが6文字未満のとき' do
      subject(:user) { FactoryGirl.build(:user, password: 'foo') }
      specify { expect(subject).not_to be_valid }
    end
  end

  describe '#update' do
    subject(:user) { FactoryGirl.create(:user) }

    context 'emailを更新するとき' do
      let(:attrs) { {email: 'foo@example.com'} }
      it 'updateは成功する' do
        expect(user.update_attributes(attrs)).to be_true
      end
      it 'emailが更新できる' do
        expect { user.update_attributes(attrs) }.to change { user.email }
      end
    end

    context 'password_confirmationが与えられないとき' do
      let(:attrs) { {password: 'newpassword'} }
      it 'updateは失敗する' do
        expect(user.update_attributes(attrs)).not_to be_true
      end
    end

    context 'password, password_confirmationに同じ値が与えられたとき' do
      let(:attrs) { {password: 'newpassword', password_confirmation: 'newpassword'} }
      it 'updateは成功する' do
        expect(user.update_attributes(attrs)).to be_true
      end
      it 'passwordが更新できる' do
        expect { user.update_attributes(attrs) }.to change { user.password_digest }
      end
    end

    context 'email, passwordを一気に更新' do
      let(:attrs) {
        {email: 'foo@example.com', password: 'newpassword', password_confirmation: 'newpassword'}
      }
      it 'updateは成功する' do
        expect(user.update_attributes(attrs)).to be_true
      end
      it 'emailが更新できる' do
        expect { user.update_attributes(attrs) }.to change { user.email }
      end
      it 'passwordが更新できる' do
        expect { user.update_attributes(attrs) }.to change { user.password_digest }
      end
    end
  end

  describe '#authenticate' do
    subject(:user) { FactoryGirl.create(:user) }

    context 'password が正しいとき' do
      specify { expect(user.authenticate(user.password)).to be_true }
    end

    context 'password が間違えているとき' do
      specify { expect(user.authenticate(user.password + 'wrong')).not_to be_true }
    end
  end
end
