require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { build(:user) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_length_of(:name).is_at_most(50) }
    it { is_expected.to validate_length_of(:email).is_at_most(255) }
    it { is_expected.to have_secure_password }

    context 'email format' do
      it 'rejects invalid email addresses' do
        invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
        invalid_addresses.each do |invalid_address|
          user = build(:user, email: invalid_address)
          expect(user).not_to be_valid, "#{invalid_address.inspect} should be invalid"
        end
      end

      it 'accepts valid email addresses' do
        valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
        valid_addresses.each do |valid_address|
          user = build(:user, email: valid_address)
          expect(user).to be_valid, "#{valid_address.inspect} should be valid"
        end
      end
    end
  end

  describe 'callbacks' do
    it 'normalizes email to lowercase before saving' do
      user = create(:user, email: 'Foo@ExAMPle.CoM')
      expect(user.reload.email).to eq('foo@example.com')
    end
  end
end
