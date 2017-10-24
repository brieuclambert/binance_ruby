require 'httparty'
require 'json'

class Binance
  include HTTParty
  base_uri 'https://www.binance.com/api'

  def initialize(api_key=nil, api_secret=nil, options={})
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

end

















