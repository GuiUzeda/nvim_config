---
id: {{id}}
aliases:
  - {{title}}
tags:
  - pull-request
date: {{date}}
ticket_link:
pr_link:
reviewers:
---

# {{title}}

> "Only submit complete, self-reviewed, and self-tested code for review."

## 🚀 Pre-Submission Basics

- [ ] **Size Limit:** The PR is under 400 Lines of Code (LoC). _(If larger, consider breaking it into smaller PRs)._
- [ ] **Pre-commit Checks:** Linting, formatting, and local automated checks have passed.
- [ ] **CI/CD:** Pipeline checks are green (optional but highly recommended for confidence).
- [ ] **Self-Review:** I have read through my own diffs from top to bottom before requesting a review.

## 🧠 Context & Empathy for Reviewers

- [ ] **Context Provided:** I have added documentation, diagrams, or explanations for complex decisions in the PR description to make the review straightforward.
- [ ] **Time Zones:** I am mindful of my reviewers' working hours and have requested the review promptly so as not to block progress.
- [ ] **Focus Areas:** If certain parts are critical and others are minor/follow-ups, I have explicitly stated this to help the reviewer prioritize.

## ⚙️ Functionality & Logic

- [ ] **Purpose:** The code does exactly what the ticket requires—no "just in case" future-proofing complexity.
- [ ] **Edge Cases:** I have explicitly considered and handled missing data, unexpected values, and edge cases.
- [ ] **Consistency:** The solution aligns with the existing codebase and standard business logic.
- [ ] **Efficiency:** The code handles scale reasonably well (avoiding unnecessary O(n²) operations).

## 🏗️ Clean Code & Architecture

- [ ] **Modularity:** Functions/modules are broken down and handle a single concern.
- [ ] **DRY & Reuse:** I haven't duplicated existing logic or rebuilt functionality already provided by existing libraries.
- [ ] **No Hardcoding:** Magic numbers and hardcoded values have been extracted into constants or configs.
- [ ] **Clean up:** There is absolutely **no commented-out code** in this PR.
- [ ] **TODOs:** Any added `TODO` comments include an attached JIRA/GitLab issue number.

## 🛡️ Tests & Security

- [ ] **Test Coverage:** I have written tests covering the happy path, edge cases, and potential breaking points.
- [ ] **Overall Coverage:** This PR does not lower the project's overall test coverage.
- [ ] **Security:** I have considered potential vulnerabilities (e.g., exposing the system to cyber attacks).
- [ ] **Dependencies:** I have minimized adding new compile-time or run-time dependencies (and justified them if added).

## 📖 Clarity & Documentation

- [ ] **Readability:** Variable and function names are clear, sane, and consistent.
- [ ] **Comments:** My in-line comments explain _why_ a decision was made, rather than _what_ the code is doing.
- [ ] **Project Docs:** I have updated the `README`, `CHANGELOG`, or other relevant documentation to reflect these changes.
