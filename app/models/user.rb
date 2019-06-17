class User < ApplicationRecord
  include Gravtastic
  gravtastic
  # 仮想の属性を作成 #has_secure_passwordの場合は(password属性)自動生成される
  # remember_digestとセット
  attr_accessor :remember_token, :activation_token
  # メソッド参照の方が良い(before_action)
  before_save :downcase_email
  before_create :create_activation_digest
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  has_secure_password
  # allow_nil: trueはプロフィール更新時パスワードがnilでもtrueになる
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :a_word, length: { maximum: 30 }
  validates :introduction, length: { maximum: 100 }


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
    # 記憶ダイジェストを更新(バリデーション素通りさせる)
    # 既にデータベースにいるユーザーに対して行う
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す (remember_token)はローカル変数
  def authenticated?(remember_token)
    # 記憶digestがnilの場合falseを返しreturnで終了(ログアウトした場合2重でloginは不可)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end


  # 外部に公開する必要の無いものはこちら
  private

    # メールアドレスを全て小文字にする
    def downcase_email
      # selfは現在のユーザーを指す
      self.email = email.downcase
    end

    # 有効化トークンとダイジェストを作成およびダイジェストにトークンを代入する
    # 新しいユーザーの為に作成
    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
