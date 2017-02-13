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

## Contributions
The contributions section of the application can only be accessed to permitted admin users.  To give an admin user permission you can use the following command in console:
    @admin_user.grant!(:contributions)

## Copy Production Database
    spring rake db:drop db:create && heroku pg:backups:capture -a nycbahai && rm latest.dump && heroku pg:backups:download -a nycbahai && pg_restore --verbose --clean --no-acl --no-owner -d nyc_bahai_development latest.dump && spring rake db:migrate
