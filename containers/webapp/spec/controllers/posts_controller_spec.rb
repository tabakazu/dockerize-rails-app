require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe '#index' do
    # 認証済みユーザとして
    context 'as an authenticated user' do
      before do
        @user = FactoryBot.create(:user)
      end

      # 正常にレスポンスを返すか
      it 'responds successfully' do
        sign_in @user
        get :index
        expect(response).to be_successful
      end

      # 200 レスポンスを返すか
      it 'returns a 200 response' do
        sign_in @user
        get :index
        expect(response).to have_http_status '200'
      end
    end

    # ゲストユーザとして
    context 'as a guest user' do
      # 300 レスポンスを返すか
      it 'returns a 302 response' do
        get :index
        expect(response).to have_http_status '302'
      end

      # new_user_session_path にリダイレクトされるか
      it 'redirects to new_user_session_path' do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#show' do
    # 認証済みユーザとして
    context 'as an authorized user' do
      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post)
      end

      # 正常にレスポンスを返すか
      it 'responds successfully' do
        sign_in @user
        get :show, params: { id: @post.id }
        expect(response).to be_successful
      end

      # 200 レスポンスを返すか
      it 'returns a 200 response' do
        sign_in @user
        get :show, params: { id: @post.id }
        expect(response).to have_http_status '200'
      end
    end

    # ゲストユーザとして
    context 'as a guest user' do
      before do
        @post = FactoryBot.create(:post)
      end

      # 300 レスポンスを返すか
      it 'returns a 302 response' do
        get :show, params: { id: @post.id }
        expect(response).to have_http_status '302'
      end

      # サインイン画面にリダイレクトされるか
      it 'redirects to new_user_session_path' do
        get :show, params: { id: @post.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#create' do
    # 認証済みユーザとして
    context 'as an authorized user' do
      before do
        @user = FactoryBot.create(:user)
      end

      # post を追加できるか
      it 'adds a post' do
        post_params = FactoryBot.attributes_for(:post)
        sign_in @user
        expect {
          post :create, params: { post: post_params }
        }.to change(@user.posts, :count).by(1)
      end
    end

    # ゲストユーザとして
    context 'as a guest user' do
      # 300 レスポンスを返すか
      it 'returns a 302 response' do
        post_params = FactoryBot.attributes_for(:post)
        post :create, params: { post: post_params }
        expect(response).to have_http_status '302'
      end

      # /users/sign_in にリダイレクトされるか
      it 'redirects to new_user_session_path' do
        post_params = FactoryBot.attributes_for(:post)
        post :create, params: { post: post_params }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#update' do
    # 認証済みユーザとして
    context 'as an authorized user' do
      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, user: @user)
      end

      # post を更新できるか
      it 'updates a post' do
        post_params = FactoryBot.attributes_for(:post, title: 'new title')
        sign_in @user
        patch :update, params: { id: @post.id, post: post_params }
        expect(@post.reload.title).to eq 'new title'
      end
    end

    # 認証されていないユーザとして
    context 'as an unauthorized user' do
      before do
        @user = FactoryBot.create(:user)
        other_user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, user: other_user, title: 'old title')
      end

      # post を更新できないか
      it 'does not update the post' do
        post_params = FactoryBot.attributes_for(:post, title: 'new title')
        sign_in @user
        patch :update, params: { id: @post.id, post: post_params }
        expect(@post.reload.title).to eq 'old title'
      end

      # posts_path にリダイレクトされるか
      it 'redirects to posts_path' do
        post_params = FactoryBot.attributes_for(:post)
        sign_in @user
        patch :update, params: { id: @post.id, post: post_params }
        expect(response).to redirect_to posts_path
      end
    end
  end

  describe '#destroy' do
    # 認証済みユーザとして
    context 'as an authorized user' do
      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, user: @user)
      end

      # post を削除できるか
      it 'deletes a post' do
        sign_in @user
        expect {
          delete :destroy, params: { id: @post.id }
        }.to change(@user.posts, :count).by(-1)
      end
    end

    # 認証されていないユーザとして
    context 'as an unauthorized user' do
      before do
        @user = FactoryBot.create(:user)
        other_user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, user: other_user, title: 'old title')
      end

      # post を削除できないか
      it "does not delete the post" do
        sign_in @user
        expect {
          delete :destroy, params: { id: @post.id }
        }.to_not change(Post, :count)
      end

      # posts_path にリダイレクトされるか
      it 'redirects to posts_path' do
        post_params = FactoryBot.attributes_for(:post)
        sign_in @user
        delete :destroy, params: { id: @post.id }
        expect(response).to redirect_to posts_path
      end
    end
  end
end
