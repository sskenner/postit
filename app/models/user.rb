class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username,
    presence: true,
    uniqueness: true
  validates :password,
    presence: true,
    on: :create,
    length: { minimum: 3 }

  def two_factor_auth?
    !self.phone.blank?
  end

  def generate_pin!
    self.update_column(:pin, rand(10 ** 6))
  end

  def remove_pin!
    self.update_column(:pin, nil)
  end

  def send_pin_to_twilio
    account_sid = 'ACd5dcec2ee4c3a198bcda78dcb220afdc'
    auth_token = '23f7bfba823e21e6c9d000c8894a41c4'

    # set up a client to talk to the Twilio REST API
    client = Twilio::REST::Client.new(account_sid, auth_token)

    msg = "please input the pin to continue login: #{self.pin}"
    account = client.account
    message = account.sms.messages.create({:from => '+13474484110', :to => "#{self.phone}", :body => msg })
  end

  def admin?
    self.role == 'admin'
  end

  def to_param
    self.slug # sort this out
  end
end
