class User < ApplicationRecord
  MAXIMUM_EMAIL_LENGTH = 64
  MAXIMUM_USERNAME_LENGTH = 64
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  before_save :email_to_downcase

  validates :username, presence: true, length: { maximum: MAXIMUM_USERNAME_LENGTH }
  validates :email, presence: true, length: { maximum: MAXIMUM_EMAIL_LENGTH },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :meal_recipes, dependent: :destroy

  private

  def email_to_downcase
    self.email = email.downcase
  end
end
