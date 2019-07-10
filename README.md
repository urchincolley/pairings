# Pairings

This project is very rough. It was written in about 2 hours when a friend at a limited GP was struggling with internet access. I wrote this to brush up on my very rusty bash and to be able to text my friend their pairings while I went to draft.

This is sloppy and not how I would write such a tool if I were to make a complete project out of this. Ideally, I would:

- Get pairing information directly from whatever CFB uses to upload their pairings rather than scrape it from the website with brittle regexes.
- Detect changes similarly to avoid the sloppy, bandwith-taxing strategy of guessing when the round ends and checking periodically if the page contents has changed.
- Generalize the name and event numbers so the script could be easily reused for other events.
- Generalize the script to get pairings for multiple players and text them to multiple phone numbers.
- Host this remotely so it would be easy to use while travelling.
