require 'rails_helper'

RSpec.describe User do
  describe 'associations' do
    it { is_expected.to have_many(:meal_recipes) }
  end

  describe 'validations' do
    it { is_expected.to have_secure_password}

    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }

    it { is_expected.to validate_length_of(:username).is_at_most(User::MAXIMUM_USERNAME_LENGTH) }
    it { is_expected.to validate_length_of(:email).is_at_most(User::MAXIMUM_EMAIL_LENGTH) }
    it { is_expected.to validate_length_of(:password).is_at_least(User::MINIMUM_PASSWORD_LENGTH) }

    context 'when matching the uniqueness of an email' do
      subject { create(:user) }

      it { is_expected.to validate_uniqueness_of(:email) }
    end

    context "when saving" do
      it "turns email to lower case" do
        brad = create(:user, email: 'TESTING@TEST.COM')

        expect(brad.email).to eq 'testing@test.com'
      end
    end

    context "when saving email with different format" do
      it "is invalid" do
        brad = build(:user, email: 'TESTING@TEST')

        expect(brad.valid?).to be false
      end
    end
  end
end
