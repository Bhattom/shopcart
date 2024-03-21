class SimilarProduct < ApplicationRecord
    belongs_to :product
    has_many_attached :images

end
