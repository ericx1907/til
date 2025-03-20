We have a branch sctructure like this:
<pre>
               main,orig/main
                |
A---B---C---F---G
         \
          D---E
              |
            feature,orig/featu
</pre>
In order to introduce the patches developed in feature branch into main branch:
```
git rebase main feature
```
<pre>
              main,orig/main
                |
A---B---C---F---G---D---E
         \              |
          D---E       feature
              |
            orig/feature
</pre>
Now to delete the remote tracking feature branch:
```
git push --delete origin feature
```
<pre>
              main,orig/main
                |
A---B---C---F---G---D---E
                        |
                      feature
</pre>
Do a fast-forward merge:
```
git switch main
git merge feature
```
<pre>
              orig/main
                |
A---B---C---F---G---D---E
                        |
                      main,feature
</pre>
Push the change to remote and delete the feature branch which is no long needed:
```
git push
git branch -d feature
```
<pre>


A---B---C---F---G---D---E
                        |
                      main,orig/main
</pre>
