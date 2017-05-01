class Article < ActiveRecord::Base
  has_and_belongs_to_many :suppliers
  belongs_to :manufacturer

  has_many :cart_items
  has_many :carts, :through => :cart_items

  has_attached_file :cover_image
  validates_attachment :cover_image,
  :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }

  validates_length_of :title, :in => 3..255, :message => 'debe ser una cadena entre 3 y 255 caracteres'
  validates_presence_of :manufacturer
  validates_presence_of :suppliers, :message => 'debe seleccionar al menos un proveedor'
  validates_presence_of :manufactured_at
  validates_numericality_of :size, :only_integer => true, :greater_than => 30, :less_than => 50, :message => 'debe ser un número maayor que 30 y menor que 50'
  validates_numericality_of :price, :message => 'debe ser un número'
  validates_length_of :reference, :in => 1..13, :message => 'debe ser una cadena entre 1 y 13 caracteres'
  validates_format_of :reference, :with => /[0-9\-xX]{13}/, :message => 'formato incorrecto'
  validates_uniqueness_of :reference, :message => 'ya existe un artículo con esa misma referencia'

  def supplier_names
    self.suppliers.map{|supplier| supplier.name}.join(", ")
  end

  def self.latest(num)
    all.order("articles.id desc").includes(:suppliers, :manufacturer).limit(num)
  end
end
