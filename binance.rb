require 'httparty'
require 'json'
require 'date'
require "base64"
require 'openssl'

class Binance
  include HTTParty
  base_uri 'https://www.binance.com/api'

  def initialize(api_key, api_secret, options={})
    @api_key      = api_key
    @api_secret   = api_secret
    @base_uri     = options[:base_uri] ||= 'https://www.binance.com/api'
  end

  ###########################
  ###### Public Data ########
  ###########################

  def server_time
    response = get_public('time')
    response["serverTime"]
  end

  def order_book(pair)
    opts = {'symbol' => pair}
    response = get_public 'depth', opts
  end

  #Add parameters
  def aggregate_trade_list(pair)
    opts = {'symbol' => pair}
    response = get_public 'aggTrades', opts
  end

  def candles(pair, interval)
    opts = {'symbol' => pair, 'interval' => interval}
    response = get_public 'klines', opts
  end

  #interval list : 1m,3m,5m,15m,30m,1h,2h,4h,6h,8h,12h,1d,3d,1w,1M

  def ticker_day(pair)
    opts = {'symbol' => pair}
    response = get_public 'ticker/24hr', opts
  end

  def ticker_all
    response = get_public 'ticker/allPrices'
  end

  def ticker_all_order_book
    response = get_public '/ticker/allBookTickers'
  end

  def get_public(method, opts={})
    url = @base_uri + '/v1/' + method
    r = self.class.get(url, query: opts)
    resp = JSON.parse(r.body)
  end

  ###########################
  ###### Private Data #######
  ###########################

  def get_account(opts={})
    response = get_private '/account?', opts
  end

  # Mandatory parameters for order : symbol side type timeInForce quantity price

  def test_order(opts={})
    required_opts = %w{ symbol side type timeInForce quantity price }
      leftover = required_opts - opts.keys.map(&:to_s)
      if leftover.length > 0
        raise ArgumentError.new("Required options, not given. Input must include #{leftover}")
      end
    response = post_private '/order/test?', opts
  end

private

  ###########################
  ###### Create request #####
  ###########################

  def get_private(method, opts={})
    header = {"X-MBX-APIKEY":@api_key }
    r = self.class.get(set_request(method, opts), headers: header)
    resp = JSON.parse(r.body)
  end

  def post_private(method, opts={})
    header = {"X-MBX-APIKEY":@api_key }
    r = self.class.post(set_request(method, opts), headers: header)
    resp = JSON.parse(r.body)
  end

  def set_request(method, opts={})
    options = Array.new
    unless opts.empty?
      opts.each do |key, value|
        options << key + "=" + value
      end
      data = options.join('&') + '&timestamp=' + DateTime.now.strftime('%Q').to_s
    else
      data = '&timestamp=' + DateTime.now.strftime('%Q').to_s
    end

    digest = OpenSSL::Digest.new('sha256')
    signature = OpenSSL::HMAC.hexdigest(digest, @api_secret, data)

    url = @base_uri + '/v3' + method + data + "&signature=" + signature
    return url
  end
end
binance = Binance.new(api_key, api_secret)
# p binance.get_account('recvWindow' => '10000')
p binance.test_order('symbol' => 'LTCBTC',
                     'side' => 'BUY',
                     'type' => 'LIMIT',
                     'timeInForce' => 'GTC',
                     'quantity' => '1',
                     'price' => '0.001')














