import type { Plugin } from "@opencode-ai/plugin";

export const FormatOnSavePlugin: Plugin = async ({ $ }) => {
  return {
    "tool.execute.after": async (input, _output) => {
      if (input.tool !== "edit" && input.tool !== "write") return;

      const filePath: string | undefined = input.args?.filePath;
      if (!filePath) return;

      if (filePath.endsWith(".lua")) {
        await $`stylua ${filePath}`.quiet().nothrow();
      } else if (filePath.endsWith(".ex") || filePath.endsWith(".exs")) {
        await $`mix format ${filePath}`.quiet().nothrow();
      }
    },
  };
};
