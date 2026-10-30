const STORAGE_KEY = "prompt-library-prompts";
const form = document.querySelector("#prompt-form");
const titleInput = document.querySelector("#prompt-title");
const contentInput = document.querySelector("#prompt-content");
const promptList = document.querySelector("#prompt-list");
const promptCount = document.querySelector("#prompt-count");

function loadPrompts() {
  try {
    const stored = JSON.parse(localStorage.getItem(STORAGE_KEY) || "[]");
    return Array.isArray(stored) ? stored : [];
  } catch {
    return [];
  }
}

let prompts = loadPrompts();

function savePrompts() {
  localStorage.setItem(STORAGE_KEY, JSON.stringify(prompts));
}

function renderPrompts() {
  promptCount.textContent = prompts.length;
  promptList.replaceChildren();

  if (prompts.length === 0) {
    const empty = document.createElement("div");
    empty.className = "empty-state";
    empty.innerHTML = '<div><span class="empty-icon">{ }</span><strong>Your library is empty</strong><p>Save a prompt to see it here.</p></div>';
    promptList.append(empty);
    return;
  }

  prompts.forEach((prompt) => {
    const card = document.createElement("article");
    card.className = "prompt-card";

    const top = document.createElement("div");
    top.className = "card-top";
    const title = document.createElement("h3");
    title.textContent = prompt.title;
    const remove = document.createElement("button");
    remove.className = "delete-button";
    remove.type = "button";
    remove.textContent = "Delete";
    remove.setAttribute("aria-label", `Delete ${prompt.title}`);
    remove.addEventListener("click", () => {
      prompts = prompts.filter((item) => item.id !== prompt.id);
      savePrompts();
      renderPrompts();
    });
    top.append(title, remove);

    const preview = document.createElement("p");
    preview.className = "preview";
    preview.textContent = prompt.content.trim().split(/\s+/).slice(0, 18).join(" ");
    card.append(top, preview);
    promptList.append(card);
  });
}

form.addEventListener("submit", (event) => {
  event.preventDefault();
  const title = titleInput.value.trim();
  const content = contentInput.value.trim();
  if (!title || !content) return;

  prompts.unshift({ id: crypto.randomUUID(), title, content });
  savePrompts();
  renderPrompts();
  form.reset();
  titleInput.focus();
});

renderPrompts();
