1. Plan before you touch code
• Long task: first tell me in 2-3 sentences what you think I'm after
• Start only after I say yes
• Write the steps to 'PLAN.md', each with how you'll prove it works
• Two failed tries on one step: stop, note what failed, re-plan
• Pausing mid-task: leave 'PLAN.md' so a new session can pick it up

2. Smallest change that works
• Stay inside this task. Don't break anything that already works
• Tradeoff? Weigh UX (users), DX (the next dev) and AX (the next agent)
• No new dependencies, renames or refactors nobody asked for
• Back up before deleting or overwriting anything

3. Split work across subagents
• Use only /home/jesper/.config/opencode/AGENTS.md and /home/jesper/.config/opencode/SUBAGENTS.md for instruction discovery. Read these exact paths, not globs; do not search projects or parent directories for instruction files. No per-repo instruction files are required. Pass relevant global rules to each subagent.
• Explorer reads, worker edits, reviewer only reports and never edits
• Each gets one job, a done condition and a 5-line report
• Parallel is fine. Two agents on the same file is not
• Check the key claim in a report before you build on it

4. Own the bug
• Reproduce it with my steps first. Can't reproduce it? Tell me what you need
• Fix the cause, then run the same steps again
• Never silence an error to make it go away

5. Verify before you say done
• Run the tests and read the output yourself
• UI: open it and try to break it: empty input, double submit, refresh
• Didn't run a check? Say so. An unrun check is not a pass
• Report in 2-3 lines: what you picked, what you gave up, and why

6. Write down every correction
• When I correct you, add a line under Lessons: "When X, do Y"
• All lessons: edit /home/jesper/git/fedora-home-manager/AGENTS.md under Lessons, the version-controlled global source. Include project context when needed; do not create or search for per-project AGENTS.md files.
• Same mistake twice: the lesson is unclear. Rewrite it
• Ask me before changing anything above Lessons

Lessons
Newest on top. Delete what no longer applies.
When loading OpenCode instructions for any repo, use only the exact AGENTS.md and SUBAGENTS.md paths under /home/jesper/.config/opencode; do not search the repo or its ancestors or require per-repo instruction files.
When advising on Fedora/CachyOS dual boot, preserve the user's intended work/gaming separation instead of assuming they want shared data storage.
