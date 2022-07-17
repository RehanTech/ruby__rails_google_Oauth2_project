class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2, :github]
      
      # def self.from_omniauth(access_token)
      #     data = access_token.info
      #     user = User.where(email: data['email']).first
      
      #     # Uncomment the section below if you want users to be created if they don't exist
      #     # unless user
      #     #     user = User.create(name: data['name'],
      #     #        email: data['email'],
      #     #        password: Devise.friendly_token[0,20]
      #     #     )
      #     # end
      #     user
      # end

    def self.form_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
        user.full_name = auth.info.full_name
        user.avatar_url = auth.info.image
        end
    end
end
