require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_length_of(:title).is_at_most(255) }
  end

  describe 'scopes' do
    it 'orders by newest first with .recent' do
      user = create(:user)
      old_post = create(:post, user: user, created_at: 1.day.ago)
      new_post = create(:post, user: user, created_at: 1.hour.ago)
      expect(Post.recent).to eq([ new_post, old_post ])
    end
  end

  describe 'user association' do
    it 'belongs to a user' do
      user = create(:user)
      post = create(:post, user: user)
      expect(post.user).to eq(user)
    end
  end
end
