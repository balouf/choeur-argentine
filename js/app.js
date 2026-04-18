/**
 * app.js - Main application entry point
 * Orchestrates the MIDI/MP3 players, mixer, and UI
 */

import { MIDIPlayer, PlayerState } from './MIDIPlayer.js';
import { createMP3Player } from './MP3Player.js';
import { Mixer } from './Mixer.js';
import { getAudioEngine } from './AudioEngine.js';

/**
 * Main Application class
 */
class App {
  constructor(tracks, options = {}) {
    this.tracks = tracks;
    this.currentTrackIndex = 0;
    this.currentPlayerType = 'midi'; // 'midi' or 'mp3'

    // Players
    this.midiPlayer = null;
    this.mp3Player = null;

    // Components
    this.mixer = null;

    // DOM elements
    this.elements = {};

    // Voice names for mixer labels
    this.voiceNames = options.voiceNames || [
      'Soprano', 'Alto', 'Tenor', 'Basse', 'Main droite', 'Main gauche'
    ];

    // Keyboard shortcuts enabled
    this.keyboardEnabled = true;

    // Bind methods
    this.handleKeyboard = this.handleKeyboard.bind(this);
  }

  /**
   * Initialize the application
   */
  async init() {
    // Cache DOM elements
    this.cacheElements();

    // Initialize audio engine (will be activated on first user interaction)
    const audioEngine = getAudioEngine();

    // Create MIDI player
    this.midiPlayer = new MIDIPlayer({
      voiceNames: this.voiceNames
    });

    // Create MP3 player
    this.mp3Player = createMP3Player();

    // Setup event listeners
    this.setupEventListeners();
    this.setupPlayerListeners();

    // Setup keyboard shortcuts
    document.addEventListener('keydown', this.handleKeyboard);

    // Render track selector
    this.renderTrackSelector();

    // Initialize mixer
    const mixerContainer = document.getElementById('mixer');
    if (mixerContainer) {
      this.mixer = new Mixer(mixerContainer, this.midiPlayer, {
        showVUMeters: false,
        showInstruments: true
      });
    }

    // Load first track
    if (this.tracks.length > 0) {
      await this.selectTrack(0);
    }

    console.log('App initialized');
  }

  /**
   * Cache DOM elements
   */
  cacheElements() {
    this.elements = {
      trackSelector: document.getElementById('track-selector'),
      playerTabs: document.querySelectorAll('.player-tab'),
      playBtn: document.getElementById('btn-play'),
      progressBar: document.getElementById('progress-bar'),
      progressFill: document.getElementById('progress-fill'),
      progressHandle: document.getElementById('progress-handle'),
      timeDisplay: document.getElementById('time-current'),
      durationDisplay: document.getElementById('time-duration'),
      tempoSlider: document.getElementById('tempo-slider'),
      tempoValue: document.getElementById('tempo-value'),
      volumeSlider: document.getElementById('volume-slider'),
      loopBtn: document.getElementById('btn-loop'),
      loopStartMarker: document.getElementById('loop-start'),
      loopEndMarker: document.getElementById('loop-end'),
      loopRegion: document.getElementById('loop-region'),
      downloads: document.getElementById('downloads'),
      loadingOverlay: document.getElementById('loading-overlay'),
      errorMessage: document.getElementById('error-message')
    };
  }

  /**
   * Setup UI event listeners
   */
  setupEventListeners() {
    // Track selector
    if (this.elements.trackSelector) {
      this.elements.trackSelector.addEventListener('change', (e) => {
        this.selectTrack(parseInt(e.target.value, 10));
      });
    }

    // Player type tabs
    this.elements.playerTabs.forEach(tab => {
      tab.addEventListener('click', () => {
        this.switchPlayerType(tab.dataset.player);
      });
    });

    // Play button
    if (this.elements.playBtn) {
      this.elements.playBtn.addEventListener('click', () => {
        this.togglePlay();
      });
    }

    // Progress bar
    if (this.elements.progressBar) {
      this.elements.progressBar.addEventListener('click', (e) => {
        this.seekFromEvent(e);
      });

      // Drag support
      let isDragging = false;
      this.elements.progressBar.addEventListener('mousedown', () => { isDragging = true; });
      document.addEventListener('mouseup', () => { isDragging = false; });
      document.addEventListener('mousemove', (e) => {
        if (isDragging) this.seekFromEvent(e);
      });

      // Touch support
      this.elements.progressBar.addEventListener('touchstart', (e) => {
        this.seekFromEvent(e.touches[0]);
      });
      this.elements.progressBar.addEventListener('touchmove', (e) => {
        e.preventDefault();
        this.seekFromEvent(e.touches[0]);
      });
    }

    // Tempo slider
    if (this.elements.tempoSlider) {
      this.elements.tempoSlider.addEventListener('input', (e) => {
        const tempo = parseFloat(e.target.value);
        this.setTempo(tempo);
      });
    }

    // Volume slider
    if (this.elements.volumeSlider) {
      this.elements.volumeSlider.addEventListener('input', (e) => {
        const volume = parseFloat(e.target.value) / 100;
        this.setMasterVolume(volume);
      });
    }

    // Loop button
    if (this.elements.loopBtn) {
      this.elements.loopBtn.addEventListener('click', () => {
        this.toggleLoop();
      });
    }
  }

  /**
   * Setup player event listeners
   */
  setupPlayerListeners() {
    // MIDI Player events
    this.midiPlayer.on('loaded', ({ duration }) => {
      this.updateDuration(duration);
      this.hideLoading();
      if (this.mixer) this.mixer.render();
    });

    this.midiPlayer.on('statechange', (state) => {
      this.updatePlayButton(state);
    });

    this.midiPlayer.on('timeupdate', ({ currentTime, duration }) => {
      this.updateProgress(currentTime, duration);
    });

    this.midiPlayer.on('tempochange', (tempo) => {
      this.updateTempoDisplay(tempo);
    });

    this.midiPlayer.on('loopchange', ({ enabled }) => {
      this.updateLoopButton(enabled);
    });

    this.midiPlayer.on('error', (error) => {
      this.showError(error.message);
    });

    // MP3 Player events
    this.mp3Player.on('loaded', ({ duration }) => {
      this.updateDuration(duration);
      this.hideLoading();
    });

    this.mp3Player.on('statechange', (state) => {
      this.updatePlayButton(state);
    });

    this.mp3Player.on('timeupdate', ({ currentTime, duration }) => {
      this.updateProgress(currentTime, duration);
    });

    this.mp3Player.on('tempochange', (tempo) => {
      this.updateTempoDisplay(tempo);
    });

    this.mp3Player.on('loopchange', ({ enabled }) => {
      this.updateLoopButton(enabled);
    });

    this.mp3Player.on('error', (error) => {
      this.showError(error.message);
    });
  }

  /**
   * Render track selector dropdown
   */
  renderTrackSelector() {
    if (!this.elements.trackSelector) return;

    this.elements.trackSelector.innerHTML = this.tracks.map((track, i) =>
      `<option value="${i}">${track.name}</option>`
    ).join('');
  }

  /**
   * Select a track
   */
  async selectTrack(index) {
    if (index < 0 || index >= this.tracks.length) return;

    // Stop current playback
    this.midiPlayer.stop();
    this.mp3Player.stop();

    this.currentTrackIndex = index;
    const track = this.tracks[index];

    // Update selector
    if (this.elements.trackSelector) {
      this.elements.trackSelector.value = index;
    }

    // Update voice names from track data
    if (track.voix && track.voix.length > 0) {
      this.midiPlayer.voiceNames = track.voix;
    }

    // Update downloads
    this.renderDownloads(track);

    // Load the appropriate player based on current type
    this.showLoading();

    try {
      const basePath = `${track.path}/${track.path}`;

      if (this.currentPlayerType === 'midi') {
        await this.midiPlayer.load(`${basePath}.midi`);
      } else {
        await this.mp3Player.load(`${basePath}.mp3`);
      }
    } catch (error) {
      this.showError(`Erreur de chargement: ${error.message}`);
    }
  }

  /**
   * Switch between MIDI and MP3 player
   */
  async switchPlayerType(type) {
    if (type === this.currentPlayerType) return;

    // Stop current player
    if (this.currentPlayerType === 'midi') {
      this.midiPlayer.stop();
    } else {
      this.mp3Player.stop();
    }

    this.currentPlayerType = type;

    // Update tabs UI
    this.elements.playerTabs.forEach(tab => {
      tab.classList.toggle('active', tab.dataset.player === type);
    });

    // Show/hide mixer (only for MIDI)
    const mixerContainer = document.getElementById('mixer');
    if (mixerContainer) {
      mixerContainer.style.display = type === 'midi' ? 'block' : 'none';
    }

    // Reload current track with new player
    await this.selectTrack(this.currentTrackIndex);
  }

  /**
   * Get current active player
   */
  get currentPlayer() {
    return this.currentPlayerType === 'midi' ? this.midiPlayer : this.mp3Player;
  }

  /**
   * Toggle play/pause
   */
  togglePlay() {
    this.currentPlayer.togglePlay();
  }

  /**
   * Seek from mouse/touch event
   */
  seekFromEvent(event) {
    if (!this.elements.progressBar) return;

    const rect = this.elements.progressBar.getBoundingClientRect();
    const x = (event.clientX || event.pageX) - rect.left;
    const progress = Math.max(0, Math.min(1, x / rect.width));

    this.currentPlayer.seek(progress);
  }

  /**
   * Set tempo
   */
  setTempo(tempo) {
    this.currentPlayer.setTempo(tempo);
  }

  /**
   * Set master volume
   */
  setMasterVolume(volume) {
    const audioEngine = getAudioEngine();
    audioEngine.setMasterVolume(volume);

    if (this.currentPlayerType === 'mp3') {
      this.mp3Player.setVolume(volume);
    }
  }

  /**
   * Toggle loop
   */
  toggleLoop() {
    this.currentPlayer.toggleLoop();
  }

  /**
   * Render downloads section
   */
  renderDownloads(track) {
    if (!this.elements.downloads) return;

    const basePath = `${track.path}/${track.path}`;

    let html = '<h3>Partitions</h3><ul>';

    // PDFs
    if (track.pdfs) {
      for (const pdf of track.pdfs) {
        html += `<li><a href="${basePath}${pdf.suffix}.pdf" target="_blank">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
            <polyline points="14 2 14 8 20 8"/>
          </svg>
          ${track.name} (${pdf.name})
        </a></li>`;
      }
    }

    html += '</ul><h3>MP3</h3><ul>';

    // MP3
    html += `<li><a href="${basePath}.mp3" target="_blank">
      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <path d="M9 18V5l12-2v13"/>
        <circle cx="6" cy="18" r="3"/>
        <circle cx="18" cy="16" r="3"/>
      </svg>
      ${track.name} (Complet)
    </a></li>`;

    html += '</ul>';

    this.elements.downloads.innerHTML = html;
  }

  /**
   * Update progress bar and time displays
   */
  updateProgress(currentTime, duration) {
    const progress = duration > 0 ? currentTime / duration : 0;

    if (this.elements.progressFill) {
      this.elements.progressFill.style.width = `${progress * 100}%`;
    }

    if (this.elements.progressHandle) {
      this.elements.progressHandle.style.left = `${progress * 100}%`;
    }

    if (this.elements.timeDisplay) {
      this.elements.timeDisplay.textContent = MIDIPlayer.formatTime(currentTime);
    }
  }

  /**
   * Update duration display
   */
  updateDuration(duration) {
    if (this.elements.durationDisplay) {
      this.elements.durationDisplay.textContent = MIDIPlayer.formatTime(duration);
    }
  }

  /**
   * Update play button state
   */
  updatePlayButton(state) {
    if (!this.elements.playBtn) return;

    const isPlaying = state === PlayerState.PLAYING;
    this.elements.playBtn.classList.toggle('playing', isPlaying);
    this.elements.playBtn.setAttribute('aria-label', isPlaying ? 'Pause' : 'Play');
  }

  /**
   * Update tempo display
   */
  updateTempoDisplay(tempo) {
    if (this.elements.tempoSlider) {
      this.elements.tempoSlider.value = tempo;
    }

    if (this.elements.tempoValue) {
      this.elements.tempoValue.textContent = `x${tempo.toFixed(2)}`;
    }
  }

  /**
   * Update loop button state
   */
  updateLoopButton(enabled) {
    if (!this.elements.loopBtn) return;
    this.elements.loopBtn.classList.toggle('active', enabled);
    this.elements.loopBtn.setAttribute('aria-pressed', enabled);
  }

  /**
   * Show loading overlay
   */
  showLoading() {
    if (this.elements.loadingOverlay) {
      this.elements.loadingOverlay.style.display = 'flex';
    }
  }

  /**
   * Hide loading overlay
   */
  hideLoading() {
    if (this.elements.loadingOverlay) {
      this.elements.loadingOverlay.style.display = 'none';
    }
  }

  /**
   * Show error message
   */
  showError(message) {
    this.hideLoading();
    if (this.elements.errorMessage) {
      this.elements.errorMessage.textContent = message;
      this.elements.errorMessage.style.display = 'block';
    }
    console.error(message);
  }

  /**
   * Handle keyboard shortcuts
   */
  handleKeyboard(e) {
    if (!this.keyboardEnabled) return;

    // Ignore if typing in an input
    if (e.target.tagName === 'INPUT' || e.target.tagName === 'SELECT' || e.target.tagName === 'TEXTAREA') {
      return;
    }

    switch (e.code) {
      case 'Space':
        e.preventDefault();
        this.togglePlay();
        break;

      case 'ArrowLeft':
        e.preventDefault();
        this.currentPlayer.seek(Math.max(0, this.currentPlayer.currentTime - 5), true);
        break;

      case 'ArrowRight':
        e.preventDefault();
        this.currentPlayer.seek(this.currentPlayer.currentTime + 5, true);
        break;

      case 'ArrowUp':
        e.preventDefault();
        this.setTempo(Math.min(2.0, this.currentPlayer.tempo + 0.05));
        break;

      case 'ArrowDown':
        e.preventDefault();
        this.setTempo(Math.max(0.25, this.currentPlayer.tempo - 0.05));
        break;

      case 'KeyM':
        // Mute first track (for quick testing)
        if (this.currentPlayerType === 'midi' && this.midiPlayer.tracks.length > 0) {
          this.midiPlayer.toggleMute(0);
        }
        break;

      case 'KeyL':
        this.toggleLoop();
        break;

      case 'Home':
        e.preventDefault();
        this.currentPlayer.seek(0);
        break;

      case 'End':
        e.preventDefault();
        this.currentPlayer.seek(1);
        break;
    }
  }

  /**
   * Cleanup
   */
  dispose() {
    document.removeEventListener('keydown', this.handleKeyboard);

    if (this.midiPlayer) this.midiPlayer.dispose();
    if (this.mp3Player) this.mp3Player.dispose();
    if (this.mixer) this.mixer.dispose();
  }
}

// Export for use
export { App };

// Auto-initialize if tracks data is available
document.addEventListener('DOMContentLoaded', () => {
  // Check if tracks data is defined (will be injected by template)
  if (typeof window.TRACKS !== 'undefined') {
    const app = new App(window.TRACKS);
    app.init().catch(console.error);

    // Expose app for debugging
    window.app = app;
  }
});

export default App;
