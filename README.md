What I did:

1. rails new gameapp --database=mysql
2. Update .gitignore
3. git init ; git add -A ; git ci -m "Created dir"
4. Edit gemfile to use sqlite3 in dev/test

5. Create the users and profile thing

6. rails generate model Profile theme:integer karma:float
7. rails generate scaffold User username:string email:string password:digest is_temporary:boolean profile_id:number

8. git push to placenta -- to get the basics worked out...

9. rails test:
- fails :
```
ctionView::Template::Error: Webpacker can't find application.js in /Users/ericp/lab/rails/cable05/gameapp/public/packs-test/manifest.json. Possible causes:
```
9.1. 
```
I ended up finding a fix for my issue through this link: https://discuss.rubyonrails.org/t/pretty-astonishing/76850
```
