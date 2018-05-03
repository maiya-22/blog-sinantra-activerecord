class Demographic < ActiveRecord::Base
    belongs_to :user # { :foreign_key => 'custom_foreign_key' }
end