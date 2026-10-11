# Plan: subagent directions

Approved scope: document GPT 6.1 Sol as lead/worker, GPT 6 Luna as explorer,
and Claude Opus 5.5 as reviewer. Link the directions from AGENTS.md.

## Steps and verification

1. Inspect existing instructions and documentation. Verify the new directions
   preserve approval, role separation, file ownership, and reporting rules.
   Status: complete; AGENTS.md inspected and no existing SUBAGENTS.md found.
2. Back up AGENTS.md, create SUBAGENTS.md, and add its reference under section 3.
   Verify the backup matches the original and only the approved reference is
   added to AGENTS.md. Status: complete; original backed up at
   /tmp/opencode/fedora-home-manager-AGENTS-before-subagents.md and the diff
   confirms exactly one added reference.
3. Obtain a read-only review and inspect the final documents. Verify role names,
   delegation contracts, reporting format, and consistency with AGENTS.md.
   Run a whitespace check. Status: complete; read-only review found no
   consistency issues, lead read the documents and verified the AGENTS.md diff,
   and whitespace checks passed for all three documents. Runtime tests were
   not run because this change only adds documentation.

## Constraints

- Model assignments are starting defaults, not verified capability rankings.
- These documents do not configure OpenCode model routing.
- Existing unrelated work must be preserved.
- Two failed attempts on a step require stopping and re-planning.

## Follow-up: writable global OpenCode setup

Approved: deploy shared rules and model-specific agents globally using Home
Manager out-of-store symlinks into this checkout. Preserve existing OpenCode
JSON and unrelated work. Previous plan backed up in /tmp/opencode.

1. Inspect Home Manager/OpenCode setup and model IDs. Verify existing destination
   conflicts and choose explicit global instruction loading. Status: complete;
   no global rules/agents exist, model IDs confirmed with `opencode models`.
2. Back up files before edits; update shared rules and add four agent definitions.
   Verify lesson routing, model IDs, read-only roles, and delegation via review.
   Status: complete; backed up existing files, reviewed the definitions, and
   allowed read-only agents to access shared instructions outside projects.
3. Add six out-of-store Home Manager links. Verify Nix evaluation/build, link
   targets, and OpenCode agent loading. Activate only the OpenCode links rather
   than switching unrelated desktop configuration. Status: complete;
   activation derivation evaluates successfully. Review caught missing external
   read access; fixed before deployment.

   Smoke-test attempt 1: `opencode run --agent explore` falls back to the
   primary agent because explore is subagent-only. Shared read was rejected:
   OpenCode checks external directory wildcards, not individual file patterns.
   Corrected directory permission patterns and will test through build's Task
   delegation instead. If the next attempt fails, stop and re-plan.

   Smoke-test attempt 2: build also rejected the shared instruction read after
   directory permission changes. STOPPED per two-failure rule. Six symlink
   derivations built successfully and deployed without a full desktop switch;
   all resolve to writable checkout files. OpenCode debug loaded all four
   intended models and confirmed explorer/reviewer edit/bash/task tools denied.
   Full Home Manager activation build/switch not run; derivation evaluation and
   six targeted builds passed. No successful Luna/Opus inference is verified.

## Re-plan after runtime blocker (approved)

1. Inspect resolved build permissions and the installed OpenCode external-path
   matching behavior in a fresh process; determine why the allow rules failed.
   Verify the actual denied path and rule ordering before another change.
2. Apply a minimal proven permission fix or restart the relevant OpenCode
   service if configuration caching is the cause. Preserve read-only tools.
3. Repeat the same build-to-explore/review smoke test and inspect session
   metadata for actual model IDs. Do not label runtime routing verified until
   the instruction reads and both child tasks complete successfully.

Diagnosis: fresh debug resolves built-in build rather than our override. All
six live links are dangling: their unrooted targeted Nix-store outputs are
missing. Noninteractive run rejects any requested permission; it does not
override the configured external-directory allow rules. Repair deployment with
direct checkout symlinks now; normal Home Manager activation will root its
managed out-of-store symlink outputs. Back up existing link mappings before
replacement, verify effective rules, then rerun the same delegation test.

Resolution: backed up mappings in /tmp/opencode/global-links-before-repair.txt
and replaced all six live links with direct checkout links. All targets exist
and are writable. Fresh debug confirmed all four models, shared read access,
and explorer/reviewer editing, shell, and delegation denial.

The identical build-to-explore/review smoke test passed outside this repository.
Exported session metadata verified each actual agent/model and completed shared
instruction read:
- build: ses_ee4cb8b04ffeKnykRsI7YuPNRB, github-copilot/gpt-6.1-sol
- explore: ses_ee4cb3168ffe1zHPmp5uTx4b1W, github-copilot/gpt-6-luna
- review: ses_ee4cb314cffeQv00icyFrZJ1E1, github-copilot/claude-opus-5.5

Re-plan steps 1–3 complete. General worker inference was not part of this smoke
test; its loaded model configuration was verified. Full Home Manager switch
remains unrun; the approved targeted deployment is active. Restart the running
OpenCode session to pick up these definitions.

The checkout path must remain /home/jesper/git/fedora-home-manager. Do not put
existing OpenCode credentials in this repository. Two failures on a step mean
stop, record evidence, and re-plan. Restart OpenCode after deployment.

## Follow-up: Luna implementation worker (approved 2026-10-08)

Scope: set general to github-copilot/gpt-6-luna and synchronize SUBAGENTS.md.
Keep Sol as build lead, Luna as explore, Opus as review, and all permissions
unchanged. No unrelated configuration changes or Home Manager switch.

1. Inspect live configuration and applicable instructions; back up general.md,
   SUBAGENTS.md, and PLAN.md. Proof: clean initial git status, working global
   links, current general resolves to Sol, and backup comparisons pass.
   Status: complete; backups are /tmp/opencode/{general,SUBAGENTS,PLAN}-before-luna-20261008.md.
2. Change only general's model and matching role/model descriptions.
   Proof: inspect diff and compare unchanged permissions and other model routes.
   Status: complete; only general's model and SUBAGENTS.md's two matching
   descriptions changed. Agent permissions and other routes are untouched.
3. Verify fresh resolved configuration; run a build-to-general smoke task that
   implements and tests a tiny Python helper only in a new /tmp/opencode sandbox.
   Proof: inspect implementation/test output and exported child session metadata
   showing actual general inference on github-copilot/gpt-6-luna. Obtain read-only
   independent review and run git diff --check. No runtime claim from defaults.
   Status: complete; fresh debug resolves general to github-copilot/gpt-6-luna.
   Second smoke attempt passed; lead read both sandbox files and independently
   reran all 5 tests successfully. Exported child session
   ses_ee465af53ffes3GOEeuBpTHlC1 proves actual general/github-copilot/gpt-6-luna
   assistant use. This verifies routing, not comparative implementation quality.
   Independent review found no routing mismatch; backup access was denied for
   reviewer, so lead compared general against its backup and confirmed only the
   model changed. Review session ses_ee466d723ffe3Z0twDBEVeZOxW export confirms
   actual review/github-copilot/claude-opus-5.5 use. Original plan sections remain
   historical; this approved follow-up supersedes their worker assignment.
   git diff --check passed. No Home Manager switch or broader tests were run.

   Smoke attempt 1 stopped before delegation: build tried instruction discovery
   in /tmp and /, outside approved directory access; noninteractive CLI rejected
   those glob calls. Shared instruction reads succeeded. Retry with explicit
   applicable instruction paths and no parent-directory globbing; no permission
   changes. If this second attempt fails, stop and re-plan.

Quit and restart OpenCode after this change; the current session remains cached.

## Follow-up: global-only instruction discovery (approved 2026-10-09)

Scope: stop agent-requested project/ancestor instruction searches. Use only
/home/jesper/.config/opencode/AGENTS.md and SUBAGENTS.md in all four agents.
Preserve model routes, permissions, existing uncommitted work, and historical
plan entries. Do not change OpenCode's built-in project instruction loader.

1. Inspect all agent prompts, shared rules, and live deployment links; back up
   all edited files. Proof: identify discovery wording and confirm live links
   resolve to this checkout. Status: complete; all four agents request project
   instructions, and all six live links resolve to these source files. Backups
   are /tmp/opencode/*-before-global-only-20261009.md.
2. Replace discovery wording with the two exact global paths; synchronize shared
   delegation/lesson rules and record the user's correction under Lessons.
   Proof: inspect diffs, verify no project instruction discovery remains in
   active rules, and compare unchanged frontmatter against backups.
   Status: complete; all six active instruction sources now specify global-only
   discovery, and lesson routing is centralized. Existing Luna model changes
   are preserved.
3. Obtain independent read-only review and verify live file contents plus
   whitespace. Proof: review report, exact-path assertions, unchanged model and
   permission checks, and git diff --check. If feasible, run a fresh-session
   smoke test and inspect actual tool calls; otherwise explicitly report that
   runtime behavior is unverified. No Home Manager switch is needed.
   Status: complete; independent read-only review found no blocking issues.
   Backup diffs confirm unchanged frontmatter/models/permissions, all six live
   files match their sources, and git diff --check passed. Fresh CLI build
   session ses_edf483f76ffeGv11znDJMkm9M9 in /tmp/opencode completed startup
   loading with exactly two Read calls to the global paths and no Glob calls.
   This verifies the observed lead behavior, not a guarantee for every model
   or project. No fresh work-repo or child-agent smoke tests were run; review's
   actual provider/model use was unverified. No full Home Manager tests/switch.

OpenCode's documented automatic loading of existing local AGENTS.md/CLAUDE.md
is separate from model-issued Glob calls; this bounded prompt change does not
disable that loader. Two failures on a step mean stop and re-plan. Restart
OpenCode after these configuration-time prompt changes.
