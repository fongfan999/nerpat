source 'https://rubygems.org'
ruby '2.3.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.2'
gem 'pg', '~> 0.20.0'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

group :development, :test do
  gem 'dotenv-rails'
  gem 'byebug', platform: :mri
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'pundit', '~> 1.1'
gem 'omniauth-google-oauth2'
gem 'omniauth-facebook'
gem 'paperclip', '~> 5.0.0'
gem 'materialize-sass', '~> 0.98.2'
gem 'simple_form', '~> 3.4'
gem 'materialize-form', '~> 1.0.8'
gem 'client_side_validations', '~> 9.3.0'
gem 'client_side_validations-simple_form', '~> 6.2.0'
gem 'kaminari', '~> 1.0.1'