/**
 * Visualizer.js - Audio visualization component
 * Supports waveform and frequency bar visualizations
 */

import { getAudioEngine } from './AudioEngine.js';

/**
 * Visualizer modes
 */
export const VisualizerMode = {
  WAVEFORM: 'waveform',
  BARS: 'bars',
  NONE: 'none'
};

/**
 * Visualizer class
 */
export class Visualizer {
  constructor(canvas, options = {}) {
    this.canvas = typeof canvas === 'string'
      ? document.querySelector(canvas)
      : canvas;

    if (!this.canvas || !(this.canvas instanceof HTMLCanvasElement)) {
      throw new Error('Invalid canvas element');
    }

    this.ctx = this.canvas.getContext('2d');
    this.audioEngine = getAudioEngine();

    // Options
    this.options = {
      mode: options.mode ?? VisualizerMode.WAVEFORM,
      barCount: options.barCount ?? 64,
      barWidth: options.barWidth ?? null, // Auto-calculated
      barGap: options.barGap ?? 2,
      smoothing: options.smoothing ?? 0.8,
      minDecibels: options.minDecibels ?? -90,
      maxDecibels: options.maxDecibels ?? -10,
      ...options
    };

    // Colors
    this.colors = {
      background: options.backgroundColor ?? '#1e293b',
      waveform: options.waveformColor ?? '#3b82f6',
      waveformGradient: options.waveformGradient ?? ['#3b82f6', '#8b5cf6'],
      bars: options.barsColor ?? '#22c55e',
      barsGradient: options.barsGradient ?? ['#22c55e', '#eab308', '#ef4444'],
      centerLine: options.centerLineColor ?? 'rgba(255,255,255,0.2)',
      ...options.colors
    };

    // Animation state
    this.animationFrame = null;
    this.isRunning = false;

    // Performance optimization
    this.lastRenderTime = 0;
    this.targetFPS = options.targetFPS ?? 30;
    this.frameInterval = 1000 / this.targetFPS;

    // Setup canvas
    this.setupCanvas();

    // Handle resize
    this.resizeObserver = new ResizeObserver(() => this.setupCanvas());
    this.resizeObserver.observe(this.canvas);
  }

  /**
   * Setup canvas dimensions
   */
  setupCanvas() {
    const rect = this.canvas.getBoundingClientRect();
    const dpr = window.devicePixelRatio || 1;

    this.canvas.width = rect.width * dpr;
    this.canvas.height = rect.height * dpr;

    this.ctx.scale(dpr, dpr);

    this.width = rect.width;
    this.height = rect.height;

    // Calculate bar width if not set
    if (!this.options.barWidth) {
      this.options.barWidth = (this.width - (this.options.barCount - 1) * this.options.barGap) / this.options.barCount;
    }
  }

  /**
   * Set visualization mode
   */
  setMode(mode) {
    this.options.mode = mode;

    if (mode === VisualizerMode.NONE) {
      this.stop();
      this.clear();
    }
  }

  /**
   * Start visualization
   */
  start() {
    if (this.isRunning) return;
    this.isRunning = true;
    this.render();
  }

  /**
   * Stop visualization
   */
  stop() {
    this.isRunning = false;
    if (this.animationFrame) {
      cancelAnimationFrame(this.animationFrame);
      this.animationFrame = null;
    }
  }

  /**
   * Clear canvas
   */
  clear() {
    this.ctx.fillStyle = this.colors.background;
    this.ctx.fillRect(0, 0, this.width, this.height);
  }

  /**
   * Main render loop
   */
  render() {
    if (!this.isRunning) return;

    const now = performance.now();
    const delta = now - this.lastRenderTime;

    if (delta >= this.frameInterval) {
      this.lastRenderTime = now - (delta % this.frameInterval);

      switch (this.options.mode) {
        case VisualizerMode.WAVEFORM:
          this.renderWaveform();
          break;
        case VisualizerMode.BARS:
          this.renderBars();
          break;
        default:
          this.clear();
      }
    }

    this.animationFrame = requestAnimationFrame(() => this.render());
  }

  /**
   * Render waveform visualization
   */
  renderWaveform() {
    const data = this.audioEngine.getWaveformData();

    this.clear();

    if (!data) {
      this.drawCenterLine();
      return;
    }

    const { dataArray, bufferLength } = data;
    const sliceWidth = this.width / bufferLength;

    // Create gradient
    const gradient = this.ctx.createLinearGradient(0, 0, this.width, 0);
    this.colors.waveformGradient.forEach((color, i) => {
      gradient.addColorStop(i / (this.colors.waveformGradient.length - 1), color);
    });

    // Draw waveform
    this.ctx.beginPath();
    this.ctx.strokeStyle = gradient;
    this.ctx.lineWidth = 2;
    this.ctx.lineJoin = 'round';

    let x = 0;
    for (let i = 0; i < bufferLength; i++) {
      const v = dataArray[i] / 128.0;
      const y = (v * this.height) / 2;

      if (i === 0) {
        this.ctx.moveTo(x, y);
      } else {
        this.ctx.lineTo(x, y);
      }
      x += sliceWidth;
    }

    this.ctx.stroke();

    // Draw filled area (optional)
    this.ctx.lineTo(this.width, this.height / 2);
    this.ctx.lineTo(0, this.height / 2);
    this.ctx.closePath();

    const fillGradient = this.ctx.createLinearGradient(0, 0, 0, this.height);
    fillGradient.addColorStop(0, 'rgba(59, 130, 246, 0.3)');
    fillGradient.addColorStop(0.5, 'rgba(59, 130, 246, 0.1)');
    fillGradient.addColorStop(1, 'rgba(59, 130, 246, 0.3)');
    this.ctx.fillStyle = fillGradient;
    this.ctx.fill();

    this.drawCenterLine();
  }

  /**
   * Render frequency bars visualization
   */
  renderBars() {
    const data = this.audioEngine.getAnalyserData();

    this.clear();

    if (!data) return;

    const { dataArray, bufferLength } = data;
    const { barCount, barWidth, barGap } = this.options;

    // Sample the frequency data
    const step = Math.floor(bufferLength / barCount);

    // Create gradient for bars
    const gradient = this.ctx.createLinearGradient(0, this.height, 0, 0);
    this.colors.barsGradient.forEach((color, i) => {
      gradient.addColorStop(i / (this.colors.barsGradient.length - 1), color);
    });

    for (let i = 0; i < barCount; i++) {
      // Average multiple frequency bins for smoother visualization
      let sum = 0;
      for (let j = 0; j < step; j++) {
        sum += dataArray[i * step + j];
      }
      const average = sum / step;

      const barHeight = (average / 255) * this.height * 0.9;
      const x = i * (barWidth + barGap);
      const y = this.height - barHeight;

      // Draw bar with rounded top
      this.ctx.fillStyle = gradient;
      this.ctx.beginPath();
      this.ctx.roundRect(x, y, barWidth, barHeight, [barWidth / 2, barWidth / 2, 0, 0]);
      this.ctx.fill();

      // Draw reflection (optional)
      const reflectionGradient = this.ctx.createLinearGradient(0, this.height, 0, this.height + barHeight * 0.3);
      reflectionGradient.addColorStop(0, 'rgba(34, 197, 94, 0.3)');
      reflectionGradient.addColorStop(1, 'rgba(34, 197, 94, 0)');
      this.ctx.fillStyle = reflectionGradient;
      this.ctx.fillRect(x, this.height, barWidth, barHeight * 0.3);
    }
  }

  /**
   * Draw center line
   */
  drawCenterLine() {
    this.ctx.beginPath();
    this.ctx.strokeStyle = this.colors.centerLine;
    this.ctx.lineWidth = 1;
    this.ctx.moveTo(0, this.height / 2);
    this.ctx.lineTo(this.width, this.height / 2);
    this.ctx.stroke();
  }

  /**
   * Draw idle state (static waveform)
   */
  drawIdle() {
    this.clear();
    this.drawCenterLine();

    // Draw a gentle sine wave
    this.ctx.beginPath();
    this.ctx.strokeStyle = 'rgba(255, 255, 255, 0.2)';
    this.ctx.lineWidth = 1;

    for (let x = 0; x < this.width; x++) {
      const y = this.height / 2 + Math.sin(x * 0.02) * 10;
      if (x === 0) {
        this.ctx.moveTo(x, y);
      } else {
        this.ctx.lineTo(x, y);
      }
    }

    this.ctx.stroke();
  }

  /**
   * Cleanup
   */
  dispose() {
    this.stop();
    this.resizeObserver.disconnect();
  }
}

/**
 * Simple static waveform drawer for audio files
 * Draws the entire waveform of an audio buffer
 */
export class StaticWaveform {
  constructor(canvas, options = {}) {
    this.canvas = typeof canvas === 'string'
      ? document.querySelector(canvas)
      : canvas;

    this.ctx = this.canvas.getContext('2d');

    this.options = {
      color: options.color ?? '#3b82f6',
      backgroundColor: options.backgroundColor ?? '#1e293b',
      progressColor: options.progressColor ?? '#22c55e',
      ...options
    };

    this.audioBuffer = null;
    this.progress = 0;
    this.waveformData = null;

    this.setupCanvas();

    this.resizeObserver = new ResizeObserver(() => {
      this.setupCanvas();
      this.draw();
    });
    this.resizeObserver.observe(this.canvas);
  }

  setupCanvas() {
    const rect = this.canvas.getBoundingClientRect();
    const dpr = window.devicePixelRatio || 1;

    this.canvas.width = rect.width * dpr;
    this.canvas.height = rect.height * dpr;
    this.ctx.scale(dpr, dpr);

    this.width = rect.width;
    this.height = rect.height;
  }

  /**
   * Analyze audio buffer and extract waveform data
   */
  async analyze(audioBuffer) {
    this.audioBuffer = audioBuffer;

    // Get channel data (use first channel for simplicity)
    const channelData = audioBuffer.getChannelData(0);
    const samples = this.width * 2; // 2 samples per pixel for detail
    const blockSize = Math.floor(channelData.length / samples);

    this.waveformData = [];

    for (let i = 0; i < samples; i++) {
      const start = blockSize * i;
      let min = 1.0;
      let max = -1.0;

      for (let j = 0; j < blockSize; j++) {
        const sample = channelData[start + j];
        if (sample < min) min = sample;
        if (sample > max) max = sample;
      }

      this.waveformData.push({ min, max });
    }

    this.draw();
  }

  /**
   * Set progress (0-1)
   */
  setProgress(progress) {
    this.progress = Math.max(0, Math.min(1, progress));
    this.draw();
  }

  /**
   * Draw the waveform
   */
  draw() {
    if (!this.waveformData) {
      this.drawPlaceholder();
      return;
    }

    this.ctx.fillStyle = this.options.backgroundColor;
    this.ctx.fillRect(0, 0, this.width, this.height);

    const centerY = this.height / 2;
    const progressX = this.width * this.progress;

    for (let i = 0; i < this.waveformData.length; i++) {
      const x = (i / this.waveformData.length) * this.width;
      const { min, max } = this.waveformData[i];

      const minY = centerY + min * centerY * 0.9;
      const maxY = centerY + max * centerY * 0.9;

      // Use progress color for played portion
      this.ctx.fillStyle = x < progressX ? this.options.progressColor : this.options.color;
      this.ctx.fillRect(x, minY, 1, maxY - minY);
    }
  }

  /**
   * Draw placeholder when no data
   */
  drawPlaceholder() {
    this.ctx.fillStyle = this.options.backgroundColor;
    this.ctx.fillRect(0, 0, this.width, this.height);

    this.ctx.strokeStyle = 'rgba(255, 255, 255, 0.1)';
    this.ctx.lineWidth = 1;
    this.ctx.beginPath();
    this.ctx.moveTo(0, this.height / 2);
    this.ctx.lineTo(this.width, this.height / 2);
    this.ctx.stroke();
  }

  dispose() {
    this.resizeObserver.disconnect();
  }
}

export default Visualizer;
