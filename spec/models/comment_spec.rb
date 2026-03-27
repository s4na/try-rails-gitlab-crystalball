require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:post) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_length_of(:body).is_at_most(1000) }
  end

  describe 'ordering' do
    it 'returns comments in chronological order with .chronological' do
      user = create(:user)
      post = create(:post, user: user)
      old_comment = create(:comment, user: user, post: post, created_at: 1.day.ago)
      new_comment = create(:comment, user: user, post: post, created_at: 1.hour.ago)
      expect(Comment.chronological).to eq([old_comment, new_comment])
    end
  end
end
