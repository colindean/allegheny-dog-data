Allegheny County Dog License database crawler
=============================================

This little program automates the export of CSV data from the
[Allegheny County Dog License Database](http://infoportal.alleghenycounty.us/dogdata/default.aspx) from [Western Pennsylvania Regional Data Center](http://www.wprdc.org).

This data is made available in CSV format, but the export is only per year. This script gets all of the years and combines them in an sqlite3 database.

## Contributing

Feel free to help me make this work.

## License

Public domain/CC0.

## History

This was done as a part of [National Day of Civic Hacking 2015 in Pittsburgh with OpenPGH](http://www.meetup.com/Open-Pittsburgh-our-Regions-Code-for-America-Brigade/events/221659747/).

## Interesting queries on the database

I'm not planning to provide much of an interface on top of this data, so I'm collecting some queries I've found interesting here:

### Breeds, descending by count and percentage of total

    SELECT breed, count(*) AS tally, 100*1.0*count(*)/(SELECT count(*) FROM dogs) AS pct FROM dogs GROUP BY breed ORDER BY tally DESC

### Breeds in ZIP codes, descending by count within ZIP

    SELECT breed, ownerZip, count(*) AS tally FROM dogs GROUP BY breed, ownerZip ORDER BY ownerZip, tally DESC

### Dogs in a ZIP code, ordered by ZIP code with the most licensed dogs

    SELECT ownerZip, count(*) AS tally FROM dogs GROUP BY ownerzip ORDER BY tally DESC

### Frequency of dog names

    SELECT name, count(*) AS tally FROM dogs GROUP BY name ORDER BY tally DESC
