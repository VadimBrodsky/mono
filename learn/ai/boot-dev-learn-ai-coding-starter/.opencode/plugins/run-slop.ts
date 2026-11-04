import { Plugin } from "@opencode/plugin";
import { spawn } from "node:child_process";
import { fileURLToPath } from "node:url";
import { dirname, resolve } from "node:path";

const projectRoot = resolve(dirname(fileURLToPath(import.meta.url)), "../..");

export default Plugin.define({
  id: "applymaxxing.run-slop",
  setup: async (ctx) => {
    await ctx.tool.transform((tools) => {
      tools.add({
        name: "run_slop",
        description: "Run a SlopLang file with Sloperator from the project root.",
        input: {
          type: "object",
          properties: {
            filePath: { type: "string", description: "Path to a SlopLang file, relative to the project root or absolute." },
          },
          required: ["filePath"],
          additionalProperties: false,
        },
        options: { codemode: false },
        execute: async (input) => {
          const { filePath } = input as { filePath: string };
          const targetPath = resolve(projectRoot, filePath);

          const result = await new Promise<{ stdout: string; stderr: string; exitCode: number }>((resolveResult) => {
            const child = spawn("uv", ["run", "--no-active", "sloperator.py", targetPath], {
              cwd: projectRoot,
              stdio: ["ignore", "pipe", "pipe"],
            });
            let stdout = "";
            let stderr = "";

            child.stdout.setEncoding("utf8").on("data", (chunk: string) => {
              stdout += chunk;
            });
            child.stderr.setEncoding("utf8").on("data", (chunk: string) => {
              stderr += chunk;
            });
            child.on("error", (error) => {
              resolveResult({ stdout, stderr: `${stderr}${error.message}`, exitCode: 1 });
            });
            child.on("close", (code) => {
              resolveResult({ stdout, stderr, exitCode: code ?? 1 });
            });
          });

          return { content: JSON.stringify(result) };
        },
      });
    });
  },
});
