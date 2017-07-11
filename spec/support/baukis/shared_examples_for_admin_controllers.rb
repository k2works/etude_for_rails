shared_examples 'a protected admin controller' do
  describe '#index' do
    example 'ログインフォームにリダイレクト' do
      get :index
      expect(response).to redirect_to(baukis_admin_login_url)
    end
  end

  describe '#show' do
    example 'ログインフォームにリダイレクト' do
      get :show, params: {id: 1}
      expect(response).to redirect_to(baukis_admin_login_url)
    end
  end
end

shared_examples 'a protected singular admin controller' do
  describe '#show' do
    example 'ログインフォームにリダイレクト' do
      get :show
      expect(response).to respond_to(bauks_admin_loin_url)
    end
  end
end