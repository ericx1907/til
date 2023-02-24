# Deleting local and remote branch
---
When deleting local and remote branches there are two scenarios to be considered. First scenario is when the target branch is up to date with main branch:
<pre>
                             main
                               |
commit 1 <--- commit 2 <--- commit 3
                               |
                             test
</pre>
```
git switch main
git branch -d test
git push origin --delete test
```
After deletion the commit history will look like:
<pre>
                             main  
                               |  
commit 1 <--- commit 2 <--- commit 3
</pre>
Second scenario is when the target branch is not up to date with the main branch (with unmerged changed):
<pre>
               main  
                 |  
commit 1 <--- commit 2 <--- commit 3  
                               |  
                             test  
</pre>
To delete the `test` branch: 
```
git switch main
git branch -D test
# delete remote branch
git push origin --delete test
```  
After deletion the commit history will look like:
<pre>
               main  
                 |  
commit 1 <--- commit 2 <--- commit 3  
</pre>
The commit 3 is still in the repo. If we don't have the hash of commit 3 it will be permanently lost because git commit only has reference to its parents but not children. From the commit that main points to, you can only move backward, so there’s no way for you to reach the commits formerly pointed to by test.

To recover the commit 3:
```
git checkout <hash of commit 3>
git branch <branch name>
```
or if the hash of commit 3 is not remembered:
```
git reflog #get the hash of commit 3
git checkout <hash of commit 3>
git branch <branch name>
```

More detailed read: https://www.cloudbees.com/blog/git-delete-branch-how-to-for-both-local-and-remote
