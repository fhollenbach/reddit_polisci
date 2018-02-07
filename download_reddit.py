
import praw
import time 
import numpy 
import pandas

r = praw.Reddit(client_id='7mGIoZ0ZPzUuGw',
                     client_secret=	'E3ATC9jPeHCRuFNbT4pjz7dFwXw',
                     user_agent='polsci_test by /u/politics_science')


submission_list = []
for submission in r.subreddit('nfl').hot(limit=10):
    submission_list.append(submission)
    print(submission.title)
    print(submission.score)  # Output: the submission's score
    print(submission.id)     # Output: the submission's ID
    print(submission.url)




all_comments_body = []
all_comments_author = []
all_comments_score = []
all_comments_time = []
all_comments_upvote = []

for sub in submission_list:
  sub.comments.replace_more(limit=None)
  for comment in sub.comments.list():
    all_comments_body.append(re.sub('[^A-Za-z0-9 ]+', '', comment.body))
    all_comments_author.append(comment.author)
    all_comments_score.append(comment.score)
    all_comments_time.append(time.gmtime(comment.created_utc))



output = pandas.DataFrame(
    {'author': all_comments_author,
     'body': all_comments_body,
     'time': all_comments_time,
     'score': all_comments_score
    })


output.to_csv('/Users/florianhollenbach/Dropbox/RedditData/test.csv', index=False, header=False)
print output



