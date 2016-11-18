class StaticPagesController < ApplicationController
  def home
    @slides = Dir.glob("app/assets/images/samples/*")
  end
end
