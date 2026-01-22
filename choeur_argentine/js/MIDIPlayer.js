/**
 * MIDIPlayer.js - Advanced MIDI player with mixer, loop, and preset support
 */

import { MIDIParser } from './MIDIParser.js';
import { getAudioEngine } from './AudioEngine.js';

// Player states
export const PlayerState = {
  STOPPED: 'stopped',
  PLAYING: 'playing',
  PAUSED: 'paused',
  LOADING: 'loading'
};

/**
 * MIDI Player class
 */
export class MIDIPlayer {
  constructor(options = {}) {
    this.audioEngine = getAudioEngine();
    this.song = null;
    this.state = PlayerState.STOPPED;

    // Playback state
    this.currentTime = 0;
    this.duration = 0;
    this.tempo = 1.0;
    this.stepDuration = 44 / 1000; // ~44ms steps

    // Loop points (A-B)
    this.loopEnabled = false;
    this.loopStart = 0;
    this.loopEnd = 0;

    // Timing
    this.nextStepTime = 0;
    this.intervalId = null;

    // Track state
    this.tracks = [];
    this.voiceNames = options.voiceNames || [];
    this.instrumentsLoaded = false;

    // Event listeners
    this.listeners = new Map();

    // Presets storage key
    this.presetsKey = 'midiPlayerPresets';
  }

  /**
   * Load a MIDI file from URL
   * Note: Audio engine initialization is deferred until play() to avoid
   * AudioContext restrictions before user interaction
   */
  async load(url) {
    this.state = PlayerState.LOADING;
    this.emit('statechange', this.state);

    try {
      // Fetch MIDI file
      const response = await fetch(url);
      if (!response.ok) {
        throw new Error(`Failed to load MIDI file: ${response.status}`);
      }

      const arrayBuffer = await response.arrayBuffer();

      // Parse MIDI file (doesn't require AudioContext)
      const parser = new MIDIParser(arrayBuffer);
      this.song = parser.parseSong();
      this.duration = this.song.duration;

      // Prepare track metadata without loading instruments yet
      this.prepareTrackMetadata();

      this.state = PlayerState.STOPPED;
      this.currentTime = 0;
      this.instrumentsLoaded = false;

      this.emit('loaded', {
        duration: this.duration,
        tracks: this.tracks
      });
      this.emit('statechange', this.state);

    } catch (error) {
      console.error('Failed to load MIDI:', error);
      this.state = PlayerState.STOPPED;
      this.emit('error', error);
      throw error;
    }
  }

  /**
   * Prepare track metadata without loading instruments
   */
  prepareTrackMetadata() {
    this.tracks = [];

    for (let i = 0; i < this.song.tracks.length; i++) {
      const songTrack = this.song.tracks[i];

      // Determine default volume: 15% for brass/voice tracks, 10% for others
      // Brass instruments are MIDI programs 56-63 (Trumpet, Trombone, Tuba, etc.)
      const isBrass = songTrack.program >= 56 && songTrack.program <= 63;
      const defaultVolume = isBrass ? 0.15 : 0.10;

      this.tracks.push({
        index: i,
        name: this.voiceNames[i] || `Track ${i + 1}`,
        muted: false,
        solo: false,
        volume: defaultVolume,
        instrumentId: null,
        instrumentInfo: null,
        program: songTrack.program
      });
    }

    this.emit('tracksinitialized', this.tracks);
  }

  /**
   * Load instruments for all tracks (called on first play)
   */
  async loadInstruments() {
    if (this.instrumentsLoaded) return;

    // Initialize audio engine if needed
    if (!this.audioEngine.isInitialized) {
      await this.audioEngine.init();
    }

    // Load instrument for each track
    for (let i = 0; i < this.tracks.length; i++) {
      const track = this.tracks[i];
      const songTrack = this.song.tracks[i];

      const instrumentId = this.audioEngine.findInstrument(songTrack.program);
      const info = await this.audioEngine.loadInstrument(instrumentId);

      track.instrumentId = instrumentId;
      track.instrumentInfo = info;
    }

    this.instrumentsLoaded = true;
    this.emit('instrumentsloaded', this.tracks);
  }

  /**
   * Start playback
   */
  async play() {
    if (!this.song || this.state === PlayerState.PLAYING) return;

    // Load instruments on first play (requires user interaction for AudioContext)
    if (!this.instrumentsLoaded) {
      this.state = PlayerState.LOADING;
      this.emit('statechange', this.state);

      try {
        await this.loadInstruments();
      } catch (error) {
        console.error('Failed to load instruments:', error);
        this.state = PlayerState.STOPPED;
        this.emit('statechange', this.state);
        this.emit('error', error);
        return;
      }
    }

    this.audioEngine.resume();
    this.nextStepTime = this.audioEngine.currentTime;

    this.intervalId = setInterval(() => this.tick(), 40);

    this.state = PlayerState.PLAYING;
    this.emit('statechange', this.state);
    this.emit('play');
  }

  /**
   * Pause playback
   */
  pause() {
    if (this.state !== PlayerState.PLAYING) return;

    clearInterval(this.intervalId);
    this.intervalId = null;
    this.audioEngine.cancelQueue();

    this.state = PlayerState.PAUSED;
    this.emit('statechange', this.state);
    this.emit('pause');
  }

  /**
   * Stop playback and reset to beginning
   */
  stop() {
    clearInterval(this.intervalId);
    this.intervalId = null;
    this.audioEngine.cancelQueue();

    this.currentTime = 0;
    this.state = PlayerState.STOPPED;
    this.emit('statechange', this.state);
    this.emit('stop');
    this.emit('timeupdate', { currentTime: 0, duration: this.duration });
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

    this.audioEngine.cancelQueue();
    this.currentTime = Math.max(0, Math.min(targetTime, this.duration));

    this.emit('timeupdate', {
      currentTime: this.currentTime,
      duration: this.duration
    });
  }

  /**
   * Set playback tempo (0.25 to 2.0)
   */
  setTempo(value) {
    this.tempo = Math.max(0.25, Math.min(2.0, value));
    this.emit('tempochange', this.tempo);
  }

  /**
   * Main playback tick
   */
  tick() {
    const now = this.audioEngine.currentTime;

    if (now > this.nextStepTime - this.stepDuration) {
      this.sendNotes(now);
      this.currentTime += this.stepDuration * this.tempo;
      this.nextStepTime += this.stepDuration;
    }

    // Emit time update
    this.emit('timeupdate', {
      currentTime: this.currentTime,
      duration: this.duration,
      progress: this.currentTime / this.duration
    });

    // Check for loop
    if (this.loopEnabled && this.currentTime >= this.loopEnd && this.loopEnd > this.loopStart) {
      this.audioEngine.cancelQueue();
      this.currentTime = this.loopStart;
      this.emit('loop');
    }

    // Check for end of song
    if (this.currentTime >= this.duration) {
      if (this.loopEnabled && this.loopEnd === 0) {
        // Loop entire song
        this.audioEngine.cancelQueue();
        this.currentTime = this.loopStart;
        this.emit('loop');
      } else {
        this.stop();
        this.emit('ended');
      }
    }
  }

  /**
   * Send notes to audio engine
   */
  sendNotes(now) {
    if (!this.song) return;

    const start = this.currentTime;
    const end = this.currentTime + this.stepDuration * this.tempo;

    // Check for any solo tracks
    const hasSolo = this.tracks.some(t => t.solo);

    for (let t = 0; t < this.song.tracks.length; t++) {
      const track = this.tracks[t];
      const songTrack = this.song.tracks[t];

      // Skip muted tracks or non-solo tracks when solo is active
      if (track.muted) continue;
      if (hasSolo && !track.solo) continue;

      for (const note of songTrack.notes) {
        if (note.when >= start && note.when < end) {
          const when = now + (note.when - this.currentTime) / this.tempo;
          const duration = note.duration / this.tempo;

          this.audioEngine.queueNote(
            track.instrumentInfo,
            when,
            note.pitch,
            duration,
            track.volume / 7,
            note.slides
          );
        }
      }
    }
  }

  /**
   * Set track volume (0-1)
   */
  setTrackVolume(trackIndex, volume) {
    if (trackIndex < 0 || trackIndex >= this.tracks.length) return;

    this.tracks[trackIndex].volume = Math.max(0.000001, Math.min(1, volume));
    this.emit('trackvolumechange', {
      trackIndex,
      volume: this.tracks[trackIndex].volume
    });
  }

  /**
   * Toggle track mute
   */
  toggleMute(trackIndex) {
    if (trackIndex < 0 || trackIndex >= this.tracks.length) return;

    this.tracks[trackIndex].muted = !this.tracks[trackIndex].muted;
    this.audioEngine.cancelQueue();

    this.emit('trackmutechange', {
      trackIndex,
      muted: this.tracks[trackIndex].muted
    });
  }

  /**
   * Toggle track solo
   */
  toggleSolo(trackIndex) {
    if (trackIndex < 0 || trackIndex >= this.tracks.length) return;

    this.tracks[trackIndex].solo = !this.tracks[trackIndex].solo;
    this.audioEngine.cancelQueue();

    this.emit('tracksolochange', {
      trackIndex,
      solo: this.tracks[trackIndex].solo
    });
  }

  /**
   * Change track instrument
   */
  async setTrackInstrument(trackIndex, instrumentId) {
    if (trackIndex < 0 || trackIndex >= this.tracks.length) return;

    try {
      const info = await this.audioEngine.loadInstrument(instrumentId);
      this.tracks[trackIndex].instrumentId = instrumentId;
      this.tracks[trackIndex].instrumentInfo = info;

      this.emit('trackinstrumentchange', {
        trackIndex,
        instrumentId,
        instrumentInfo: info
      });
    } catch (error) {
      console.error('Failed to load instrument:', error);
      this.emit('error', error);
    }
  }

  /**
   * Set loop points
   */
  setLoop(start, end, enabled = true) {
    this.loopStart = Math.max(0, start);
    this.loopEnd = Math.min(end, this.duration);
    this.loopEnabled = enabled;

    this.emit('loopchange', {
      enabled: this.loopEnabled,
      start: this.loopStart,
      end: this.loopEnd
    });
  }

  /**
   * Toggle loop
   */
  toggleLoop() {
    this.loopEnabled = !this.loopEnabled;
    this.emit('loopchange', {
      enabled: this.loopEnabled,
      start: this.loopStart,
      end: this.loopEnd
    });
  }

  /**
   * Save current mixer settings as preset
   */
  savePreset(name) {
    const presets = this.getPresets();

    presets[name] = {
      tracks: this.tracks.map(t => ({
        volume: t.volume,
        muted: t.muted,
        instrumentId: t.instrumentId
      })),
      tempo: this.tempo,
      savedAt: new Date().toISOString()
    };

    localStorage.setItem(this.presetsKey, JSON.stringify(presets));
    this.emit('presetsaved', name);

    return presets;
  }

  /**
   * Load a preset
   */
  loadPreset(name) {
    const presets = this.getPresets();
    const preset = presets[name];

    if (!preset) {
      console.warn('Preset not found:', name);
      return false;
    }

    // Apply track settings
    preset.tracks.forEach(async (t, i) => {
      if (i < this.tracks.length) {
        this.tracks[i].volume = t.volume;
        this.tracks[i].muted = t.muted;

        if (t.instrumentId !== this.tracks[i].instrumentId) {
          await this.setTrackInstrument(i, t.instrumentId);
        }
      }
    });

    // Apply tempo
    if (preset.tempo) {
      this.setTempo(preset.tempo);
    }

    this.emit('presetloaded', name);
    this.emit('tracksinitialized', this.tracks);

    return true;
  }

  /**
   * Get all saved presets
   */
  getPresets() {
    try {
      return JSON.parse(localStorage.getItem(this.presetsKey)) || {};
    } catch {
      return {};
    }
  }

  /**
   * Delete a preset
   */
  deletePreset(name) {
    const presets = this.getPresets();
    delete presets[name];
    localStorage.setItem(this.presetsKey, JSON.stringify(presets));
    this.emit('presetdeleted', name);
  }

  /**
   * Get available instruments
   */
  getInstruments() {
    if (!this.audioEngine.isInitialized) {
      return [];
    }
    return this.audioEngine.getInstrumentList();
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
    this.stop();
    this.listeners.clear();
    this.song = null;
    this.tracks = [];
  }
}

export default MIDIPlayer;
