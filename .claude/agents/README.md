# Claude Code Custom Agents

This directory contains custom subagents for Claude Code. Subagents are specialized AI assistants that can be automatically invoked to handle specific types of tasks.

## Available Agents

### context-engineering-documentation-review
**File:** `context-engineering-documentation-review.md`

**Purpose:** Reviews documentation structure using Anthropic's context engineering principles to optimize for AI agent effectiveness.

**When to use:**
- Reviewing documentation structure for a new project
- Auditing existing docs for AI agent usability
- Planning documentation improvements
- Analyzing why AI agents struggle with a codebase
- Implementing context engineering best practices

**Automatic invocation:** Claude will automatically use this agent when you ask about documentation reviews, context engineering analysis, or AI agent optimization.

**Manual invocation:** You can explicitly request this agent by saying:
- "Use the context-engineering-documentation-review agent to analyze our docs"
- "Review our documentation structure for AI agent effectiveness"

**Output:** Creates a comprehensive review report in `records/reviews/context-engineering-review-<date>.md`

**Model:** Sonnet (for detailed analysis)

**Tools:** Read, Grep, Glob, WebSearch, Write, Edit

## How Agents Work

### Automatic Delegation (2025)
Claude Code now features automatic delegation. When you make a request, Claude intelligently routes tasks to the appropriate specialist agent based on the task description, just like how it automatically selects the right tools.

You no longer need to remember which agent to use or when - Claude handles this automatically.

### Agent Structure

Agents are defined as Markdown files with YAML frontmatter:

```markdown
---
name: agent-name
description: When this agent should be invoked
tools: Tool1, Tool2, Tool3
model: sonnet  # or haiku, opus
---

System prompt for the agent goes here...
```

### Creating New Agents

1. Create a new `.md` file in `.claude/agents/`
2. Add YAML frontmatter with name, description, tools, model
3. Write the system prompt below the frontmatter
4. Update this README with agent details
5. Commit and push

**Best practices:**
- Give agents single, clear responsibilities
- Write descriptive invocation triggers in the description
- Start with Claude-generated agents and iterate
- Use Haiku 4.5 for lightweight/frequent tasks
- Use Sonnet for complex analysis tasks

## Agent Lifecycle

### Project-level agents (this directory)
- Shared across all team members
- Version controlled with the project
- Recommended for project-specific workflows

### User-level agents
- Located in `~/.claude/agents/`
- Personal agents not shared with team
- Useful for individual preferences

## References

- [Claude Code Subagents Documentation](https://docs.claude.com/en/docs/claude-code/sub-agents)
- [Anthropic Context Engineering Guide](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)
- Project Documentation: `/studio/`

## Contributing

When adding new agents:
1. Follow the naming convention: `kebab-case-name.md`
2. Include comprehensive description for auto-invocation
3. Document the agent in this README
4. Test the agent before committing
5. Follow project documentation standards

---

For more information about Claude Code and custom agents, see `/studio/50-tooling/claude/README.md`
