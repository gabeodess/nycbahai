# NYC Baha'i

[ ![Codeship Status for gabeodess/nycbahai](https://codeship.com/projects/19ad6cd0-bed8-0133-6033-022ad975b6ca/status?branch=master)](https://codeship.com/projects/137036)

## Gettting Started

### Installing dependencies
```
bundle install
```
### Symlink the pre-commit hook to enforce code standards
`ln -s ../../pre-commit.sh .git/hooks/pre-commit`

### Create and seed the database
```
rake db:setup
```
### Add environment variables
Create a .env file in the root of your project and add any environment variables to it:
```
cp .env-example .env
```
### Start the server
```
foreman start
```
### Start the console
```
foreman run rails c
