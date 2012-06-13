# Gekkonidae

## Description

A simple proxy that takes the target of a graphite link and returns the data in a format that Geckoboard can understand.

## Install

First you need to grab the bits.

        git clone https://github.com/involver/gekkonidae.git

Then install the gems via bundler.

        cd gekkonidae
        bundle install

Setup the configuration file.  You will want to specify the host for you graphite server, and set an API key.  The API key should be some random string, 20+ characters long.

        cp config/gekkonidae.yml.example config/gekkonidae.yml
        vi config/gekkonidae.yml

Then start thin.

        thin start -p 3000

## Usage

Gekkonidae creates a proxy that takes requests from Geckoboard, pulls the data from graphite, and then returns the data in a format that Geckoboard understands.

To create a URL for Geckoboard you need to take the "target=" value from a graphite graph (usually retrieved by looking at the URL of the graph).  Then create an URL for Geckoboard of the form below.

        http://gekkonidae.example.com:3000/number?target=default.broker_example_local.boottime&api_key=EXAMPLEKEY123

Currently implemented targets are number, linechart, and textstate.

## Development

Pull requests are welcome.

## Links

[[ Geckoboard API Documentation | http://docs.geckoboard.com/api/ ]]

## Notes

This project is not complete and does not implement all of Geckoboard's widgets.

## License

Please see the included license file.