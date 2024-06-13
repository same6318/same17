class User < ApplicationRecord
    has_many :tasks

    validates :name, presence: { message: 'を入力してください'}, length: { maximum: 30 }
    validates :email, presence: { message: 'を入力してください'}, length: { maximum: 255 }
    validates :email, confirmation: true #重複チェック
    validates :email, uniqueness: { message: 'はすでに使用されています'} #値の重複チェック
    before_validation { email.downcase! }

    has_secure_password #passwordとpassword_confirmationの仮想カラムが使える。
    validates :password, presence: true, length: { minimum: 6, message: 'は6文字以上で入力してください'}
end
