# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

customer1 = Customer.create!(first_name: 'Patrick', last_name: 'Stewart', email: 'ohcaptain@tealover.com', address: '1234 Love Tea Dr, Spilled Tea, TX 12345')
customer2 = Customer.create!(first_name: 'Mister', last_name: 'Tea', email: 'piteathefool@tealover.com', address: '4321 Love Tea Dr, Spilled Tea, TX 12345')
Customer.create!(first_name: 'Ted', last_name: 'Lasso', email: 'not4me@tealover.com', address: '2468 No Love Tea Ct, Spilled Tea, TX 12345')

tea1 = Tea.create!(title: 'Glengettie', description: "Mae'r cyfuniad o flas arbennig ac ansawdd wedi gwneud Glengettie yn ffefryn yng Nghymru ers blynyddoedd lawer.", temperature: 190, brew_time: 300)
tea2 = Tea.create!(title: 'Chai', description: 'Black tea with a mixture of aromatic herbs and spices.', temperature: 200, brew_time: 240)
tea3 = Tea.create!(title: 'Earl Grey', description: 'Tea. Earl grey. Hot.', temperature: 200, brew_time: 240)
tea4 = Tea.create!(title: 'Peppermint', description: 'Great for your tummy troubles', temperature: 208, brew_time: 300)

Subscription.create!(title: "Captain's Choice", price: 1000, status: 0, frequency: 4, customer: customer1, tea: tea3)
Subscription.create!(title: 'Single Tea', price: 1000, status: 1, frequency: 2, customer: customer1, tea: tea4)
Subscription.create!(title: 'Fall Tea Collection', price: 1000, status: 0, frequency: 2, customer: customer2, tea: tea3)
Subscription.create!(title: 'Fall Tea Collection', price: 1000, status: 0, frequency: 4, customer: customer2, tea: tea1)
Subscription.create!(title: 'Fall Tea Collection', price: 1000, status: 0, frequency: 6, customer: customer2, tea: tea2)
