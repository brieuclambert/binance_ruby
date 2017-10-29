# Binance Ruby
Ruby wrapper for Binance Exchange API

Official documentation : [https://www.binance.com/restapipub.html](https://www.binance.com/restapipub.html) 

This project is meant to help integrating Binance API into any ruby project. 

## Usage

#### Create a Binance client:

```ruby
API_KEY = 'abc**********123'
API_SECRET = 'abc**********123'

binance = Binance.new(API_KEY, API_SECRET)
```
#### Supported intervals
m -> minutes; h -> hours; d -> days; w -> weeks; M -> months

- 1m
- 3m
- 5m
- 15m
- 30m
- 1h
- 2h
- 4h
- 6h
- 8h
- 12h
- 1d
- 3d
- 1w
- 1M

## General endpoints
#### Check server time
```ruby
binance = Binance.new
binance.server_time #=> 1508971180817
```

#### Get the Order Book of a pair
```ruby
binance = Binance.new
binance.order_book('LTCBTC') 
#=> {"lastUpdateId"=>10188000, "bids"=>[["0.00948300", "1.68000000", []],... }
```

#### Get the Compressed/Aggregate trades list
```ruby
binance = Binance.new
binance.aggregate_trade_list 
#=> [{"a"=>1043985, "p"=>"0.00954900", "q"=>"0.05000000", "f"=>1066860, "l"=>1066860, "T"=>1509293550556, "m"=>false, "M"=>true}, ... }]
```

#### Get candles data
```ruby
binance = Binance.new
binance.candles('LTCBTC', '6h') 
#=> [[1499990400000, "0.01900000", "0.01932900", "0.01899600", "0.01908800", "127.59000000", 1500011999999, "2.43914420", 41, "26.02000000", "0.49679420", "4632.28818854"], ...]
```


# To-Do

* Detailled documentation
* Make it a gem
* Support of the socket api 
