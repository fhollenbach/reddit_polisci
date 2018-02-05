
import praw
r = praw.Reddit(client_id='7mGIoZ0ZPzUuGw',
                     client_secret=	'E3ATC9jPeHCRuFNbT4pjz7dFwXw',
                     user_agent='polsci_test by /u/politics_science')



subreddit = r.subreddit('nfl')
for comment in r.subreddit('nfl').stream.comments():
    print(comment)




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
