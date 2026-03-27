require 'rails_helper'

RSpec.describe NotificationMailer, type: :mailer do
  describe '#new_comment' do
    let(:post_author) { create(:user, name: 'Alice', email: 'alice@example.com') }
    let(:commenter) { create(:user, name: 'Bob') }
    let(:post) { create(:post, user: post_author, title: 'My Great Post') }
    let(:comment) { create(:comment, user: commenter, post: post, body: 'Nice post!') }
    let(:mail) { NotificationMailer.new_comment(comment) }

    it 'renders the headers' do
      expect(mail.subject).to eq('New comment on "My Great Post"')
      expect(mail.to).to eq([ 'alice@example.com' ])
    end

    it 'renders the body with commenter name' do
      expect(mail.body.encoded).to match('Bob')
      expect(mail.body.encoded).to match('Nice post!')
    end
  end

  describe '#new_follower' do
    let(:followed_user) { create(:user, name: 'Alice', email: 'alice@example.com') }
    let(:follower_user) { create(:user, name: 'Charlie') }
    let(:mail) { NotificationMailer.new_follower(follower: follower_user, followed: followed_user) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Charlie started following you')
      expect(mail.to).to eq([ 'alice@example.com' ])
    end

    it 'renders the body with follower name' do
      expect(mail.body.encoded).to match('Charlie')
    end
  end

  describe '#welcome' do
    let(:user) { create(:user, name: 'Dave', email: 'dave@example.com') }
    let(:mail) { NotificationMailer.welcome(user) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Welcome to the Blog!')
      expect(mail.to).to eq([ 'dave@example.com' ])
    end

    it 'renders the body with user name' do
      expect(mail.body.encoded).to match('Dave')
    end
  end
end
