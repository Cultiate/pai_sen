class Coach < ApplicationRecord
  has_many :users, through: :favorites
  has_many :favorites
  has_many :messages
  has_many :rooms
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save :downcase_email
  before_create :create_activation_digest
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }, on: :update_password
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, on: :update_password

  def self.from_omniauth(auth)
    coach = Coach.where('email = ?', auth.info.email).first
    if coach.blank?
      coach = Coach.new
    end
    coach.uid   = auth.uid
    coach.provider = auth.provider
    coach.name  = auth.info.name
    coach.email = auth.info.email
    self.coach_image  = URI.parse(auth.info.image)
    coach.password = Coach.new_token
    coach.password_confirmation = coach.password
    coach
  end

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember_coach
    self.remember_token = Coach.new_token
    update_attribute(:remember_digest, Coach.digest(remember_token))
  end

  def forget_coach
    update_attribute(:remember_digest, nil)
  end

  def authenticated_coach?(remember_token, token)
    digest = self.send('remember_digest')
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(remember_token)
  end

  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_email
    CoachMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = Coach.new_token
    update_attribute(:reset_digest, Coach.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    CoachMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def receive_notification
    MessageMailer.receive_notification(self).deliver_now
  end

  private

    def downcase_email
      self.email = email.downcase
    end

    def create_activation_digest
        self.activation_token  = Coach.new_token
        self.activation_digest = Coach.digest(activation_token)
    end
end
