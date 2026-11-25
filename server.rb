require 'webrick'
require 'json'

# ============================================================
# CONFIG — YOUR REAL WALLET ADDRESSES
# ============================================================
WALLETS = {
  'ETH' => '0x66f145b690b7E43650b8EC4825D08085f0A6AF45',
  'BTC' => 'bc1qw3ans56hlgag42lpd83l7yn3qu7peppdtt46j5',
  'SOL' => 'Dp5rGizHs9t7WTmnUyS1AqYLqavaXHL83ZNBBbRMrjSZ'
}

# Access codes — add/remove as you sell the blueprint
ACCESS_CODES = ['BLUEPRINT2026', 'REPLYGAMAX', 'ULTIMATE']

PORT = (ENV['PORT'] || 9191).to_i

# ============================================================

public_dir = File.expand_path(File.join(__dir__, 'public'))

server = WEBrick::HTTPServer.new(
  Port: PORT,
  DocumentRoot: public_dir,
  BindAddress: '0.0.0.0',
  AccessLog: [],
  Logger: WEBrick::Log.new($stderr, WEBrick::Log::INFO)
)

# API: verify access code
server.mount_proc '/api/verify' do |req, res|
  res['Content-Type'] = 'application/json'
  res['Access-Control-Allow-Origin'] = '*'

  if req.request_method == 'POST'
    payload = JSON.parse(req.body) rescue {}
    code = payload['code'].to_s.strip.upcase

    if ACCESS_CODES.include?(code)
      res.body = { success: true, token: 'granted' }.to_json
    else
      res.status = 401
      res.body = { error: 'Invalid access code' }.to_json
    end
  else
    res.status = 405
    res.body = { error: 'Method not allowed' }.to_json
  end
end

# API: get wallet addresses
server.mount_proc '/api/wallets' do |req, res|
  res['Content-Type'] = 'application/json'
  res['Access-Control-Allow-Origin'] = '*'
  res.body = WALLETS.to_json
end

# Serve guide content ONLY with valid token
server.mount_proc '/api/guide' do |req, res|
  token = req.header['x-access-token']&.first || req.query['token'].to_s

  if token == 'granted'
    res['Content-Type'] = 'text/html'
    content = File.read(File.join(public_dir, 'guide-content.html'))
    res.body = content
  else
    res.status = 401
    res['Content-Type'] = 'application/json'
    res.body = { error: 'Unauthorized' }.to_json
  end
end

# Serve resources content ONLY with valid token
server.mount_proc '/api/resources' do |req, res|
  token = req.header['x-access-token']&.first || req.query['token'].to_s

  if token == 'granted'
    res['Content-Type'] = 'text/html'
    content = File.read(File.join(public_dir, 'resources-content.html'))
    res.body = content
  else
    res.status = 401
    res['Content-Type'] = 'application/json'
    res.body = { error: 'Unauthorized' }.to_json
  end
end

trap('INT')  { server.shutdown }
trap('TERM') { server.shutdown }

puts "======================================================="
puts " Ultimate Reply Guy Blueprint"
puts " Running at: http://localhost:#{PORT}"
puts " Landing:    http://localhost:#{PORT}/"
puts " Guide:      http://localhost:#{PORT}/guide.html"
puts " Resources:  http://localhost:#{PORT}/resources.html"
puts "======================================================="

server.start