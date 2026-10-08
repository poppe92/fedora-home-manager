# Subagent directions

## Provisional default roles

- **build — GPT 6.1 Sol primary lead:** plan, delegate, debug, verify, and integrate.
- **general — GPT 6.1 Sol worker subagent:** implement and test bounded assignments.
- **explore — GPT 6 Luna read-only subagent:** locate paths, trace behavior, identify reusable
  patterns, and inspect callers, tests, and evidence.
- **review — Claude Opus 5.5 read-only independent reviewer/design challenger:** assess
  correctness, assumptions, edge cases, and scope.

These are provisional workflow defaults, not verified model rankings. Evaluate
actual quality, latency, and cost. Do not spawn all three for trivial tasks.

## Approval and assignment contract

Inherited shared AGENTS.md rules and applicable project AGENTS.md rules apply
to every agent. Read /home/jesper/.config/opencode/SUBAGENTS.md and any applicable
project-specific SUBAGENTS.md; pass their relevant rules with the assignment.
The primary agent obtains user approval before work as required by AGENTS.md.
Subagents execute an already-approved, bounded
assignment; return to the lead for scope changes.

Every assignment specifies:
- Objective and done condition.
- Relevant context and explicitly passed relevant instructions.
- Permitted files and edit privileges (explorers and reviewers are read-only).
- Required verification and evidence.

The lead checks key claims before relying on reports and owns integration and
final verification. Parallelize only independent tasks; never run simultaneous
workers on overlapping files. Report blockers without expanding scope. After
two failed tries on one step, stop and return failure evidence for re-planning.

## Reports

Each subagent returns exactly five lines, distinct from the primary agent's
final report under AGENTS.md:
1. Result: outcome against the done condition.
2. Files: inspected or changed paths.
3. Evidence/checks: supporting evidence and verification run or not run.
4. Risks/blockers: unresolved issues, or none.
5. Next action: handoff or recommended follow-up.

Read-only reviewers report actionable findings with file/line, impact, and
evidence; they do not edit. A review with no findings is acceptable.
Include actual-use metadata (agent name and provider/model ID) in the
Evidence/checks line, verified from runtime metadata when available. If actual
use cannot be verified, say so; configured routing is not proof of actual use.

## Routing boundary

Explicit model routing is configured in `modules/opencode/agents/{build,general,explore,review}.md`
for deployment under ~/.config/opencode/agents/. Use these exact
agent names when delegating: explore for discovery, general for implementation,
and review for independent review. The configured provider/model IDs are
github-copilot/gpt-6.1-sol for build/general, github-copilot/gpt-6-luna for
explore, and github-copilot/claude-opus-5.5 for review. Do not claim this session
uses all requested models unless their actual use is verified.

AGENTS.md and SUBAGENTS.md at the repository root are the version-controlled
global sources; deployment links the global paths to them. Keep shared rules and general
lessons there rather than duplicating them in projects. Project-specific
instructions and lessons belong in the project's own instruction files.
