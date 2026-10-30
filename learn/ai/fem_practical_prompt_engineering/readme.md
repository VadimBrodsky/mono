# FEM Practical Prompt Engineering

- [Course Site](https://sgoldfarb2.github.io/practical-prompt-engineering/)
- [Github Repo](https://github.com/sgoldfarb2-fem/practical-prompt-engineering-code-exercise)
- [Slides](https://cdn.master.dev/assets/courses/2025-10-24-prompt-engineering/prompt-engineering-slides.pdf)

Systemic approaches to working with LLMs.

## LLMs

- Pattern predictors that generate one token at a time.
- Token by token generation means no "planning ahead", they think only while typing.
- Works like autocomplete.
- LLMs are non-deterministic.

## LLMs - But How?

- Transformer architecture (2017) - ["Attention is all you need"](https://arxiv.org/abs/1706.03762).
- Attention mechanism: model learns which tokens matter for prediction.
- Scaling laws: 10x size become 100x more capable.

## Temperature and Top P

- Temperature controls randomness
  - Average is around 1
  - 0 = deterministic, 2 = chaotic
  - Lower is better for actual tasks, code, data extraction
  - Higher is better for creative work, brainstorming, varied solutions
- Top P
  - Alternative to temperature, but can be used with temperature
  - Cumulative probability cutoff
    - Limits which tokens the LLM can consider based on their likelihood. Unlike temperature which controls how often the most likely token is picked, Top P restricts the pool of available tokens.
    - For example Top P of 0.5 means tokens within the top 50% most likely options are considered.

## Token Limits and Context Windows

- Tokens are roughly 0.75 words, but not always.
  - [OpenAI Tokenizer](https://platform.openai.com/tokenizer)
- Cumulative tokens = input + output history.
- Context window - maximum tokens the model can "remember".
- When yo hit limits, oldest context drops off silently.
- Try to minimize what is put in the context to focus the LLM better, don't send the entire codebase as context.

## System Message

- The invisible "personality" behind every AI interaction.
- Set by the provider - OpenAI, Anthropic etc.
- Takes up part of your context window.
- Why the same model acts differently in different tools.
- They are private but not confidential.

## Standard Prompt

- Your direct questions or instruction to the AI.
- The simplest form of prompting - just ask.
- The foundation that everything else builds on.
- Quality of question directly relates to the quality of answer.

When using LLMs, you should ask full questions in complete sentences, similar to how you would ask a neighbor. This differs from search engines where people typically use summarized keywords.

To improve consistency by including instructions in your prompts that ask the AI to seek clarification when needed. For example: "If you have any other questions for me, make sure you ask those first before you start to implement this feature" or "If you don't understand what I am saying, make sure that you come and check with me first".

Standard prompts often produce code with extra features not requested (like export buttons or search bars), may contain bugs (like non-functional save buttons), and don't provide enough specificity to get exactly what you need. They require more iterative refinement to achieve the desired result.
