# frozen_string_literal: true

class User < ActiveRecord::Base
  has_secure_password

  has_many :notes

  validates_presence_of :username,
                        allow_blank: false,
                        message: "Username can't be blank."
  validates_length_of :username,
                      minimum: 4,
                      message: 'Username is too short.'
  validates_uniqueness_of :username,
                          message: 'Username already registered.'
  validates_presence_of :email,
                        allow_blank: false,
                        message: "Email can't be blank."
  validates_uniqueness_of :email,
                          message: 'Email already registered.'
  validates_presence_of :password,
                        allow_blank: false,
                        message: "Password can't be blank."
  validates_length_of :password,
                      minimum: 6,
                      message: "Password can't be less than 6 caracters"
end
