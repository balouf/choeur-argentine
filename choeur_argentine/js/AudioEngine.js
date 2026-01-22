/**
 * AudioEngine.js - Unified Web Audio API management
 * Handles audio context, effects chain, and WebAudioFont integration
 */

/**
 * Singleton AudioEngine class for managing Web Audio
 */
class AudioEngine {
  constructor() {
    if (AudioEngine.instance) {
      return AudioEngine.instance;
    }

    this.audioContext = null;
    this.player = null;
    this.masterGain = null;
    this.equalizer = null;
    this.reverberator = null;
    this.analyser = null;
    this.isInitialized = false;
    this.isResumed = false;

    // Event listeners
    this.listeners = new Map();

    AudioEngine.instance = this;
  }

  /**
   * Initialize the audio engine
   * Must be called after user interaction (click/touch)
   */
  async init() {
    if (this.isInitialized) return;

    try {
      // Create Audio Context
      const AudioContextClass = window.AudioContext || window.webkitAudioContext;
      this.audioContext = new AudioContextClass();

      // Create master gain node
      this.masterGain = this.audioContext.createGain();
      this.masterGain.gain.value = 1.0;

      // Create analyser for visualization
      this.analyser = this.audioContext.createAnalyser();
      this.analyser.fftSize = 2048;
      this.analyser.smoothingTimeConstant = 0.8;

      // Connect master gain to analyser, then to destination
      this.masterGain.connect(this.analyser);
      this.analyser.connect(this.audioContext.destination);

      // Initialize WebAudioFont player if available
      if (typeof WebAudioFontPlayer !== 'undefined') {
        this.player = new WebAudioFontPlayer();

        // Create equalizer and reverb
        this.equalizer = this.player.createChannel(this.audioContext);
        this.reverberator = this.player.createReverberator(this.audioContext);

        // Connect: equalizer -> reverb -> master
        this.equalizer.output.connect(this.reverberator.input);
        this.reverberator.output.connect(this.masterGain);

        // Set default EQ values
        this.setDefaultEQ();
      }

      this.isInitialized = true;
      this.emit('initialized');

      // Resume if suspended
      if (this.audioContext.state === 'suspended') {
        await this.resume();
      }

    } catch (error) {
      console.error('AudioEngine initialization failed:', error);
      this.emit('error', error);
      throw error;
    }
  }

  /**
   * Resume audio context (needed after user interaction)
   */
  async resume() {
    if (!this.audioContext) return;

    if (this.audioContext.state === 'suspended') {
      await this.audioContext.resume();
      this.isResumed = true;
      this.emit('resumed');
    }
  }

  /**
   * Suspend audio context
   */
  async suspend() {
    if (!this.audioContext) return;

    if (this.audioContext.state === 'running') {
      await this.audioContext.suspend();
      this.isResumed = false;
      this.emit('suspended');
    }
  }

  /**
   * Set master volume (0-1)
   */
  setMasterVolume(value) {
    if (this.masterGain) {
      this.masterGain.gain.setTargetAtTime(
        Math.max(0, Math.min(1, value)),
        this.audioContext.currentTime,
        0.01
      );
    }
  }

  /**
   * Get current time from audio context
   */
  get currentTime() {
    return this.audioContext ? this.audioContext.currentTime : 0;
  }

  /**
   * Get sample rate
   */
  get sampleRate() {
    return this.audioContext ? this.audioContext.sampleRate : 44100;
  }

  /**
   * Set default equalizer values
   */
  setDefaultEQ() {
    if (!this.equalizer) return;

    const bands = {
      band32: 2,
      band64: 2,
      band128: 1,
      band256: 0,
      band512: -1,
      band1k: 5,
      band2k: 4,
      band4k: 3,
      band8k: -2,
      band16k: 2
    };

    for (const [band, value] of Object.entries(bands)) {
      if (this.equalizer[band]) {
        this.equalizer[band].gain.setTargetAtTime(value, 0, 0.0001);
      }
    }
  }

  /**
   * Load an instrument from WebAudioFont
   */
  async loadInstrument(instrumentId) {
    if (!this.player || !this.audioContext) {
      throw new Error('AudioEngine not initialized');
    }

    return new Promise((resolve, reject) => {
      try {
        const info = this.player.loader.instrumentInfo(instrumentId);
        this.player.loader.startLoad(this.audioContext, info.url, info.variable);
        this.player.loader.waitLoad(() => {
          resolve(info);
        });
      } catch (error) {
        reject(error);
      }
    });
  }

  /**
   * Find instrument number by program
   */
  findInstrument(program) {
    if (!this.player) return 0;
    return this.player.loader.findInstrument(program);
  }

  /**
   * Get instrument info
   */
  getInstrumentInfo(instrumentId) {
    if (!this.player) return null;
    return this.player.loader.instrumentInfo(instrumentId);
  }

  /**
   * Get all available instruments
   */
  getInstrumentList() {
    if (!this.player) return [];

    const instruments = [];
    const keys = this.player.loader.instrumentKeys();
    let lastTitle = '';

    for (let i = 0; i < keys.length; i++) {
      const info = this.player.loader.instrumentInfo(i);
      if (info.title !== lastTitle) {
        instruments.push({ id: i, title: info.title });
        lastTitle = info.title;
      }
    }

    return instruments;
  }

  /**
   * Queue a note for playback
   */
  queueNote(instrument, when, pitch, duration, volume, slides = []) {
    if (!this.player || !this.audioContext || !this.equalizer) return;

    const instrumentVar = window[instrument.variable];
    if (!instrumentVar) {
      console.warn('Instrument not loaded:', instrument.variable);
      return;
    }

    this.player.queueWaveTable(
      this.audioContext,
      this.equalizer.input,
      instrumentVar,
      when,
      pitch,
      Math.min(duration, 3), // Cap at 3 seconds
      volume,
      slides
    );
  }

  /**
   * Cancel all queued notes
   */
  cancelQueue() {
    if (this.player && this.audioContext) {
      this.player.cancelQueue(this.audioContext);
    }
  }

  /**
   * Get analyser data for visualization
   */
  getAnalyserData() {
    if (!this.analyser) return null;

    const bufferLength = this.analyser.frequencyBinCount;
    const dataArray = new Uint8Array(bufferLength);
    this.analyser.getByteFrequencyData(dataArray);

    return { bufferLength, dataArray };
  }

  /**
   * Get time domain data for waveform visualization
   */
  getWaveformData() {
    if (!this.analyser) return null;

    const bufferLength = this.analyser.frequencyBinCount;
    const dataArray = new Uint8Array(bufferLength);
    this.analyser.getByteTimeDomainData(dataArray);

    return { bufferLength, dataArray };
  }

  /**
   * Create a gain node
   */
  createGain() {
    if (!this.audioContext) return null;
    return this.audioContext.createGain();
  }

  /**
   * Decode audio data from ArrayBuffer
   */
  async decodeAudioData(arrayBuffer) {
    if (!this.audioContext) {
      throw new Error('AudioEngine not initialized');
    }
    return this.audioContext.decodeAudioData(arrayBuffer);
  }

  /**
   * Event emitter methods
   */
  on(event, callback) {
    if (!this.listeners.has(event)) {
      this.listeners.set(event, []);
    }
    this.listeners.get(event).push(callback);
  }

  off(event, callback) {
    if (!this.listeners.has(event)) return;
    const callbacks = this.listeners.get(event);
    const index = callbacks.indexOf(callback);
    if (index > -1) {
      callbacks.splice(index, 1);
    }
  }

  emit(event, data) {
    if (!this.listeners.has(event)) return;
    for (const callback of this.listeners.get(event)) {
      callback(data);
    }
  }

  /**
   * Cleanup
   */
  dispose() {
    this.cancelQueue();

    if (this.audioContext) {
      this.audioContext.close();
    }

    this.audioContext = null;
    this.player = null;
    this.masterGain = null;
    this.equalizer = null;
    this.reverberator = null;
    this.analyser = null;
    this.isInitialized = false;
    this.isResumed = false;
    this.listeners.clear();

    AudioEngine.instance = null;
  }
}

// Singleton instance
AudioEngine.instance = null;

/**
 * Get the singleton AudioEngine instance
 */
export function getAudioEngine() {
  return new AudioEngine();
}

export default AudioEngine;
