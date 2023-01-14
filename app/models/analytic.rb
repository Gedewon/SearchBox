class Analytic < ActiveRecord::Base
   validates :frequency, :query, presence: true  
end