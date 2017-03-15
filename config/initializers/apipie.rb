Apipie.configure do |config|
  config.app_name                = 'Ruby on rails starter kit'
  config.api_base_url            = ''
  config.doc_base_url            = '/apipie'
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
  config.default_version = '1'
end
