require 'rails_helper'

describe Baukis::Staff::TopController do
  context 'ログイン前' do
    let(:staff_member) { create(:staff_member) }

    describe 'IPアドレスによるアクセス制限' do
      before do
        Rails.application.config.baukis[:restrict_ip_addresses] = true
      end

      example '許可' do
        Baukis::AllowedSource.create!(namespace: 'staff', ip_address: '0.0.0.0')
        get :index
        expect(response).to render_template('staff/top/index')
      end

      example '拒否' do
        Baukis::AllowedSource.create!(namespace: 'staff', ip_address: '192.168.0.*')
        get :index
        expect(response).to render_template('errors/forbidden')
      end
    end
  end

  context 'ログイン後' do
    let(:staff_member) { create(:staff_member) }

    before do
      session[:staff_member_id] = staff_member.id
      session[:last_access_time] = 1.second.ago
    end

    describe '#index' do
      example '通常はstaff/top/dashboardを表示' do
        get :index
        expect(response).to render_template('staff/top/dashboard')
      end

      example '停止フラグがセットされたら強制的にログアウト' do
        staff_member.update_column(:suspended, true)
        get :index
        expect(session[:staff_member_id]).to be_nil
        expect(response).to redirect_to(baukis_staff_root_url)
      end

      example 'セッションタイムアウト' do
        session[:last_access_time] =
            Baukis::Staff::Base::TIMEOUT.ago.advance(seconds: -1)
        get :index
        expect(session[:staff_member_id]).to be_nil
        expect(response).to redirect_to(baukis_staff_login_url)
      end
    end
  end

end
