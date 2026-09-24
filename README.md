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

# Linux Server Management

## Project Purpose
This project was developed as part of a DevOps training assignment simulating
the role of a Junior DevOps Engineer. The goal is to build and manage a
Linux server administration toolkit using a professional Git workflow,
including branching, code review, Pull Requests, conflict resolution, and
recovery from mistakes — practices used in real-world software teams.

The project provides a set of Bash scripts for common Linux server
administration tasks, along with documentation for installation,
configuration, and troubleshooting.

## Project Structure

\`\`\`
linux-server-management/
├── scripts/
│   ├── backup.sh              # Creates timestamped backup archives
│   ├── create_user.sh         # Creates a new user with a specified group
│   ├── log_rotate.sh          # Archives log files older than a given threshold
│   ├── disk_monitor.sh        # Monitors disk usage and alerts on high usage
│   └── healthcheck.sh         # Checks whether a given service is running
├── docs/
│   ├── installation.md            # How to install and run the scripts
│   ├── configuration.md           # Configuration details for each script
│   ├── troubleshooting.md         # Common issues and solutions
│   ├── merge-conflict-report.md   # Documentation of a resolved merge conflict
│   └── recovery-report.md         # Documentation of a recovery scenario
└── README.md
\`\`\`

## Development Workflow

The project was developed using a feature-branch workflow:

1. Each new feature or documentation change was developed in its own branch,
   created from main.
2. Changes were committed in small, meaningful steps.
3. Once a feature was complete, a Pull Request was opened against main.
4. Every Pull Request was reviewed before merging.
5. After approval, the branch was merged into main and deleted.

The main branch is protected: direct pushes are disabled, and all changes
must go through a reviewed Pull Request. This ensures main always contains
a stable, working version of the project.

## Branching Strategy

- `main` — always contains stable, reviewed, production-ready code.
- `feature/*` — used for developing new scripts or functionality
  (e.g. feature/backup-script, feature/disk-monitor).
- `docs/*` — used for documentation-only changes
  (e.g. docs/installation-guide).
- `fix/*` — used for bug fixes and corrections
  (e.g. fix/remove-test-line, fix/revert-unsafe-cleanup).

Branches are deleted after being merged to keep the repository clean.

## Contribution Process

1. Create a new branch from main with a descriptive name
   (e.g. feature/your-feature-name).
2. Make your changes and commit them with clear, descriptive messages.
3. Push the branch to the remote repository.
4. Open a Pull Request describing:
   - What was changed
   - Why it was changed
   - How it was tested
5. Request a review. At least one approval is required before merging.
6. Address any review feedback with additional commits.
7. Once approved, merge the Pull Request into main.

## Testing Process

All scripts were tested manually in an Ubuntu virtual machine (VirtualBox)
before being committed. Testing included:

- Normal usage: running each script with valid arguments and confirming
  expected output (e.g. backup archive created, user added, logs rotated).
- Edge cases: running scripts with missing or invalid arguments to verify
  proper error handling and usage messages.
- Permission checks: verifying that scripts requiring elevated privileges
  (e.g. create_user.sh) correctly detect and reject non-root execution.

Example test performed for backup.sh:
\`\`\`bash
./scripts/backup.sh ~/test-folder      # normal case
./scripts/backup.sh                    # missing argument case
./scripts/backup.sh /nonexistent/path  # invalid directory case
\`\`\`

## Troubleshooting Process

Common issues and their solutions are documented in
[docs/troubleshooting.md](docs/troubleshooting.md). In general, the process
followed for troubleshooting during development was:

1. Reproduce the issue in a controlled test environment.
2. Use git log, git blame, and git show to investigate when and how the
   issue was introduced.
3. Determine the safest fix — preferring git revert over git reset when
   the problematic change was already part of the shared history, in order to
   preserve project history.
4. Document the root cause and resolution for future reference (see
   [docs/recovery-report.md](docs/recovery-report.md) and
   [docs/merge-conflict-report.md](docs/merge-conflict-report.md)).

## Repository Investigation

The following Git commands were used throughout the project to investigate
and understand repository history:

- git log --oneline --graph --all — visualize branch and merge history
- git blame <file> — identify which commit introduced specific changes
- git show <commit> — inspect the full content of a specific commit
- git diff — compare changes between branches or commits
- git shortlog -sn — summarize contributions
