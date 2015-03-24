require "slim"
Slim::Engine.disable_option_validator!

activate :automatic_image_sizes

configure :development do
  activate :livereload
end

helpers do
  def stylesheet_path(source)
    asset_path(:css, source)
  end

  def lazy_image_tag(source, retina)
    orgPath = asset_path(:images, source)
    retinaPath = asset_path(:images, retina)
    return image_tag('', :class => 'lazy', 'data-src' => orgPath, 'data-src-retina' => retinaPath)
  end
end

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :fonts_dir,  "fonts-folder"

activate :imageoptim do |options|
  options.manifest = true
  options.skip_missing_workers = true
  options.verbose = false
  options.nice = true
  options.threads = true
  options.image_extensions = %w(.png .jpg .gif .svg)
  options.jpegoptim = { :strip => ['all'], :max_quality => 80 }
  options.jpegtran  = { :copy_chunks => false, :progressive => true, :jpegrescan => true }
  options.optipng   = { :level => 6, :interlace => false }
  options.pngcrush  = { :chunks => ['alla'], :fix => false, :brute => false }
end

activate :autoprefixer do |config|
  config.browsers = ['last 2 versions', 'Explorer >= 9']
  config.cascade  = false
  config.inline   = true
end

activate :blog do |blog|
  blog.prefix = "articles"
  blog.layout = "blog_layout"
  blog.permalink = "{slug}.html"
  blog.sources = "{slug}.html"
  blog.paginate = true
  blog.page_link = "p{num}"
  blog.per_page = 20
  blog.taglink = "{tag}.html"
  blog.tag_template = "tag.html"
  blog.default_extension = '.markdown'
  blog.summary_separator = /-READ_MORE-/
  Time.zone = "Berlin"
  blog.custom_collections = {
      category: {
        link: '/{category}.html',
        template: '/category.html'
      }
    }
end

configure :build do

  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
  activate :relative_assets

end
