class User < ActiveRecord::Base
  acts_as_authentic do |a|
    a.validate_login_field = true
    a.validate_password_field = true
    a.require_password_confirmation = true
    a.logged_in_timeout = 5.minutes # default is 10.minutes
  end

  validates_presence_of :name,:message => "No has introducido tu nombre."
  validates_presence_of :login, :message => "No has introducido el usuario."
  validates_presence_of :email, :message => "No has introducido el e-mail."
  validates_presence_of :password, :message => "No has introducido la contraseña."
  validates_presence_of :password_confirmation, :message => "No has confirmado la contraseña."
  validates_length_of :name, :in => 3..225, :message => "es muy corto (mínimo 3 caracteres)."
  validates_uniqueness_of :name, :login, :email
end
