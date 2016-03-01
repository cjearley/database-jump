# database-jump

## Overview

Python script to copy a row of values from SQLite3 to PostgreSQL. (This assumes you have already properly formatted your Postgres database.) Uses the psycopg2 and sqlite3 libraries.

## Motivation

We use the weewx software package to collect data from a Davis Vantage Pro2 Plus weather station on the roof of our science center once every ten minutes. Weewx saves the data to a SQLite database, but most of our other work is done in Postgres. We opted to move the data, and I wrote first a Perl and then a Python script to do it.

## Scripts

`oldDbJump.pl` was the Perl version of the script

`dbjump.py` is the current, Python version of the script

Both would need to be adjusted for their respective programming environments.

## Installation and Usage

Copy and run as you prefer to run Python. Specify all required information for both databases. Run manually, or set it to run (as we do) with cron.

## History

Before this version, the CS Department used a similar script written in Perl. I rewrote in Python for convenience and to start learning Python.

## Contributing

1. Fork.
2. Create branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'add new feature'`
4. Push to branch: `git push origin my-new-feature`
5. Submit a pull request.

## License

GNU v2 license. See full LICENSE.
