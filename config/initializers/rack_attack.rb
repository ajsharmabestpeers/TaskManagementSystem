class Rack::Attack
    # Allow an IP address to make up to 5 requests per second
    throttle('req/ip', limit: 10, period: 1.second) do |req|
      req.ip
    end
  end
  