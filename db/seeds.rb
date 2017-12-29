# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
ShadowSpot.destroy_all
Subject.destroy_all
Teacher.destroy_all

@teachers = Teacher.create([
  { first_name: "Rowena",
    last_name: "Aldridge",
    email: "rowenaaldridgeweb@gmail.com",
    subject_id: Subject.create({ name: "Literature", grade: 5 }).id
  },{
    first_name: "Alyssa",
    last_name: "Hayes",
    email: "alyssahayesweb@gmail.com",
    subject_id: Subject.create({ name: "Literature", grade: 6 }).id
  },{
    first_name: "Amy",
    last_name: "Scruggs",
    email: "amyescruggs@gmail.com",
    subject_id: Subject.create({ name: "Literature", grade: 7 }).id
  },{
    first_name: "Jessica",
    last_name: "Conrad",
    email: "jdconrad@protonmail.com",
    subject_id: Subject.create({ name: "Literature", grade: 8 }).id
  },{
    first_name: "Sarah",
    last_name: "Huneycutt",
    email: "shuneyc@comcast.net",
    subject_id: Subject.create({ name: "General Science", grade: 5 }).id
  },{
    first_name: "Jennifer",
    last_name: "Castro",
    email: "jcastro103@gmail.com",
    subject_id: Subject.create({ name: "Chemistry", grade: 6 }).id
  },{
    first_name: "Jen",
    last_name: "Gentry",
    email: "gentryreillyjj@gmail.com",
    subject_id: Subject.create({ name: "Environmental Science", grade: 7 }).id
  },{
    first_name: "Brian",
    last_name: "Donohue",
    email: "bdonohue2@me.com",
    subject_id: Subject.create({ name: "Physical Science", grade: 8 }).id
  } ]
)

p "Created #{Teacher.count} teachers & #{Subject.count} subjects"

shadow_spots = ShadowSpot.create([
  {
    date: "2018-01-24",
    time: "8:45 AM",
    subject: Subject.where({ name: "General Science", grade: 5}).first
  },{
    date: "2018-01-24",
    time: "10:15 AM",
    subject: Subject.where({ name: "Literature", grade: 5}).first
  },{
    date: "2018-01-24",
    time: "8:45 AM",
    subject: Subject.where({ name: "Chemistry", grade: 6}).first
  },{
    date: "2018-01-24",
    time: "10:15 AM",
    subject: Subject.where({ name: "Literature", grade: 6 }).first
  },{
    date: "2018-01-31",
    time: "8:45 AM",
    subject: Subject.where({ name: "General Science", grade: 5}).first
  },{
    date: "2018-01-31",
    time: "10:15 AM",
    subject: Subject.where({ name: "Literature", grade: 5}).first
  },{
    date: "2018-01-31",
    time: "8:45 AM",
    subject: Subject.where({ name: "Chemistry", grade: 6}).first
  },{
    date: "2018-01-31",
    time: "10:15 AM",
    subject: Subject.where({ name: "Literature", grade: 6 }).first
  },{
    date: "2018-02-07",
    time: "8:45 AM",
    subject: Subject.where({ name: "General Science", grade: 5}).first
  },{
    date: "2018-02-07",
    time: "10:15 AM",
    subject: Subject.where({ name: "Literature", grade: 5}).first
  },{
    date: "2018-02-07",
    time: "8:45 AM",
    subject: Subject.where({ name: "Chemistry", grade: 6}).first
  },{
    date: "2018-02-07",
    time: "10:15 AM",
    subject: Subject.where({ name: "Literature", grade: 6 }).first
  },{
    date: "2018-02-14",
    time: "8:45 AM",
    subject: Subject.where({ name: "General Science", grade: 5}).first
  },{
    date: "2018-02-14",
    time: "10:15 AM",
    subject: Subject.where({ name: "Literature", grade: 5}).first
  },{
    date: "2018-02-14",
    time: "8:45 AM",
    subject: Subject.where({ name: "Chemistry", grade: 6}).first
  },{
    date: "2018-02-14",
    time: "10:15 AM",
    subject: Subject.where({ name: "Literature", grade: 6 }).first
  },{
    date: "2018-02-21",
    time: "8:45 AM",
    subject: Subject.where({ name: "General Science", grade: 5}).first
  },{
    date: "2018-02-21",
    time: "10:15 AM",
    subject: Subject.where({ name: "Literature", grade: 5}).first
  },{
    date: "2018-02-21",
    time: "8:45 AM",
    subject: Subject.where({ name: "Chemistry", grade: 6}).first
  },{
    date: "2018-02-21",
    time: "10:15 AM",
    subject: Subject.where({ name: "Literature", grade: 6 }).first
  },{
    date: "2018-02-28",
    time: "8:45 AM",
    subject: Subject.where({ name: "General Science", grade: 5}).first
  },{
    date: "2018-02-28",
    time: "10:15 AM",
    subject: Subject.where({ name: "Literature", grade: 5}).first
  },{
    date: "2018-02-28",
    time: "8:45 AM",
    subject: Subject.where({ name: "Chemistry", grade: 6}).first
  },{
    date: "2018-02-28",
    time: "10:15 AM",
    subject: Subject.where({ name: "Literature", grade: 6 }).first
  },{
    date: "2018-01-24",
    time: "8:45 AM",
    subject: Subject.where({ name: "Literature", grade: 7 }).first
  },{
    date: "2018-01-24",
    time: "10:15 AM",
    subject: Subject.where({ name: "Environmental Science", grade: 7}).first
  },{
    date: "2018-01-24",
    time: "8:45 AM",
    subject: Subject.where({ name: "Literature", grade: 8 }).first
  },{
    date: "2018-01-24",
    time: "10:15 AM" ,
    subject: Subject.where({ name: "Physical Science", grade: 8}).first
  },{
    date: "2018-01-31",
    time: "8:45 AM",
    subject: Subject.where({ name: "Literature", grade: 7 }).first
  },{
    date: "2018-01-31",
    time: "10:15 AM",
    subject: Subject.where({ name: "Environmental Science", grade: 7}).first
  },{
    date: "2018-01-31",
    time: "8:45 AM" ,
    subject: Subject.where({ name: "Literature", grade: 8 }).first
  },{
    date: "2018-01-31",
    time: "10:15 AM" ,
    subject: Subject.where({ name: "Physical Science", grade: 8}).first
  },{
    date: "2018-02-07",
    time: "8:45 AM",
    subject: Subject.where({ name: "Literature", grade: 7 }).first
  },{
    date: "2018-02-07",
    time: "10:15 AM",
    subject: Subject.where({ name: "Environmental Science", grade: 7}).first
  },{
    date: "2018-02-07",
    time: "8:45 AM" ,
    subject: Subject.where({ name: "Literature", grade: 8 }).first
  },{
    date: "2018-02-07",
    time: "10:15 AM",
    subject: Subject.where({ name: "Physical Science", grade: 8}).first
  },{
    date: "2018-02-14",
    time: "8:45 AM",
    subject: Subject.where({ name: "Literature", grade: 7 }).first
  },{
    date: "2018-02-14",
    time: "10:15 AM",
    subject: Subject.where({ name: "Environmental Science", grade: 7}).first
  },{
    date: "2018-02-14",
    time: "8:45 AM" ,
    subject: Subject.where({ name: "Literature", grade: 8 }).first
  },{
    date: "2018-02-14",
    time: "10:15 AM",
    subject: Subject.where({ name: "Physical Science", grade: 8}).first
  },{
    date: "2018-02-21",
    time: "8:45 AM",
    subject: Subject.where({ name: "Literature", grade: 7 }).first
  },{
    date: "2018-02-21",
    time: "10:15 AM",
    subject: Subject.where({ name: "Environmental Science", grade: 7}).first
  },{
    date: "2018-02-21",
    time: "8:45 AM" ,
    subject: Subject.where({ name: "Literature", grade: 8 }).first
  },{
    date: "2018-02-21",
    time: "10:15 AM" ,
    subject: Subject.where({ name: "Physical Science", grade: 8}).first
  },{
    date: "2018-02-28",
    time: "8:45 AM",
    subject: Subject.where({ name: "Literature", grade: 7 }).first
  },{
    date: "2018-02-28",
    time: "10:15 AM",
    subject: Subject.where({ name: "Environmental Science", grade: 7}).first
  },{
    date: "2018-02-28",
    time: "8:45 AM",
    subject: Subject.where({ name: "Literature", grade: 8 }).first
  },{
    date: "2018-02-28",
    time: "10:15 AM",
    subject: Subject.where({ name: "Physical Science", grade: 8}).first
  }])

  p "Created #{ShadowSpot.count} shadow_spots"
