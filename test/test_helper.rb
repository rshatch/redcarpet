# coding: UTF-8
$:.unshift(File.expand_path('../../lib', __FILE__))
Encoding.default_internal = 'UTF-8' if defined? Encoding

require 'test/unit'

require 'redcarpet'
require 'redcarpet/render_strip'
require 'redcarpet/render_man'

class Redcarpet::TestCase < Test::Unit::TestCase
  def assert_renders(html, markdown)
    assert_equal html, render(markdown)
  end

  def render(markdown, options = {})
    options = options.fetch(:with, {})

    if options.kind_of?(Array)
      options = Hash[options.map {|o| [o, true]}]
    end

    render = begin
      renderer.new(options)
    rescue ArgumentError
      renderer.new
    end

    parser = Redcarpet::Markdown.new(render, options)

    parser.render(markdown)
  end

  private

  def renderer
    @renderer ||= Redcarpet::Render::HTML
  end
end
