class User < ApplicationRecord
  include Gravtastic
  gravtastic
  # 仮想の属性を作成
  attr_accessor :remember_token
  # selfは現在のユーザーを指す
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  # 定義する事によりfixtureを作成できるようになる
  # 渡された文字列のハッシュ値を返す
  def self.digest(string) #self = Userクラスを指す
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                              BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def self.new_token #self = Userクラスを指す
    # SecureRandomモジュールにあるurlsafe_base64メソッド(記憶トークン作成)
    SecureRandom.urlsafe_base64
  end

  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    # selfを使う事によってremember_tokenのローカル変数が作成されない
    # selfは現在のユーザーを指す
    self.remember_token = User.new_token
    # 記憶ダイジェストを更新
    update_attribute(:remember_digest, User.digest(remember_token))
  end


end
