require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DailyReportApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # タイムゾーン変更
    config.i18n.default_locale = :ja
    config.time_zone = 'Asia/Tokyo'
    # ここまで

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.generators do |g|
      g.template_engine :erb
      g.javascripts false
      g.stylesheets false
      g.helper true
      g.test_framework :rspec
    end
  end
end
