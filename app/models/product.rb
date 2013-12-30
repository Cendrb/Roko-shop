class Product < ActiveRecord::Base
  validates :title, :description, :image_url, :presence => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :title, :uniqueness => true
  validates :image_url, :format =>{
    :with => %r{\.(gif|jpg|png)}i,
    :message => "Musí jít o adresu URL pro obrázek typu GIF, JPG nebo PNG."
  }
end
