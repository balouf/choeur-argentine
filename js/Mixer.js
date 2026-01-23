/**
 * Mixer.js - Reusable mixer UI component
 * Handles volume sliders, mute/solo, and instrument selection
 */

/**
 * Mixer component class
 */
export class Mixer {
  constructor(container, player, options = {}) {
    this.container = typeof container === 'string'
      ? document.querySelector(container)
      : container;

    this.player = player;
    this.options = {
      showVUMeters: options.showVUMeters ?? true,
      showInstruments: options.showInstruments ?? true,
      orientation: options.orientation ?? 'vertical', // 'vertical' or 'horizontal'
      ...options
    };

    this.channelElements = [];
    this.vuAnimationFrame = null;

    // Bind methods
    this.handleVolumeChange = this.handleVolumeChange.bind(this);
    this.handleMuteClick = this.handleMuteClick.bind(this);
    this.handleSoloClick = this.handleSoloClick.bind(this);
    this.handleInstrumentChange = this.handleInstrumentChange.bind(this);
    this.updateVUMeters = this.updateVUMeters.bind(this);

    // Listen to player events
    this.setupPlayerListeners();
  }

  /**
   * Setup player event listeners
   */
  setupPlayerListeners() {
    this.player.on('tracksinitialized', () => this.render());
    this.player.on('instrumentsloaded', () => this.updateInstrumentSelects());
    this.player.on('trackvolumechange', ({ trackIndex, volume }) => {
      this.updateChannelVolume(trackIndex, volume);
    });
    this.player.on('trackmutechange', ({ trackIndex, muted }) => {
      this.updateChannelMute(trackIndex, muted);
    });
    this.player.on('tracksolochange', ({ trackIndex, solo }) => {
      this.updateChannelSolo(trackIndex, solo);
    });
    this.player.on('trackinstrumentchange', ({ trackIndex, instrumentInfo }) => {
      this.updateChannelInstrument(trackIndex, instrumentInfo);
    });
    this.player.on('play', () => this.startVUAnimation());
    this.player.on('stop', () => this.stopVUAnimation());
    this.player.on('pause', () => this.stopVUAnimation());
  }

  /**
   * Render the mixer
   */
  render() {
    if (!this.container) return;

    this.channelElements = [];

    this.container.innerHTML = `
      <div class="mixer-header">
        <h3>Mixer</h3>
        <div class="mixer-actions">
          ${this.renderPresetsButton()}
        </div>
      </div>
      <div class="mixer-tracks">
        ${this.player.tracks.map((track, i) => this.renderChannel(track, i)).join('')}
      </div>
    `;

    // Store channel elements and attach event listeners
    this.player.tracks.forEach((track, i) => {
      const channel = this.container.querySelector(`[data-track-index="${i}"]`);
      if (channel) {
        this.channelElements[i] = {
          element: channel,
          volumeSlider: channel.querySelector('.volume-slider'),
          volumeDisplay: channel.querySelector('.volume-display'),
          muteBtn: channel.querySelector('.btn-mute'),
          soloBtn: channel.querySelector('.btn-solo'),
          instrumentSelect: channel.querySelector('.instrument-select'),
          vuMeter: channel.querySelector('.vu-meter-fill')
        };

        this.attachChannelListeners(i);
      }
    });

    // Setup presets dropdown
    this.setupPresetsDropdown();
  }

  /**
   * Render a single channel
   */
  renderChannel(track, index) {
    const volumePercent = Math.round(track.volume * 100);

    return `
      <div class="track-channel ${track.muted ? 'muted' : ''} ${track.solo ? 'solo' : ''}"
           data-track-index="${index}">
        <div class="track-name" title="${track.name}">${track.name}</div>

        ${this.options.showVUMeters ? `
          <div class="vu-meter">
            <div class="vu-meter-fill" style="height: 0%"></div>
          </div>
        ` : ''}

        <input type="range"
               class="volume-slider volume-slider-vertical"
               min="0"
               max="100"
               value="${volumePercent}"
               aria-label="Volume for ${track.name}"
               orient="vertical">

        <div class="track-controls">
          <button class="btn-mute ${track.muted ? 'active' : ''}"
                  aria-label="Mute ${track.name}"
                  aria-pressed="${track.muted}">M</button>
          <button class="btn-solo ${track.solo ? 'active' : ''}"
                  aria-label="Solo ${track.name}"
                  aria-pressed="${track.solo}">S</button>
        </div>

        ${this.options.showInstruments ? `
          <select class="instrument-select"
                  aria-label="Instrument for ${track.name}">
            ${this.renderInstrumentOptions(track.instrumentId, index)}
          </select>
        ` : ''}

        <div class="volume-display">${volumePercent}%</div>
      </div>
    `;
  }

  /**
   * Render instrument select options
   */
  renderInstrumentOptions(selectedId, trackIndex) {
    const instruments = this.player.getInstruments();

    // If instruments not loaded yet, show placeholder with track name
    if (instruments.length === 0) {
      const trackName = trackIndex !== undefined ? this.player.tracks[trackIndex]?.name : 'Instrument';
      return `<option value="" disabled selected>${trackName} (cliquez Play)</option>`;
    }

    return instruments.map(inst =>
      `<option value="${inst.id}" ${inst.id === selectedId ? 'selected' : ''}>${inst.title}</option>`
    ).join('');
  }

  /**
   * Render presets button
   */
  renderPresetsButton() {
    return `
      <div class="presets-dropdown">
        <button class="btn btn-secondary btn-presets" aria-haspopup="true" aria-expanded="false">
          Presets
        </button>
        <div class="presets-menu" role="menu">
          <button role="menuitem" data-action="save">Sauvegarder preset</button>
          ${this.renderPresetsList()}
        </div>
      </div>
    `;
  }

  /**
   * Render saved presets list
   */
  renderPresetsList() {
    const presets = this.player.getPresets();
    const presetNames = Object.keys(presets);

    if (presetNames.length === 0) {
      return '<button role="menuitem" disabled>Aucun preset sauvegardé</button>';
    }

    return presetNames.map(name =>
      `<button role="menuitem" data-action="load" data-preset="${name}">${name}</button>`
    ).join('');
  }

  /**
   * Attach event listeners to a channel
   */
  attachChannelListeners(index) {
    const channel = this.channelElements[index];
    if (!channel) return;

    channel.volumeSlider.addEventListener('input', (e) => {
      this.handleVolumeChange(index, e.target.value / 100);
    });

    channel.muteBtn.addEventListener('click', () => {
      this.handleMuteClick(index);
    });

    channel.soloBtn.addEventListener('click', () => {
      this.handleSoloClick(index);
    });

    if (channel.instrumentSelect) {
      channel.instrumentSelect.addEventListener('change', (e) => {
        this.handleInstrumentChange(index, parseInt(e.target.value, 10));
      });
    }
  }

  /**
   * Setup presets dropdown functionality
   */
  setupPresetsDropdown() {
    const dropdown = this.container.querySelector('.presets-dropdown');
    if (!dropdown) return;

    const btn = dropdown.querySelector('.btn-presets');
    const menu = dropdown.querySelector('.presets-menu');

    btn.addEventListener('click', () => {
      const isOpen = menu.classList.toggle('open');
      btn.setAttribute('aria-expanded', isOpen);
    });

    // Close on outside click
    document.addEventListener('click', (e) => {
      if (!dropdown.contains(e.target)) {
        menu.classList.remove('open');
        btn.setAttribute('aria-expanded', 'false');
      }
    });

    // Handle menu actions
    menu.addEventListener('click', (e) => {
      const action = e.target.dataset.action;

      if (action === 'save') {
        const name = prompt('Nom du preset:');
        if (name) {
          this.player.savePreset(name);
          this.updatePresetsMenu();
        }
      } else if (action === 'load') {
        const preset = e.target.dataset.preset;
        this.player.loadPreset(preset);
      }

      menu.classList.remove('open');
      btn.setAttribute('aria-expanded', 'false');
    });
  }

  /**
   * Update presets menu
   */
  updatePresetsMenu() {
    const menu = this.container.querySelector('.presets-menu');
    if (!menu) return;

    menu.innerHTML = `
      <button role="menuitem" data-action="save">Sauvegarder preset</button>
      ${this.renderPresetsList()}
    `;
  }

  /**
   * Handle volume change
   */
  handleVolumeChange(index, volume) {
    this.player.setTrackVolume(index, volume);
  }

  /**
   * Handle mute button click
   */
  handleMuteClick(index) {
    this.player.toggleMute(index);
  }

  /**
   * Handle solo button click
   */
  handleSoloClick(index) {
    this.player.toggleSolo(index);
  }

  /**
   * Handle instrument change
   */
  handleInstrumentChange(index, instrumentId) {
    this.player.setTrackInstrument(index, instrumentId);
  }

  /**
   * Update channel volume display
   */
  updateChannelVolume(index, volume) {
    const channel = this.channelElements[index];
    if (!channel) return;

    const percent = Math.round(volume * 100);
    channel.volumeSlider.value = percent;
    channel.volumeDisplay.textContent = `${percent}%`;
  }

  /**
   * Update channel mute state
   */
  updateChannelMute(index, muted) {
    const channel = this.channelElements[index];
    if (!channel) return;

    channel.element.classList.toggle('muted', muted);
    channel.muteBtn.classList.toggle('active', muted);
    channel.muteBtn.setAttribute('aria-pressed', muted);
  }

  /**
   * Update channel solo state
   */
  updateChannelSolo(index, solo) {
    const channel = this.channelElements[index];
    if (!channel) return;

    channel.element.classList.toggle('solo', solo);
    channel.soloBtn.classList.toggle('active', solo);
    channel.soloBtn.setAttribute('aria-pressed', solo);
  }

  /**
   * Update channel instrument display
   */
  updateChannelInstrument(index, instrumentInfo) {
    const channel = this.channelElements[index];
    if (!channel || !channel.instrumentSelect) return;

    // Instrument select already updated via change event
  }

  /**
   * Update all instrument selects after instruments are loaded
   */
  updateInstrumentSelects() {
    this.channelElements.forEach((channel, index) => {
      if (!channel || !channel.instrumentSelect) return;

      const track = this.player.tracks[index];
      channel.instrumentSelect.innerHTML = this.renderInstrumentOptions(track.instrumentId, index);
    });
  }

  /**
   * Start VU meter animation
   */
  startVUAnimation() {
    if (!this.options.showVUMeters) return;
    this.updateVUMeters();
  }

  /**
   * Stop VU meter animation
   */
  stopVUAnimation() {
    if (this.vuAnimationFrame) {
      cancelAnimationFrame(this.vuAnimationFrame);
      this.vuAnimationFrame = null;
    }

    // Reset all VU meters
    this.channelElements.forEach(channel => {
      if (channel && channel.vuMeter) {
        channel.vuMeter.style.height = '0%';
      }
    });
  }

  /**
   * Update VU meters (animation frame)
   */
  updateVUMeters() {
    const audioEngine = this.player.audioEngine;
    const analyserData = audioEngine.getAnalyserData();

    if (analyserData) {
      // Simple level calculation from frequency data
      const { dataArray, bufferLength } = analyserData;
      const numTracks = this.channelElements.length;
      const bandWidth = Math.floor(bufferLength / numTracks);

      this.channelElements.forEach((channel, i) => {
        if (!channel || !channel.vuMeter) return;

        // Calculate average level for this track's frequency band
        let sum = 0;
        const start = i * bandWidth;
        const end = start + bandWidth;

        for (let j = start; j < end && j < bufferLength; j++) {
          sum += dataArray[j];
        }

        const average = sum / bandWidth;
        const level = Math.min(100, (average / 255) * 100 * 1.5);

        channel.vuMeter.style.height = `${level}%`;
      });
    }

    if (this.player.state === 'playing') {
      this.vuAnimationFrame = requestAnimationFrame(this.updateVUMeters);
    }
  }

  /**
   * Cleanup
   */
  dispose() {
    this.stopVUAnimation();
    this.channelElements = [];
    if (this.container) {
      this.container.innerHTML = '';
    }
  }
}

export default Mixer;
