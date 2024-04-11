class Product < ApplicationRecord
    before_destroy :not_referenced_by_any_lineitem  
    has_many :sizes
    has_many :lineitems
    has_many_attached :images
    has_many :similar_products
    has_and_belongs_to_many :categories
    

    validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }


    def not_referenced_by_any_lineitem
        unless lineitems.empty?
            error.add(:base, "Line items present")
            throw :abort
        end
    end

    def self.ransackable_attributes(_auth_object)
        ["name"]
      end
  
      def self.ransackable_associations(auth_object = nil)
        []
      end 
  

    

end
