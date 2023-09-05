# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "http://localhost", "http://web",
            "http://localhost:3001", "http://127.0.0.1:3001",
            "http://143.198.157.160",
            "https://alexisortega.dev", "https://www.alexisortega.dev"

    resource "*",
      headers: ["Authorization"],
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      expose: ["Authorization"], # The HTTP headers in the resource response can be exposed to the client
      credentials: true
  end
end
