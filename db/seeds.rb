# frozen_string_literal: true

# seeding providers
Provider.create(name: 'twilio', type: 'Sms', min_limit: 200)
Provider.create(name: 'sendgrid', type: 'Email', min_limit: 400)
Provider.create(name: 'firebase', type: 'PushNotification', min_limit: 500)

# seeding languages
Language.create(name: 'english', code: 'en')
Language.create(name: 'arabic', code: 'ar')
Language.create(name: 'french', code: 'fr')
Language.create(name: 'german', code: 'de')

# seeding some users
User.create(first_name: 'jihan', last_name: 'adel', email: 'jihan20@gmail.com', phone: '+201498876789', language: Language.first)
User.create(first_name: 'ahmed', last_name: 'adel', email: 'ahmed@gmail.com', phone: '+201478876789', language: Language.first)
