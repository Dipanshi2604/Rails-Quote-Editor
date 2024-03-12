class ServiceController < ApplicationController
  def serviceworker
    render file: Rails.root.join("public/serviceworker.js"), layout: false, content_type: "application/javascript"
  end
end