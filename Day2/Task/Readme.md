
## Project Setup 
Install Git: Ensure Git is installed on your system. Verify with git --version.
Set Up Git: Configure your Git username and email:
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

Go to GitHub and create a new repository named website-project.
Clone the repository to your local machine:

```bash
git clone https://github.com/santoshPagire/website-project.git
```

Navigate to the project directory:

```bash
cd website-project
```

Create initial project structure:

```bash
mkdir src
touch src/index.html
echo "<!DOCTYPE html><html><head><title>My Website</title></head><body><h1>Welcome to my website!</h1></body></html>" > src/index.html
```
![alt text](<images/Screenshot from 2024-07-10 10-22-07.png>)

Commit and push the initial project structure:

```bash
git add .
git commit -m "Initial commit: Added project structure and index.html"
git push origin main
```
![alt text](<images/Screenshot from 2024-07-10 10-28-43.png>)

## Task 1

## Exercise 1: Branching and Basic Operations 
Create a New Branch:

```bash
git checkout -b feature/add-about-page
```

Create about.html:

```bash
touch src/about.html
echo "<!DOCTYPE html><html><head><title>About Us</title></head><body><h1>About Us</h1></body></html>" > src/about.html
```

Commit and push changes:

``` bash
git add src/about.html
git commit -m "Added about page"
git push origin feature/add-about-page
```
![alt text](<images/Screenshot from 2024-07-10 10-33-36.png>)

## Exercise 2: Merging and Handling Merge Conflicts 
Create Another Branch:
```bash
git checkout main
git checkout -b feature/update-homepage
```

Modify index.html:
```bash
echo "<p>Updated homepage content</p>" >> src/index.html
```

if above command not work then use single quote instead of double quote

Commit and push changes:
```bash
git add src/index.html
git commit -m "Updated homepage content"
git push origin feature/update-homepage
```
![alt text](<images/Screenshot from 2024-07-10 10-36-44.png>)

Create a Merge Conflict:
Modify index.html on the feature/add-about-page branch:

```bash
git checkout feature/add-about-page
echo "<p>Conflict content</p>" >> src/index.html
git add src/index.html
git commit -m "Added conflicting content to homepage"
git push origin feature/add-about-page
```
![alt text](<images/Screenshot from 2024-07-10 10-41-41.png>)

Merge and Resolve Conflict:
Attempt to merge feature/add-about-page into main:

```bash
git checkout main
git merge feature/add-about-page
```

Resolve the conflict in src/index.html, then:

```bash
git add src/index.html
git commit -m "Resolved merge conflict in homepage"
git push origin main
```
![alt text](<images/Screenshot from 2024-07-10 10-43-47.png>)

## Exercise 3: Rebasing 
Rebase a Branch:
Rebase feature/update-homepage onto main:

```bash
git checkout feature/update-homepage
git rebase main
```

Resolve any conflicts that arise during rebase.
Push the Rebased Branch:

```bash
git push -f origin feature/update-homepage
```
![alt text](<images/Screenshot from 2024-07-10 11-14-03.png>)

## Exercise 4: Pulling and Collaboration
Pull Changes from Remote:
Ensure the main branch is up-to-date:

```bash
git checkout main
git pull origin main
```

Simulate a Collaborator's Change:
Make a change on GitHub directly (e.g., edit index.html).
Pull the changes made by the collaborator:

```bash
git pull origin main
```
![alt text](<images/Screenshot from 2024-07-10 11-19-50.png>)

## Exercise 5: Versioning and Rollback 
Tagging a Version:
Tag the current commit as v1.0:

```bash
git tag -a v1.0 -m "Version 1.0: Initial release"
git push origin v1.0
```

Make a Change that Needs Reversion:
Modify index.html:

```bash
echo "<p>Incorrect update</p>" >> src/index.html
git add src/index.html
git commit -m "Incorrect update"
git push origin main
```

Revert to a Previous Version:
Use git revert to undo the last commit:

```bash
git revert HEAD
git push origin main
```
![alt text](<images/Screenshot from 2024-07-10 11-29-04.png>)

Alternatively, reset to a specific commit (use with caution):
sh
Copy code

```bash
git reset --hard v1.0
git push -f origin main
```
![alt text](<images/Screenshot from 2024-07-10 11-32-17.png>)

Extra Activities (10 minutes)
Stashing Changes:
Make some local changes without committing:

```bash
echo "<p>Uncommitted changes</p>" >> src/index.html
```

Stash the changes:

```bash
git stash
```

Apply the stashed changes:

```bash
git stash apply
```
![alt text](<images/Screenshot from 2024-07-10 11-30-26.png>)

Viewing Commit History:
Use git log to view commit history:

```bash
git log --oneline
```
![alt text](<images/Screenshot from 2024-07-10 11-31-09.png>)

Cherry-Picking Commits:
Create a new branch and cherry-pick a commit from another branch:

```bash
git checkout -b feature/cherry-pick
git cherry-pick <commit-hash>
git push origin feature/cherry-pick
```
![alt text](<images/Screenshot from 2024-07-10 11-37-03.png>)

Interactive Rebase:
Use interactive rebase to squash commits:

```bash
git checkout main
git rebase -i HEAD~3
```
![alt text](<images/Screenshot from 2024-07-10 11-37-18.png>)

## Task 2

## Create a GitHub Repository:
Go to GitHub and create a new repository named blogging-platform.
Clone the repository to your local machine:

```bash
git clone https://github.com/santoshPagire/blogging-platform.git
```

Initialize the Project:
Navigate to the project directory:

```bash
cd blogging-platform
```

Create initial project structure:

```bash
mkdir src
touch src/index.html
echo "<!DOCTYPE html><html><head><title>Blogging Platform</title></head><body><h1>Welcome to the Blogging Platform!</h1></body></html>" > src/index.html
```

Commit and push the initial project structure:

```bash
git add .
git commit -m "Initial commit: Added project structure and index.html"
git push origin main
```

![alt text](<images/Screenshot from 2024-07-10 11-48-25.png>)

## Exercise 1: Branching and Adding Features
Create a New Branch for Blog Post Feature:

```bash
git checkout -b feature/add-blog-post
```
Add a Blog Post Page:
Create blog.html:

```bash
touch src/blog.html
echo "<!DOCTYPE html><html><head><title>Blog Post</title></head><body><h1>My First Blog Post</h1></body></html>" > src/blog.html
```

Commit and push changes:

```bash
git add src/blog.html
git commit -m "Added blog post page"
git push origin feature/add-blog-post
```
![alt text](<images/Screenshot from 2024-07-10 11-49-41.png>)


## Exercise 2: Collaborating with Merging and Handling Merge Conflicts 
Create Another Branch for Author Info:

```bash
git checkout main
git checkout -b feature/add-author-info
```

Add Author Info to Blog Page:
Modify blog.html:

```bash
echo "<p>Author: John Doe</p>" >> src/blog.html
```

Commit and push changes:

```bash
git add src/blog.html
git commit -m "Added author info to blog post"
git push origin feature/add-author-info
```
![alt text](<images/Screenshot from 2024-07-10 11-50-31.png>)

Create a Merge Conflict:
Modify blog.html on the feature/add-blog-post branch:

```bash
git checkout feature/add-blog-post
echo "<p>Published on: July 10, 2024</p>" >> src/blog.html
git add src/blog.html
git commit -m "Added publish date to blog post"
git push origin feature/add-blog-post
```
![alt text](<images/Screenshot from 2024-07-10 11-52-09.png>)

Merge and Resolve Conflict:
Attempt to merge feature/add-blog-post into main:

```bash
git checkout main
git merge feature/add-blog-post
```
![alt text](<images/Screenshot from 2024-07-10 11-52-59.png>)

Resolve the conflict in src/blog.html, then:

```bash
git add src/blog.html
git commit -m "Resolved merge conflict in blog post"
git push origin main
```

![alt text](<images/Screenshot from 2024-07-10 11-54-24.png>)


## Exercise 3: Rebasing and Feature Enhancement
Rebase a Branch for Comment Feature:
Rebase feature/add-author-info onto main:

```bash
git checkout feature/add-author-info
git rebase main
```
![alt text](<images/Screenshot from 2024-07-10 12-00-31.png>)

Resolve any conflicts that arise during rebase.
Add Comment Section:
Modify blog.html to add a comment section:

```bash
echo "<h2>Comments</h2><p>No comments yet.</p>" >> src/blog.html
git add src/blog.html
git commit -m "Added comment section"
git push origin feature/add-author-info
```
![alt text](<images/Screenshot from 2024-07-10 12-01-59.png>)

## Exercise 4: Pulling and Simulating Collaboration 
Pull Changes from Remote:
Ensure the main branch is up-to-date:

```bash
git checkout main
git pull origin main
```

Simulate a Collaborator's Change:
Make a change on GitHub directly (e.g., edit blog.html to add a new comment).
Pull Collaborator's Changes:
Pull the changes made by the collaborator:

```bash
git pull origin main
```
![alt text](<images/Screenshot from 2024-07-10 12-04-35.png>)

## Exercise 5: Versioning and Rollback 
Tagging a Version:
Tag the current commit as v1.0:

```bash
git tag -a v1.0 -m "Version 1.0: Initial release"
git push origin v1.0
```
![alt text](<images/Screenshot from 2024-07-10 12-05-15.png>)

Make a Change that Needs Reversion:
Modify blog.html:

```bash
echo "<p>Incorrect comment</p>" >> src/blog.html
git add src/blog.html
git commit -m "Incorrect comment update"
git push origin main
```
![alt text](<images/Screenshot from 2024-07-10 12-06-46.png>)

Revert to a Previous Version:
Use git revert to undo the last commit:

```bash
git revert HEAD
git push origin main
```
![alt text](<images/Screenshot from 2024-07-10 12-07-27.png>)

Alternatively, reset to a specific commit (use with caution):

```bash
git reset --hard v1.0
git push -f origin main
```
![alt text](<images/Screenshot from 2024-07-10 12-08-11.png>)


## Extra Activities 
Stashing Changes:
Make some local changes without committing:

```bash
echo "<p>Uncommitted changes</p>" >> src/blog.html
```
Stash the changes:

```bash
git stash
```

Apply the stashed changes:

```bash
git stash apply
```

![alt text](<images/Screenshot from 2024-07-10 12-09-29.png>)

Viewing Commit History:
Use git log to view commit history:

```bash
git log --oneline
```
![alt text](<images/Screenshot from 2024-07-10 12-10-50.png>)

Cherry-Picking Commits:
Create a new branch and cherry-pick a commit from another branch:

```bash
git checkout -b feature/cherry-pick
git cherry-pick <commit-hash>
git push origin feature/cherry-pick
```
![alt text](<images/Screenshot from 2024-07-10 12-11-48.png>)

Interactive Rebase:
Use interactive rebase to squash commits:

```bash
git checkout main
git rebase -i HEAD~3
```
![alt text](<images/Screenshot from 2024-07-10 12-14-58.png>)