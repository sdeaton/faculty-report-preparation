# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

prng = Random.new

(1..3).each do |i|
  Evaluation.create(
    term: '2015C',
    subject: 'CSCE',
    course: '110',
    section: (500 + i).to_s,
    instructor: 'Tiffani Williams',
    enrollment: prng.rand(20..50),
    item1_mean: prng.rand(3.0..5.0).round(2),
    item2_mean: prng.rand(3.0..5.0).round(2),
    item3_mean: prng.rand(3.0..5.0).round(2),
    item4_mean: prng.rand(3.0..5.0).round(2),
    item5_mean: prng.rand(3.0..5.0).round(2),
    item6_mean: prng.rand(3.0..5.0).round(2),
    item7_mean: prng.rand(3.0..5.0).round(2),
    item8_mean: prng.rand(3.0..5.0).round(2)
  )
end

(1..3).each do |i|
  Evaluation.create(
    term: '2015C',
    subject: 'CSCE',
    course: '111',
    section: (500 + i).to_s,
    instructor: 'Joseph Daniel Hurley',
    enrollment: prng.rand(20..50),
    item1_mean: prng.rand(3.0..5.0).round(2),
    item2_mean: prng.rand(3.0..5.0).round(2),
    item3_mean: prng.rand(3.0..5.0).round(2),
    item4_mean: prng.rand(3.0..5.0).round(2),
    item5_mean: prng.rand(3.0..5.0).round(2),
    item6_mean: prng.rand(3.0..5.0).round(2),
    item7_mean: prng.rand(3.0..5.0).round(2),
    item8_mean: prng.rand(3.0..5.0).round(2)
  )
end

(1..8).each do |i|
  Evaluation.create(
    term: '2015C',
    subject: 'CSCE',
    course: '121',
    section: (500 + i).to_s,
    instructor: 'Walter Daugherity',
    enrollment: prng.rand(20..50),
    item1_mean: prng.rand(3.0..5.0).round(2),
    item2_mean: prng.rand(3.0..5.0).round(2),
    item3_mean: prng.rand(3.0..5.0).round(2),
    item4_mean: prng.rand(3.0..5.0).round(2),
    item5_mean: prng.rand(3.0..5.0).round(2),
    item6_mean: prng.rand(3.0..5.0).round(2),
    item7_mean: prng.rand(3.0..5.0).round(2),
    item8_mean: prng.rand(3.0..5.0).round(2)
  )
end
