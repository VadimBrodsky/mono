import './style.css'

const STORAGE_KEY = 'prompt-library-prompts'
const icon = (name, size = 18) => {
  const paths = {
    plus: '<path d="M12 5v14M5 12h14"/>',
    search: '<circle cx="11" cy="11" r="7"/><path d="m20 20-4-4"/>',
    trash: '<path d="M3 6h18M8 6V4h8v2m3 0-1 14H6L5 6m4 4v6m6-6v6"/>',
    spark: '<path d="m12 3 1.9 5.8L20 11l-6.1 2.2L12 19l-1.9-5.8L4 11l6.1-2.2L12 3ZM19 14l1.1 2.9L23 18l-2.9 1.1L19 22l-1.1-2.9L15 18l2.9-1.1L19 14Z"/>',
    copy: '<rect x="8" y="8" width="12" height="12" rx="2"/><path d="M16 8V5a2 2 0 0 0-2-2H5a2 2 0 0 0-2 2v9a2 2 0 0 0 2 2h3"/>',
  }
  return `<svg width="${size}" height="${size}" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">${paths[name]}</svg>`
}

let prompts = loadPrompts()
let query = ''

function loadPrompts() {
  try {
    const saved = JSON.parse(localStorage.getItem(STORAGE_KEY) || '[]')
    return Array.isArray(saved) ? saved : []
  } catch { return [] }
}

function persist() { localStorage.setItem(STORAGE_KEY, JSON.stringify(prompts)) }

document.querySelector('#app').innerHTML = `
  <header class="topbar">
    <a class="brand" href="#" aria-label="Prompt Library home"><span class="brand-mark">${icon('spark', 19)}</span><span>prompt<span class="brand-light">library</span></span></a>
    <span class="local-note"><span class="status-dot"></span>Private &amp; saved locally</span>
  </header>
  <main class="layout">
    <section class="intro">
      <div class="eyebrow">YOUR PERSONAL PROMPT SPACE</div>
      <h1>Good prompts,<br /><span>right at your fingertips.</span></h1>
      <p>Save the prompts you love. Find them whenever inspiration strikes.</p>
    </section>
    <section class="workspace" aria-label="Prompt library">
      <form class="composer" id="prompt-form">
        <div class="composer-head"><div><span class="section-kicker">ADD TO YOUR COLLECTION</span><h2>Create a prompt</h2></div><span class="step-badge">NEW</span></div>
        <label for="prompt-title">Title</label>
        <input id="prompt-title" name="title" type="text" maxlength="80" placeholder="e.g. Brainstorm newsletter ideas" required />
        <label for="prompt-content">Prompt</label>
        <textarea id="prompt-content" name="content" rows="5" placeholder="Write or paste your prompt here…" required></textarea>
        <div class="form-footer"><span class="form-hint">Make it useful. Make it yours.</span><button class="save-button" type="submit">${icon('plus', 17)} Save prompt</button></div>
      </form>
      <section class="library">
        <div class="library-heading"><div><span class="section-kicker">YOUR COLLECTION</span><h2>Saved prompts <span class="count" id="prompt-count">0</span></h2></div><label class="search-box">${icon('search', 17)}<input id="search" type="search" placeholder="Search prompts" aria-label="Search prompts" /></label></div>
        <div id="prompt-list"></div>
      </section>
    </section>
    <footer><span>${icon('spark', 15)} A little library for big ideas.</span><span>Your prompts never leave this device.</span></footer>
  </main>`

const list = document.querySelector('#prompt-list')
const escapeHtml = (text) => String(text).replace(/[&<>"']/g, (char) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' })[char])

function render() {
  const filtered = prompts.filter((prompt) => `${prompt.title} ${prompt.content}`.toLowerCase().includes(query.toLowerCase()))
  document.querySelector('#prompt-count').textContent = prompts.length
  if (!filtered.length) {
    const searching = query.length > 0
    list.innerHTML = `<div class="empty-state"><div class="empty-icon">${icon(searching ? 'search' : 'spark', 22)}</div><h3>${searching ? 'No matching prompts' : 'Your library is waiting'}</h3><p>${searching ? 'Try a different search term.' : 'Add your first prompt above and it’ll be ready whenever you need it.'}</p></div>`
    return
  }
  list.innerHTML = `<div class="prompt-grid">${filtered.map((prompt) => `<article class="prompt-card" data-id="${escapeHtml(prompt.id)}"><div class="card-top"><span class="card-label">PROMPT</span><button class="icon-button delete-button" type="button" aria-label="Delete ${escapeHtml(prompt.title)}" title="Delete prompt">${icon('trash', 17)}</button></div><h3>${escapeHtml(prompt.title)}</h3><p class="prompt-text">${escapeHtml(prompt.content)}</p><div class="card-bottom"><span>${new Date(prompt.createdAt).toLocaleDateString(undefined, { month: 'short', day: 'numeric', year: 'numeric' })}</span><button class="copy-button" type="button" aria-label="Copy prompt">${icon('copy', 15)} Copy</button></div></article>`).join('')}</div>`
  list.querySelectorAll('.delete-button').forEach((button) => button.addEventListener('click', () => {
    prompts = prompts.filter((prompt) => prompt.id !== button.closest('.prompt-card').dataset.id)
    persist(); render()
  }))
  list.querySelectorAll('.copy-button').forEach((button) => button.addEventListener('click', async () => {
    const prompt = prompts.find((item) => item.id === button.closest('.prompt-card').dataset.id)
    try {
      await navigator.clipboard.writeText(prompt.content)
      button.innerHTML = '✓ Copied'
      setTimeout(() => { if (button.isConnected) button.innerHTML = `${icon('copy', 15)} Copy` }, 1600)
    } catch { button.textContent = 'Select text to copy' }
  }))
}

document.querySelector('#prompt-form').addEventListener('submit', (event) => {
  event.preventDefault()
  const form = event.currentTarget
  const data = new FormData(form)
  prompts.unshift({ id: crypto.randomUUID(), title: data.get('title').trim(), content: data.get('content').trim(), createdAt: new Date().toISOString() })
  persist(); form.reset(); render()
})
document.querySelector('#search').addEventListener('input', (event) => { query = event.target.value; render() })
render()
