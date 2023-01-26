# Deleting local and remote branch
---
When deleting local and remote branches there are scenarios to be considered. First scenario is when the branch is up to date with main branch:

                             main  
                               |  
commit 1 <--- commit 2 <--- commit 3  
                               |  
                             test  
```bash
git switch main
git branch -d test
git push origin --delete test
```
After deletion the commit history will look like:

                             main  
                               |  
commit 1 <--- commit 2 <--- commit 3

Second scenario is when the branch is not up to date with the main branch (with unmerged changed):

               main  
                 |  
commit 1 <--- commit 2 <--- commit 3  
                               |  
                             test  

To delete the `test` branch: 
```bash
git switch main
git branch -D test
# delete remote branch
git push origin --delete test
```  
After deletion the commit history will look like:

               main  
                 |  
commit 1 <--- commit 2 <--- commit 3  

The commit 3 is still in the repo. If we don't have the hash of commit 3 it will be permanently lost because in git commit only has reference to its parents but not children. From the commit that main points to, you can only move backward, so there’s no way for you to reach the commits formerly pointed to by test.

To recover the commit 3:
```bash
git checkout <hash of commit 3>
git branch <branch name>
```
or if the hash of commit 3 is not remembered:
```bash
git reflog #get the hash of commit 3
git checkout <hash of commit 3
git branch <branch name>
```

More detailed read: https://www.cloudbees.com/blog/git-delete-branch-how-to-for-both-local-and-remote
