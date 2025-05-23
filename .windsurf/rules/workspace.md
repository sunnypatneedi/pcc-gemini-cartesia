---
trigger: always_on
---

This workflow guides developers in building and shipping this application.
	1.	Prepare the Core Documents
Ensure docs/ contains PRD.md, implementation_plan.md, architecture.md, progress.md, best_practices.md, and revised_architecture.md, and initialize docs/progress.md with a single header before linking the repo to CI/CD pipelines.
	2.	Implementation Plan & Testing
Open docs/implementation_plan.md, break each milestone into numbered sub‑tasks, implement in small, testable units, define or update tests, run the full suite, debug failures, record date/time, sub‑task IDs, outcomes, and observations in docs/progress.md, then commit with descriptive messages.
	3.	Iterative Development
<agent_loop>
Read the next step from docs/implementation_plan.md; execute code or prompt the AI agent for that step; run tests and record results; update docs/progress.md with success/failure notes; update docs/architecture.md with any new components or modifications; commit and push changes; repeat until the plan is complete.
</agent_loop>
	4.	Feature Expansions
For each new feature, create docs/feature_<name>.md outlining purpose, user stories, technical approach, data flows, test cases, and success criteria; implement via the Agent Loop; on failures capture logs/screenshots and feed back into the loop for diagnosis.
	5.	Tool‑Use Rules
Only invoke external tools/APIs with explicit user approval; sanitize all inputs and validate AI‑agent outputs; rate‑limit and implement retries on errors; log every tool invocation in docs/tool_calls.md.
	6.	Large Refactoring & Modularity
Monitor component sizes and extract any >500 lines or multi‑responsibility modules into focused subcomponents; document rationale in docs/revised_architecture.md, adjust tests, update diagrams, and commit with clear messages.
	7.	Getting Unstuck
If blocked, revert to the last known good commit (git reset --hard <hash>); engage the AI assistant with focused prompts including error logs; consult experts and record advice in docs/notes.md.
	8.	Communication & Additional Tools
Use async background tasks (the “virtual computer”) for long‑running jobs, document them in docs/async_tasks.md, and provide status polling or hooks; integrate real‑time alerts via chat or dashboards; include a domain‑specialization stub (docs/domain_specialization_stub.md) for compliance schemas or regulatory tests.
	9.	Final Verification & Next Steps
Mark all steps complete in docs/progress.md; run full integration and smoke tests; conduct user‑acceptance reviews; tag and release candidate branches, then merge into main; optionally add or update docs/<industry>_requirements.md for industry‑specific compliance and tailored pipelines.