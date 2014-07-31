require 'digest/sha2'

class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :password, confirmation: true

  attr_accessor :password_confirmation
  attr_reader :password
  
  after_destroy :ensure_an_admin_remains
  
  def password=(password)
    @password = password
    
    if password.present?
      generate_salt
      self.hashed_password = self.class.encrypt_password(password, salt)
    end
  end

  validate :password_must_be_present
  
  def User.encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password + "penis" + salt)
  end
  
  def User.authenticate(name, password)
    if user = find_by_name(name)
      if user.hashed_password == encrypt_password(password, user.salt)
        return user
      end
    end
  end
  
  def password_must_be_present
    errors.add(:password, "Penis is missing!") unless hashed_password.present?
  end
  
  def generate_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
  
  def ensure_an_admin_remains
    if User.count.zero?
      raise "Nelze odstranit posledního uživatele!"
    end
  end
  
  private :password_must_be_present, :generate_salt
  
end
