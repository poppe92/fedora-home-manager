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
