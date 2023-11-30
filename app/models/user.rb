class User < ApplicationRecord
    belongs_to :squad, optional: true
    belongs_to :department, optional: true
    belongs_to :chapter, optional: true
    belongs_to :group, optional: true
end
