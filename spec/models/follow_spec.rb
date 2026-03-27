require 'rails_helper'

RSpec.describe Follow, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:follower).class_name('User') }
    it { is_expected.to belong_to(:followed).class_name('User') }
  end

  describe 'validations' do
    it 'prevents duplicate follows' do
      user1 = create(:user)
      user2 = create(:user)
      create(:follow, follower: user1, followed: user2)
      duplicate = build(:follow, follower: user1, followed: user2)
      expect(duplicate).not_to be_valid
    end

    it 'prevents self-follow' do
      user = create(:user)
      follow = build(:follow, follower: user, followed: user)
      expect(follow).not_to be_valid
    end
  end
end

RSpec.describe User, type: :model do
  describe 'follow associations' do
    it { is_expected.to have_many(:active_follows) }
    it { is_expected.to have_many(:passive_follows) }
    it { is_expected.to have_many(:following).through(:active_follows) }
    it { is_expected.to have_many(:followers).through(:passive_follows) }
  end

  describe '#follow and #unfollow' do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }

    it 'follows another user' do
      user1.follow(user2)
      expect(user1.following?(user2)).to be true
      expect(user2.followers).to include(user1)
    end

    it 'unfollows a user' do
      user1.follow(user2)
      user1.unfollow(user2)
      expect(user1.following?(user2)).to be false
    end

    it 'does not raise error when unfollowing a non-followed user' do
      expect { user1.unfollow(user2) }.not_to raise_error
    end
  end
end
