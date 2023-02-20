# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
['Bc', 'Ab','Adf','Abcde'].each do |element| 
    Analytic.create(query:element, frequency:1)
end

Analytic.create(query:'Abc', frequency:4)
Analytic.create(query:'What is a good car', frequency:4)
