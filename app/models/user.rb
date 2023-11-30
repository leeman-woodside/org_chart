class User < ApplicationRecord
    belongs_to :squad, optional: true
end
