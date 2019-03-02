require 'rails_helper'

RSpec.describe User, type: :model do
  # email、password があれば有効か
  it 'is valid with a email, password' do
    user = User.new(
      email: 'sample@example.com',
      password: 'passw0rd'
    )
    expect(user).to be_valid
  end

  # email がなければ無効か
  it 'is invalid without email' do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors.messages[:email]).to include('can\'t be blank')
  end

  # 重複したメールアドレスなら無効か
  it 'is invalid with a duplicate email' do
    User.create(
      email: 'sample@example.com',
      password: 'passw0rd'
    )
    user = User.new(
      email: 'sample@example.com',
      password: 'passw0rd'
    )
    user.valid?
    expect(user.errors[:email]).to include('has already been taken')
  end
end
