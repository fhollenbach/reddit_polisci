
import praw
import time 

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



submission.comments.replace_more(limit=None)

all_comments_body = []
all_comments_author = []
all_comments_score = []
all_comments_time = []

for sub in submission_list:
  sub.comments.replace_more(limit=None)
  for comment in sub.comments.list():
    all_comments_body.append(comment.body)
    all_comments_author.append(comment.author)
    all_comments_score.append(comment.score)
    all_comments_time.append()



for com in all_comments:

    for submission in subreddit.hot(limit=10):
    print(submission.title)  # Output: the submission's title
    

dick = []

subreddit = r.subreddit('nfl')
for comment in r.subreddit('nfl').stream.comments.hot(limit=10):
  dick.append(comment)







def getSubComments(comment, allComments, verbose=True):
  allComments.append(comment)
  if not hasattr(comment, "replies"):
    replies = comment.comments()
    if verbose: print("fetching (" + str(len(allComments)) + " comments fetched total)")
  else:
    replies = comment.replies
  for child in replies:
    getSubComments(child, allComments, verbose=verbose)


def getAll(r, submissionId, verbose=True):
  submission = r.submission(submissionId)
  comments = submission.comments
  commentsList = []
  for comment in comments:
    getSubComments(comment, commentsList, verbose=verbose)
  return commentsList

res = getAll(r, "6rjwo1")