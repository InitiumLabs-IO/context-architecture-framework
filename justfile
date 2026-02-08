set quiet := true

# List all available commands
[private]
default:
    just --list --unsorted

# Format all markdown files
fmt:
    npx prettier --write '**/*.md'

# Check formatting without modifying files
fmt-check:
    npx prettier --check '**/*.md'
