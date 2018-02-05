import praw
r = praw.Reddit(user_agent='"polsci_test by /u/politics_science"')
r = praw.Reddit(client_id='7mGIoZ0ZPzUuGw',
                     client_secret=	'E3ATC9jPeHCRuFNbT4pjz7dFwXw',
                     user_agent='polsci_test by /u/politics_science')


for submission in r.subreddit('learnpython').hot(limit=10):
    print(submission.title)



subreddit = r.subreddit('nfl')
for comment in r.subreddit('nfl').stream.comments():
    print(comment)
