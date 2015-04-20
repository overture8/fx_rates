Thought process
===============

These are just notes that I took before and during the development of the
library. There is no real order to the notes. They may or may not be of use
but I thought I'd include them anyway.


* Preprocessing stage to store in our own data store.
 - rake task in the library (for cron job)
 - makes use of the given strategy pattern for external API
 - rake task should be re-runnable

* Need a Strategy pattern to parse the external API XML
since "It’s likely we’ll use an alternative provider in production."

* Use Nokogiri to parse any xml.

* A relational database doesn't seem a good fit for this data. The data is seems
to suit a Key/Value storage for caching the API since the information is a set of 
self-contained 'documents' - could use [moneta](https://github.com/minad/moneta) 
to allow flexibility to change the Key/Value store.

* Configuration
  - Specify the external API strategy
  - Moneta key/value store to use

* Key/Value data:-
  - KEY: date
  - VALUE: JSON representation of currency code keys and rate values. (The 
strategy pattern will do the formatting from the external API to make sure 
this is the same format no matter what the service). This means new API's can
be swapped in by written a new strategy.

* How to calculate the currency conversion:-
  - (counter_curr / base_curr) * amount

* Convert result to 2 decimal places

* Exceptions for:
  - Date not found
  - Base currency not found
  - Counter currency not found
  - Invalid rate (should be a number)

* What code docmentation? http://tomdoc.org/?
