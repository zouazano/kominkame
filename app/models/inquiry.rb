class Inquiry < ApplicationRecord

	belongs_to :house

	enum demand: { document: 0, viewing: 1, other: 2 }

  validates :name,   length: { minimum: 1, :too_short => '名前を入力して下さい。'}
  validates :email,  length: { minimum: 3, :too_short => 'メールアドレスを入力して下さい。'}
  validates_numericality_of :phonenumber, { :message => '電話番号は数字で入力して下さい。'}
  validates :demand, :presence => { :message => 'ご要望を入力して下さい。'}	

end
