require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end

  # user_id、title、body があれば有効か
  it 'is valid with a user_id, title, body' do
    post = Post.new(
      user_id: @user.id,
      title: 'Sample title.',
      body: 'Sample body.'
    )
    expect(post).to be_valid
  end

  # user_id がなければ無効か
  it 'is invalid without a user_id' do
    post = Post.new(user_id: nil)
    post.valid?
    expect(post.errors.messages[:user_id]).to include('can\'t be blank')
  end

  # title がなければ無効か
  it 'is invalid without a title' do
    post = Post.new(title: nil)
    post.valid?
    expect(post.errors.messages[:title]).to include('can\'t be blank')
  end

  # body がなければ無効か
  it 'is invalid without a body' do
    post = Post.new(body: nil)
    post.valid?
    expect(post.errors.messages[:body]).to include('can\'t be blank')
  end
end
