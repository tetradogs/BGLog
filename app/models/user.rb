class User < ActiveRecord::Base

has_many :listings

devise :database_authenticatable, :registerable,
:recoverable, :rememberable, :trackable, :validatable, :omniauthable

def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    User.dummy_email(auth),
        password: Devise.friendly_token[0, 20],
        name: auth.info.name,
        image: "http://graph.facebook.com/#{auth.uid}/picture?type=large"#default auth.info.image,
      )
    end

user
end

private

def self.dummy_email(auth)
  "#{auth.uid}-#{auth.provider}@example.com"
end


end

