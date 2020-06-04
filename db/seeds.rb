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
