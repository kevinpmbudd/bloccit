class User < ApplicationRecord
  before_save :normalize_email, :normalize_name

  validates :name,
            length: { minimum: 1, maximum: 100 },
            presence: true

  validates :password,
            presence: true,
            length: { minimum: 6 },
            if: :new_user?
  validates :password,
            length: { minimum: 6 },
            allow_blank: true

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 254 }

  has_secure_password

  private
    def new_user?
      password_digest.nil?
    end

    def normalize_email
      self.email = email.downcase if email.present?
    end

    def normalize_name
      self.name = name.split.map { |n| n.capitalize }.join(' ') if name.present?
    end
end
