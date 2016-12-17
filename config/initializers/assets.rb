# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
# Rails.application.config.assets.precompile += %w( welcome.scss )
Rails.application.config.assets.precompile += %w( dashboard/resizeApp.js )
Rails.application.config.assets.precompile += %w( difflib.js )
Rails.application.config.assets.precompile += %w( diffview.js )
Rails.application.config.assets.precompile += %w( dashboard/tags.js )
Rails.application.config.assets.precompile += %w( dashboard/home.js )
Rails.application.config.assets.precompile += %w( AdminLTE/plugins/daterangepicker/daterangepicker.js )
# Rails.application.config.assets.precompile += %w( dashboard/search.js )
# Rails.application.config.assets.precompile += %w( dashboard/search_filters.js )
Rails.application.config.assets.precompile += %w( answers_panel/vivagraph.js )
Rails.application.config.assets.precompile += %w( dashboard/graph.js )
Rails.application.config.assets.precompile += %w( codemirror/lib/codemirror.js )
Rails.application.config.assets.precompile += %w( codemirror/mode/pascal/pascal.js )
Rails.application.config.assets.precompile += %w( codemirror/mode/ruby/ruby.js )
Rails.application.config.assets.precompile += %w( codemirror/mode/clike/clike.js )
Rails.application.config.assets.precompile += %w( prettify.js )
Rails.application.config.assets.precompile += %w( run_prettify.js )
