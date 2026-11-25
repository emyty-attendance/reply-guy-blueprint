// Scroll reveal
const observer = new IntersectionObserver((entries) => {
  entries.forEach(e => { if (e.isIntersecting) e.target.classList.add('visible'); });
}, { threshold: 0.1 });

document.querySelectorAll('.reveal').forEach(el => observer.observe(el));

// Progress bar
window.addEventListener('scroll', () => {
  const bar = document.getElementById('progress-bar');
  if (!bar) return;
  const h = document.documentElement;
  const scrolled = (h.scrollTop / (h.scrollHeight - h.clientHeight)) * 100;
  bar.style.width = scrolled + '%';
});

// Toast
function showToast(msg, type = '') {
  const t = document.getElementById('toast');
  if (!t) return;
  t.textContent = msg;
  t.className = 'toast show ' + type;
  setTimeout(() => t.classList.remove('show'), 3000);
}

// Copy text
function copyText(text) {
  navigator.clipboard.writeText(text).then(() => {
    showToast('Copied to clipboard!', 'success');
  }).catch(() => {
    const ta = document.createElement('textarea');
    ta.value = text;
    document.body.appendChild(ta);
    ta.select();
    document.execCommand('copy');
    document.body.removeChild(ta);
    showToast('Copied to clipboard!', 'success');
  });
}

// Payment method switch
let selectedCoin = 'ETH';
const wallets = {
  ETH: '0x66f145b690b7E43650b8EC4825D08085f0A6AF45',
  BTC: 'bc1qw3ans56hlgag42lpd83l7yn3qu7peppdtt46j5',
  SOL: 'Dp5rGizHs9t7WTmnUyS1AqYLqavaXHL83ZNBBbRMrjSZ'
};

function selectCoin(coin) {
  selectedCoin = coin;
  document.querySelectorAll('.pay-method').forEach(el => el.classList.remove('active'));
  event.target.closest('.pay-method').classList.add('active');
  const walletEl = document.getElementById('wallet-address');
  if (walletEl) walletEl.textContent = wallets[coin];
}