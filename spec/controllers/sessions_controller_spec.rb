# -*- coding: utf-8 -*-
require 'spec_helper'

describe SessionsController do

  describe '#new' do
    before { get :new }

    specify { expect(response).to be_success }
    specify { expect(response).to render_template(:new) }
  end

  describe '#create' do
    let(:user) { FactoryGirl.create(:user) }

    context '正しい email and password が与えられたとき' do
      before { post :create, { email: user.email, password: user.password } }
      specify { expect(response).to redirect_to(root_url) }
    end

    context '間違った email or password が与えられたとき' do
      before { post :create, { email: user.email, password: 'wrongpassword' } }
      specify { expect(response).to render_template(:new) }
    end
  end

  describe '#destroy' do
    before { delete :destroy }
    specify { expect(response).to redirect_to(root_url) }
  end
end
