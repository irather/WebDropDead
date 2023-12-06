# app/models/user.rb
class User < ApplicationRecord
    attr_accessor :quarters
  
    has_secure_password
  
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 6 }
  
    # Make the presence validation conditional
    validates :quarters, presence: true, unless: -> { skip_quarters_validation }
    validates :white_dice, presence: true, unless: -> { skip_white_dice_validation }
    validates :points, presence: true, unless: -> { skip_points_validation }
  
    attr_accessor :skip_quarters_validation, :skip_white_dice_validation, :skip_points_validation
  end
  