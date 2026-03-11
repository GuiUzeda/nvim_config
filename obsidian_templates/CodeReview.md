---
id: {{id}}
aliases:
  - {{title}}
tags:
  - code-review
date: {{date}}
pr_author:
pr_link:
ticket_link:
---

# {{title}}

> "There is no such thing as perfect code — there is only better code."

## ⏱️ Review Constraints

| Metric     | Guideline                         | Status |
| :--------- | :-------------------------------- | :----- |
| **Scope**  | Under 400 Lines of Code (LoC)     |        |
| **Pace**   | Under 500 LoC per hour            |        |
| **Timing** | Prioritize overlapping time zones |        |

---

## 🛫 Pre-Flight Checks

- [ ] CI/CD pipeline and pre-commit hooks (linting, automated tests) have passed.
- [ ] The author has self-reviewed and self-tested this code.
- [ ] The review size is manageable (if >400 lines, consider asking to split the PR).
- [ ] I have enough time to review this promptly (hours, not days). _If not, notify the author._

## ⚙️ Functionality & Logic

- [ ] **Purpose:** The code accomplishes the author’s intended purpose without unnecessary complexity.
- [ ] **Business Logic:** The implementation is correct and consistent with standard business logic.
- [ ] **Efficiency:** The code is scalable (e.g., handles larger datasets gracefully without O(n²) bottlenecks).
- [ ] **Edge Cases:** Missing data, unexpected values, and edge cases are handled properly.
- [ ] **Parallelism:** Parallel programming is safe (no race conditions, deadlocks; threads/processes joined).

## 🏗️ Architecture & Code Quality

- [ ] **DRY (Don't Repeat Yourself):** There is no duplicated code that could be abstracted and reused.
- [ ] **Modularity:** Functions/modules perform exactly one task (separation of concerns).
- [ ] **Reinvention:** The functionality doesn't duplicate an existing library or product code (unless intentional and commented).
- [ ] **Hardcoding:** No hard-coded values are present.

## 🛡️ Tests, Security, & Dependencies

- [ ] **Test Coverage:** New code includes readable tests that cover interesting/edge cases.
- [ ] **Test Impact:** The update does not lower overall test coverage.
- [ ] **Security:** The code does not introduce obvious vulnerabilities or expose the system to cyber attacks.
- [ ] **Dependencies:** No unnecessary compile-time or run-time dependencies were added.
- [ ] **TODOs:** There is no commented-out code. All TODOs have a tracked JIRA/GitLab issue number attached.

## 📖 Clarity & Documentation

- [ ] **Readability:** Variables and functions are named logically and consistently.
- [ ] **Flow:** I can grasp the concepts quickly without pausing frequently.
- [ ] **Comments:** Comments explain _why_ the code does something, rather than _what_ it does.
- [ ] **Documentation:** The README, CHANGELOG, or other project docs were updated if necessary.

---

## 🧠 Reviewer Self-Check (Culture & Tone)

> **Choose your battles:** Don't jump in front of every train. Criticizing every line destroys relationships.
> **Ask, don't tell:** Frame feedback as questions to guide the author (especially juniors) rather than solving it for them.
> **Mind the IKEA Effect:** Be constructive, maintain a positive tone, and remember to give praise for good work!
> **Trust but Verify:** Don't run the code yourself unless necessary; ask clarifying questions and trust the author's ownership.

- [ ] I have provided timely feedback and clearly separated _critical_ comments from _follow-up_ suggestions.
- [ ] My tone is professional, positive, and constructive.
