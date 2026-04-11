import type { Plugin } from "@opencode-ai/plugin"

// Auto-activate caveman mode on session start.
// Sends /caveman full when session.created event fires.

export const CavemanPlugin: Plugin = async ({ client }) => {
	return {
		event: async ({ event }) => {
			if (event.type === "session.created") {
				// Send the caveman command to activate the skill
				await client.session.prompt({ prompt: "/caveman full" })
			}
		},
	}
}
