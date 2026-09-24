# Recovery Scenario Report

## What happened
A commit was merged into main that added an automatic cleanup function to
disk_monitor.sh, using rm -rf /tmp/* without any safety checks.

## How the problem was identified
While reviewing the script history using git log and git blame, the
unsafe cleanup function was identified as a potential risk: it could delete
temporary files belonging to other running processes without warning.

## How it was fixed
Instead of using git reset --hard, which would rewrite history and could
affect other branches or collaborators, the team used git revert to create
a new commit that safely undoes the unsafe change while preserving the full
development history.

## Lessons learned
This scenario highlights the importance of thorough code review for scripts
that perform destructive file operations, and demonstrates why revert
(not reset) is the safe way to fix problems that are already in shared history.
