echo "Running pre-commit hook, to run with out do 'git commit -n'"

bin/rake ci:rubocop_changed
