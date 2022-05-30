module RedisGraphClient
  extend ActiveSupport::Concern

  def rg
    r = RedisGraph.new("development", redis_options= { host: "127.0.0.1", port: 6379 })
    return r
  end
end
