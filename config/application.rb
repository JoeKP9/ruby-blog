require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Blog
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "UTC"
    # config.eager_load_paths << Rails.root.join("extras")
    Rails.application.config.after_initialize do
      default_allowed_attributes = Rails::HTML5::Sanitizer.safe_list_sanitizer.allowed_attributes + ActionText::Attachment::ATTRIBUTES.to_set
      custom_allowed_attributes = Set.new(%w[controls data-controller role style])
      ActionText::ContentHelper.allowed_attributes = (default_allowed_attributes + custom_allowed_attributes).freeze
    
      default_allowed_tags = Rails::HTML5::Sanitizer.safe_list_sanitizer.allowed_tags + Set.new([ActionText::Attachment.tag_name, "figure", "figcaption"])
      custom_allowed_tags = Set.new(%w[audio video source])
      ActionText::ContentHelper.allowed_tags = (default_allowed_tags + custom_allowed_tags).freeze
    end
  end
end
