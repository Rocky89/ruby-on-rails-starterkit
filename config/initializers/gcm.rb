GCM.host = 'https://android.googleapis.com/gcm/send'
# https://android.googleapis.com/gcm/send is default

GCM.format = :json
# :json is default and only available at the moment

GCM.key = ENV['GCM_KEY']
# this is the apiKey obtained from here https://code.google.com/apis/console/
