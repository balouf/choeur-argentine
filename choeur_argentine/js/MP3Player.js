/**
 * MP3Player.js - MP3 player with time-stretch using Tone.js GrainPlayer
 * Allows tempo change without pitch shift
 */

// Player states (same as MIDI player for consistency)
export const PlayerState = {
  STOPPED: 'stopped',
  PLAYING: 'playing',
  PAUSED: 'paused',
  LOADING: 'loading'
};

/**
 * MP3 Player class using Tone.js for time-stretch
 */
export class MP3Player {
  constructor(options = {}) {
    this.state = PlayerState.STOPPED;
    this.url = null;

    // Playback state
    this.currentTime = 0;
    this.duration = 0;
    this.tempo = 1.0;
    this.volume = 1.0;
    this.loopEnabled = false;

    // Tone.js components
    this.player = null;
    this.gainNode = null;

    // Update interval
    this.updateInterval = null;
    this.startTime = 0;
    this.pausedAt = 0;

    // Event listeners
    this.listeners = new Map();

    // Options
    this.options = {
      grainSize: options.grainSize ?? 0.1,
      overlap: options.overlap ?? 0.05,
      ...options
    };

    // Track if Tone.js is available
    this.isToneAvailable = typeof Tone !== 'undefined';
  }

  /**
   * Check if Tone.js is loaded
   */
  checkTone() {
    if (!this.isToneAvailable) {
      throw new Error('Tone.js is required for MP3 time-stretch. Please include Tone.js in your page.');
    }
  }

  /**
   * Load an MP3 file
   */
  async load(url) {
    this.checkTone();

    this.state = PlayerState.LOADING;
    this.url = url;
    this.emit('statechange', this.state);

    try {
      // Cleanup previous player
      this.dispose();

      // Start Tone.js context if needed
      await Tone.start();

      // Create GrainPlayer for time-stretch without pitch change
      this.player = new Tone.GrainPlayer({
        url: url,
        grainSize: this.options.grainSize,
        overlap: this.options.overlap,
        loop: false,
        onload: () => {
          this.duration = this.player.buffer.duration;
          this.state = PlayerState.STOPPED;
          this.currentTime = 0;

          this.emit('loaded', { duration: this.duration });
          this.emit('statechange', this.state);
        }
      });

      // Create gain node for volume control
      this.gainNode = new Tone.Gain(this.volume);

      // Connect: player -> gain -> destination
      this.player.connect(this.gainNode);
      this.gainNode.toDestination();

      // Set initial playback rate
      this.player.playbackRate = this.tempo;

    } catch (error) {
      console.error('Failed to load MP3:', error);
      this.state = PlayerState.STOPPED;
      this.emit('error', error);
      throw error;
    }
  }

  /**
   * Start playback
   */
  play() {
    if (!this.player || this.state === PlayerState.PLAYING || this.state === PlayerState.LOADING) return;

    try {
      // Resume Tone context if suspended
      if (Tone.context.state === 'suspended') {
        Tone.context.resume();
      }

      // Start from current position
      const offset = this.currentTime;
      this.player.start(Tone.now(), offset);

      this.startTime = Tone.now();
      this.pausedAt = this.currentTime;

      this.state = PlayerState.PLAYING;
      this.emit('statechange', this.state);
      this.emit('play');

      // Start update interval
      this.startUpdateInterval();

    } catch (error) {
      console.error('Failed to play:', error);
      this.emit('error', error);
    }
  }

  /**
   * Pause playback
   */
  pause() {
    if (this.state !== PlayerState.PLAYING) return;

    try {
      this.player.stop();

      // Calculate current position
      const elapsed = (Tone.now() - this.startTime) * this.tempo;
      this.currentTime = this.pausedAt + elapsed;

      this.stopUpdateInterval();

      this.state = PlayerState.PAUSED;
      this.emit('statechange', this.state);
      this.emit('pause');

    } catch (error) {
      console.error('Failed to pause:', error);
      this.emit('error', error);
    }
  }

  /**
   * Stop playback and reset
   */
  stop() {
    if (!this.player) return;

    try {
      this.player.stop();
      this.stopUpdateInterval();

      this.currentTime = 0;
      this.pausedAt = 0;

      this.state = PlayerState.STOPPED;
      this.emit('statechange', this.state);
      this.emit('stop');
      this.emit('timeupdate', { currentTime: 0, duration: this.duration });

    } catch (error) {
      console.error('Failed to stop:', error);
      this.emit('error', error);
    }
  }

  /**
   * Toggle play/pause
   */
  togglePlay() {
    if (this.state === PlayerState.PLAYING) {
      this.pause();
    } else {
      this.play();
    }
  }

  /**
   * Seek to position (0-1 or seconds)
   */
  seek(position, isSeconds = false) {
    const targetTime = isSeconds ? position : position * this.duration;
    const wasPlaying = this.state === PlayerState.PLAYING;

    if (wasPlaying) {
      this.player.stop();
    }

    this.currentTime = Math.max(0, Math.min(targetTime, this.duration));
    this.pausedAt = this.currentTime;

    if (wasPlaying) {
      this.player.start(Tone.now(), this.currentTime);
      this.startTime = Tone.now();
    }

    this.emit('timeupdate', {
      currentTime: this.currentTime,
      duration: this.duration,
      progress: this.currentTime / this.duration
    });
  }

  /**
   * Set playback tempo (0.5 to 2.0 for stable time-stretch)
   */
  setTempo(value) {
    const oldTempo = this.tempo;
    this.tempo = Math.max(0.5, Math.min(2.0, value));

    if (this.player) {
      // If playing, recalculate position before changing rate
      if (this.state === PlayerState.PLAYING) {
        const elapsed = (Tone.now() - this.startTime) * oldTempo;
        this.currentTime = this.pausedAt + elapsed;
        this.pausedAt = this.currentTime;
        this.startTime = Tone.now();
      }

      this.player.playbackRate = this.tempo;
    }

    this.emit('tempochange', this.tempo);
  }

  /**
   * Set volume (0-1)
   */
  setVolume(value) {
    this.volume = Math.max(0, Math.min(1, value));

    if (this.gainNode) {
      this.gainNode.gain.rampTo(this.volume, 0.05);
    }

    this.emit('volumechange', this.volume);
  }

  /**
   * Toggle loop mode
   */
  toggleLoop() {
    this.loopEnabled = !this.loopEnabled;
    this.emit('loopchange', { enabled: this.loopEnabled });
  }

  /**
   * Start update interval for time tracking
   */
  startUpdateInterval() {
    this.stopUpdateInterval();

    this.updateInterval = setInterval(() => {
      if (this.state === PlayerState.PLAYING) {
        const elapsed = (Tone.now() - this.startTime) * this.tempo;
        this.currentTime = this.pausedAt + elapsed;

        // Check for end of track
        if (this.currentTime >= this.duration) {
          if (this.loopEnabled) {
            // Loop back to start
            this.player.stop();
            this.currentTime = 0;
            this.pausedAt = 0;
            this.player.start(Tone.now(), 0);
            this.startTime = Tone.now();
            this.emit('loop');
          } else {
            this.stop();
            this.emit('ended');
            return;
          }
        }

        this.emit('timeupdate', {
          currentTime: this.currentTime,
          duration: this.duration,
          progress: this.currentTime / this.duration
        });
      }
    }, 50); // Update every 50ms
  }

  /**
   * Stop update interval
   */
  stopUpdateInterval() {
    if (this.updateInterval) {
      clearInterval(this.updateInterval);
      this.updateInterval = null;
    }
  }

  /**
   * Format time as MM:SS
   */
  static formatTime(seconds) {
    const mins = Math.floor(seconds / 60);
    const secs = Math.floor(seconds % 60);
    return `${mins}:${secs.toString().padStart(2, '0')}`;
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
      try {
        callback(data);
      } catch (error) {
        console.error(`Error in ${event} listener:`, error);
      }
    }
  }

  /**
   * Cleanup
   */
  dispose() {
    this.stopUpdateInterval();

    if (this.player) {
      this.player.stop();
      this.player.dispose();
      this.player = null;
    }

    if (this.gainNode) {
      this.gainNode.dispose();
      this.gainNode = null;
    }

    this.state = PlayerState.STOPPED;
    this.currentTime = 0;
    this.duration = 0;
  }
}

/**
 * Fallback MP3 Player using standard HTML5 Audio
 * Used when Tone.js is not available (no time-stretch, only playback rate)
 */
export class FallbackMP3Player {
  constructor() {
    this.audio = null;
    this.state = PlayerState.STOPPED;
    this.loopEnabled = false;
    this.listeners = new Map();
  }

  async load(url) {
    this.state = PlayerState.LOADING;
    this.emit('statechange', this.state);

    return new Promise((resolve, reject) => {
      this.audio = new Audio(url);

      this.audio.addEventListener('loadedmetadata', () => {
        this.state = PlayerState.STOPPED;
        this.emit('loaded', { duration: this.audio.duration });
        this.emit('statechange', this.state);
        resolve();
      });

      this.audio.addEventListener('timeupdate', () => {
        this.emit('timeupdate', {
          currentTime: this.audio.currentTime,
          duration: this.audio.duration,
          progress: this.audio.currentTime / this.audio.duration
        });
      });

      this.audio.addEventListener('ended', () => {
        if (this.loopEnabled) {
          this.audio.currentTime = 0;
          this.audio.play();
          this.emit('loop');
        } else {
          this.state = PlayerState.STOPPED;
          this.emit('ended');
          this.emit('statechange', this.state);
        }
      });

      this.audio.addEventListener('error', (e) => {
        this.state = PlayerState.STOPPED;
        this.emit('error', e);
        reject(e);
      });

      this.audio.load();
    });
  }

  play() {
    if (!this.audio) return;
    this.audio.play();
    this.state = PlayerState.PLAYING;
    this.emit('statechange', this.state);
    this.emit('play');
  }

  pause() {
    if (!this.audio) return;
    this.audio.pause();
    this.state = PlayerState.PAUSED;
    this.emit('statechange', this.state);
    this.emit('pause');
  }

  stop() {
    if (!this.audio) return;
    this.audio.pause();
    this.audio.currentTime = 0;
    this.state = PlayerState.STOPPED;
    this.emit('statechange', this.state);
    this.emit('stop');
  }

  togglePlay() {
    if (this.state === PlayerState.PLAYING) {
      this.pause();
    } else {
      this.play();
    }
  }

  seek(position, isSeconds = false) {
    if (!this.audio) return;
    this.audio.currentTime = isSeconds ? position : position * this.audio.duration;
  }

  setTempo(value) {
    if (!this.audio) return;
    // Note: This changes pitch too (no time-stretch in fallback mode)
    this.audio.playbackRate = Math.max(0.5, Math.min(2.0, value));
    this.emit('tempochange', this.audio.playbackRate);
  }

  setVolume(value) {
    if (!this.audio) return;
    this.audio.volume = Math.max(0, Math.min(1, value));
    this.emit('volumechange', this.audio.volume);
  }

  toggleLoop() {
    this.loopEnabled = !this.loopEnabled;
    this.emit('loopchange', { enabled: this.loopEnabled });
  }

  get currentTime() {
    return this.audio ? this.audio.currentTime : 0;
  }

  get duration() {
    return this.audio ? this.audio.duration : 0;
  }

  static formatTime(seconds) {
    return MP3Player.formatTime(seconds);
  }

  on(event, callback) {
    if (!this.listeners.has(event)) {
      this.listeners.set(event, []);
    }
    this.listeners.get(event).push(callback);
  }

  off(event, callback) {
    if (!this.listeners.has(event)) return;
    const index = this.listeners.get(event).indexOf(callback);
    if (index > -1) {
      this.listeners.get(event).splice(index, 1);
    }
  }

  emit(event, data) {
    if (!this.listeners.has(event)) return;
    for (const callback of this.listeners.get(event)) {
      callback(data);
    }
  }

  dispose() {
    if (this.audio) {
      this.audio.pause();
      this.audio.src = '';
      this.audio = null;
    }
    this.state = PlayerState.STOPPED;
  }
}

/**
 * Factory function to create the appropriate MP3 player
 */
export function createMP3Player(options = {}) {
  if (typeof Tone !== 'undefined') {
    return new MP3Player(options);
  } else {
    console.warn('Tone.js not found. Using fallback player (tempo change will affect pitch).');
    return new FallbackMP3Player();
  }
}

export default MP3Player;
