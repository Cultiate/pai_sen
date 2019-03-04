class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save :downcase_email
  before_create :create_activation_digest
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }, on: :update_password
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, on: :update_password
  has_many :coaches, through: :favorites
  has_many :favorites
  has_many :messages
  has_many :rooms

  def self.from_omniauth(auth)
    user = User.where('email = ?', auth.info.email).first
    if user.blank?
      user = User.new
    end
    user.uid   = auth.uid
    user.provider = auth.provider
    user.name  = auth.info.name
    user.email = auth.info.email
    user.user_image  = URI.parse(auth.info.image)
    user.password = User.new_token
    user.password_confirmation = user.password
    user
  end

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def receive_notification
    MessageMailer.receive_notification(self).deliver_now
  end

  def send_message(other_user, room_id, content)
    from_messages.create!(to_id: other_user.id, room_id: room_id, content: content)
  end

  private

    def downcase_email
      self.email = email.downcase
    end

    def create_activation_digest
        self.activation_token  = User.new_token
        self.activation_digest = User.digest(activation_token)
    end
end
