shared_examples 'a protected staff controller' do
  describe '#show' do
    example 'ログインフォームにリダイレクト' do
      get :show, params: {id: 1}
      expect(response).to redirect_to(baukis_staff_login_url)
    end
  end
end

shared_examples 'a protected singular admin controller' do
  describe '#show' do
    example 'ログインフォームにリダイレクト' do
      get :show
      expect(response).to respond_to(bauks_staff_loin_url)
    end
  end
end