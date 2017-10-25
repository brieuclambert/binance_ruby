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
## General endpoints
#### Check server time
```ruby
binance.server_time #=> 1508971180817
```

# To-Do

* Detailled documentation
* Make it a gem
* Support of the socket api 
