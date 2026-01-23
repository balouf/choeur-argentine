/**
 * MIDIParser.js - ES Module for parsing MIDI files
 * Converted from MIDIFile.js to ES modules with cleaner structure
 */

// UTF8 Utilities
const UTF8 = {
  isNotUTF8(bytes, byteOffset, byteLength) {
    try {
      UTF8.getStringFromBytes(bytes, byteOffset, byteLength, true);
    } catch (e) {
      return true;
    }
    return false;
  },

  getCharLength(theByte) {
    if (0xF0 === (theByte & 0xF0)) return 4;
    if (0xE0 === (theByte & 0xE0)) return 3;
    if (0xC0 === (theByte & 0xC0)) return 2;
    if (theByte === (theByte & 0x7F)) return 1;
    return 0;
  },

  getCharCode(bytes, byteOffset, charLength) {
    let charCode = 0;
    byteOffset = byteOffset || 0;

    if (bytes.length - byteOffset <= 0) {
      throw new Error('No more characters remaining in array.');
    }

    charLength = charLength || UTF8.getCharLength(bytes[byteOffset]);
    if (charLength === 0) {
      throw new Error(`${bytes[byteOffset].toString(2)} is not a significative byte (offset:${byteOffset}).`);
    }

    if (charLength === 1) return bytes[byteOffset];

    if (bytes.length - byteOffset < charLength) {
      throw new Error(`Expected at least ${charLength} bytes remaining in array.`);
    }

    let mask = '00000000'.slice(0, charLength) + 1 + '00000000'.slice(charLength + 1);
    if (bytes[byteOffset] & parseInt(mask, 2)) {
      throw Error(`Index ${byteOffset}: A ${charLength} bytes encoded char cannot encode the ${charLength + 1}th rank bit to 1.`);
    }

    mask = '0000'.slice(0, charLength + 1) + '11111111'.slice(charLength + 1);
    charCode += (bytes[byteOffset] & parseInt(mask, 2)) << ((--charLength) * 6);

    while (charLength) {
      if (0x80 !== (bytes[byteOffset + 1] & 0x80) || 0x40 === (bytes[byteOffset + 1] & 0x40)) {
        throw Error(`Index ${byteOffset + 1}: Next bytes of encoded char must begin with a "10" bit sequence.`);
      }
      charCode += ((bytes[++byteOffset] & 0x3F) << ((--charLength) * 6));
    }
    return charCode;
  },

  getStringFromBytes(bytes, byteOffset, byteLength, strict) {
    const chars = [];
    byteOffset = byteOffset | 0;
    byteLength = typeof byteLength === 'number' ? byteLength : bytes.byteLength || bytes.length;

    for (; byteOffset < byteLength; byteOffset++) {
      const charLength = UTF8.getCharLength(bytes[byteOffset]);
      if (byteOffset + charLength > byteLength) {
        if (strict) {
          throw Error(`Index ${byteOffset}: Found a ${charLength} bytes encoded char declaration but only ${byteLength - byteOffset} bytes are available.`);
        }
      } else {
        chars.push(String.fromCodePoint(UTF8.getCharCode(bytes, byteOffset, charLength)));
      }
      byteOffset += charLength - 1;
    }
    return chars.join('');
  }
};

// MIDI Event Constants
export const MIDIEventTypes = {
  EVENT_META: 0xFF,
  EVENT_SYSEX: 0xF0,
  EVENT_DIVSYSEX: 0xF7,
  EVENT_MIDI: 0x8,

  // Meta event subtypes
  META_SEQUENCE_NUMBER: 0x00,
  META_TEXT: 0x01,
  META_COPYRIGHT: 0x02,
  META_TRACK_NAME: 0x03,
  META_INSTRUMENT_NAME: 0x04,
  META_LYRICS: 0x05,
  META_MARKER: 0x06,
  META_CUE_POINT: 0x07,
  META_CHANNEL_PREFIX: 0x20,
  META_END_OF_TRACK: 0x2F,
  META_SET_TEMPO: 0x51,
  META_SMTPE_OFFSET: 0x54,
  META_TIME_SIGNATURE: 0x58,
  META_KEY_SIGNATURE: 0x59,
  META_SEQUENCER_SPECIFIC: 0x7F,

  // MIDI event subtypes
  MIDI_NOTE_OFF: 0x8,
  MIDI_NOTE_ON: 0x9,
  MIDI_NOTE_AFTERTOUCH: 0xA,
  MIDI_CONTROLLER: 0xB,
  MIDI_PROGRAM_CHANGE: 0xC,
  MIDI_CHANNEL_AFTERTOUCH: 0xD,
  MIDI_PITCH_BEND: 0xE
};

// Events that have 2 parameters
const MIDI_2PARAMS_EVENTS = [
  MIDIEventTypes.MIDI_NOTE_OFF,
  MIDIEventTypes.MIDI_NOTE_ON,
  MIDIEventTypes.MIDI_NOTE_AFTERTOUCH,
  MIDIEventTypes.MIDI_CONTROLLER,
  MIDIEventTypes.MIDI_PITCH_BEND
];

/**
 * Creates a stream wrapper around DataView for reading MIDI data
 */
function createStream(dataView, startAt = 0) {
  return {
    position: startAt,
    buffer: dataView,

    readUint8() {
      return this.buffer.getUint8(this.position++);
    },

    readUint16() {
      const v = this.buffer.getUint16(this.position);
      this.position += 2;
      return v;
    },

    readUint32() {
      const v = this.buffer.getUint32(this.position);
      this.position += 4;
      return v;
    },

    readVarInt() {
      let v = 0;
      let i = 0;
      while (i++ < 4) {
        const b = this.readUint8();
        if (b & 0x80) {
          v += (b & 0x7f);
          v <<= 7;
        } else {
          return v + b;
        }
      }
      throw new Error(`0x${this.position.toString(16)}: Variable integer length cannot exceed 4 bytes`);
    },

    readBytes(length) {
      const bytes = [];
      for (; length > 0; length--) {
        bytes.push(this.readUint8());
      }
      return bytes;
    },

    pos() {
      return '0x' + (this.buffer.byteOffset + this.position).toString(16);
    },

    end() {
      return this.position === this.buffer.byteLength;
    }
  };
}

/**
 * Creates a MIDI event parser
 */
function createEventParser(dataView, startAt = 0) {
  const stream = createStream(dataView, startAt);
  let MIDIEventType = null;
  let MIDIEventChannel = null;

  return {
    next() {
      if (stream.end()) return null;

      const event = {
        index: stream.pos(),
        delta: stream.readVarInt()
      };

      const eventTypeByte = stream.readUint8();

      if (0xF0 === (eventTypeByte & 0xF0)) {
        // Meta or System events
        if (eventTypeByte === MIDIEventTypes.EVENT_META) {
          event.type = MIDIEventTypes.EVENT_META;
          event.subtype = stream.readUint8();
          event.length = stream.readVarInt();

          switch (event.subtype) {
            case MIDIEventTypes.META_SEQUENCE_NUMBER:
              event.msb = stream.readUint8();
              event.lsb = stream.readUint8();
              break;
            case MIDIEventTypes.META_TEXT:
            case MIDIEventTypes.META_COPYRIGHT:
            case MIDIEventTypes.META_TRACK_NAME:
            case MIDIEventTypes.META_INSTRUMENT_NAME:
            case MIDIEventTypes.META_LYRICS:
            case MIDIEventTypes.META_MARKER:
            case MIDIEventTypes.META_CUE_POINT:
              event.data = stream.readBytes(event.length);
              break;
            case MIDIEventTypes.META_CHANNEL_PREFIX:
              event.prefix = stream.readUint8();
              break;
            case MIDIEventTypes.META_END_OF_TRACK:
              break;
            case MIDIEventTypes.META_SET_TEMPO:
              event.tempo = (stream.readUint8() << 16) + (stream.readUint8() << 8) + stream.readUint8();
              event.tempoBPM = 60000000 / event.tempo;
              break;
            case MIDIEventTypes.META_SMTPE_OFFSET:
              event.hour = stream.readUint8();
              event.minutes = stream.readUint8();
              event.seconds = stream.readUint8();
              event.frames = stream.readUint8();
              event.subframes = stream.readUint8();
              break;
            case MIDIEventTypes.META_TIME_SIGNATURE:
            case MIDIEventTypes.META_KEY_SIGNATURE:
            default:
              event.data = stream.readBytes(event.length);
              break;
          }
          return event;

        } else if (eventTypeByte === MIDIEventTypes.EVENT_SYSEX || eventTypeByte === MIDIEventTypes.EVENT_DIVSYSEX) {
          event.type = eventTypeByte;
          event.length = stream.readVarInt();
          event.data = stream.readBytes(event.length);
          return event;
        } else {
          // Unknown system event
          event.type = eventTypeByte;
          event.badsubtype = stream.readVarInt();
          event.length = stream.readUint8();
          event.data = stream.readBytes(event.length);
          return event;
        }
      } else {
        // MIDI events
        let MIDIEventParam1;

        if (0 === (eventTypeByte & 0x80)) {
          // Running status
          if (!MIDIEventType) {
            throw new Error(`${stream.pos()}: Running status without previous event`);
          }
          MIDIEventParam1 = eventTypeByte;
        } else {
          MIDIEventType = eventTypeByte >> 4;
          MIDIEventChannel = eventTypeByte & 0x0F;
          MIDIEventParam1 = stream.readUint8();
        }

        event.type = MIDIEventTypes.EVENT_MIDI;
        event.subtype = MIDIEventType;
        event.channel = MIDIEventChannel;
        event.param1 = MIDIEventParam1;

        if (MIDI_2PARAMS_EVENTS.includes(MIDIEventType)) {
          event.param2 = stream.readUint8();

          // Note on with velocity 0 is actually note off
          if (MIDIEventType === MIDIEventTypes.MIDI_NOTE_ON && !event.param2) {
            event.subtype = MIDIEventTypes.MIDI_NOTE_OFF;
            event.param2 = 127;
          }
        }

        return event;
      }
    }
  };
}

// MIDI File Header Parser
const HEADER_LENGTH = 14;

function parseHeader(buffer) {
  const datas = new DataView(buffer, 0, HEADER_LENGTH);

  // Verify MThd signature
  if (String.fromCharCode(datas.getUint8(0), datas.getUint8(1), datas.getUint8(2), datas.getUint8(3)) !== 'MThd') {
    throw new Error('Invalid MIDI file: MThd prefix not found');
  }

  if (datas.getUint32(4) !== 6) {
    throw new Error('Invalid MIDI file: Header chunk length must be 6');
  }

  const format = datas.getUint16(8);
  const tracksCount = datas.getUint16(10);
  const timeDivision = datas.getUint16(12);

  return {
    format,
    tracksCount,
    timeDivision,
    ticksPerBeat: (timeDivision & 0x8000) ? null : timeDivision,
    getTickResolution(tempo = 500000) {
      if (timeDivision & 0x8000) {
        // Frames per second
        const smpteFrames = (timeDivision & 0x7F00) >> 8;
        const ticksPerFrame = timeDivision & 0x00FF;
        return 1000000 / (smpteFrames * ticksPerFrame);
      }
      return tempo / timeDivision;
    }
  };
}

// MIDI File Track Parser
function parseTrack(buffer, start) {
  const headerView = new DataView(buffer, start, 8);

  // Verify MTrk signature
  if (String.fromCharCode(headerView.getUint8(0), headerView.getUint8(1), headerView.getUint8(2), headerView.getUint8(3)) !== 'MTrk') {
    throw new Error(`Invalid MIDI track at 0x${start.toString(16)}: MTrk prefix not found`);
  }

  const trackLength = headerView.getUint32(4);
  const content = new DataView(buffer, start + 8, trackLength);

  return {
    length: trackLength,
    content,
    totalLength: trackLength + 8
  };
}

/**
 * Main MIDI Parser class
 */
export class MIDIParser {
  constructor(arrayBuffer) {
    if (arrayBuffer instanceof Uint8Array) {
      arrayBuffer = new Uint8Array(arrayBuffer).buffer;
    }

    if (!(arrayBuffer instanceof ArrayBuffer)) {
      throw new Error('Invalid buffer: expected ArrayBuffer or Uint8Array');
    }

    if (arrayBuffer.byteLength < 25) {
      throw new Error('Invalid MIDI file: minimum size is 25 bytes');
    }

    this.buffer = arrayBuffer;
    this.header = parseHeader(arrayBuffer);
    this.tracks = [];

    // Parse all tracks
    let offset = HEADER_LENGTH;
    for (let i = 0; i < this.header.tracksCount; i++) {
      const track = parseTrack(arrayBuffer, offset);
      this.tracks.push(track);
      offset += track.totalLength;
    }
  }

  /**
   * Get all MIDI events with timing information
   */
  getEvents(type = null, subtype = null) {
    const events = [];
    let playTime = 0;
    let tickResolution = this.header.getTickResolution();

    const { format } = this.header;

    if (format !== 1 || this.tracks.length === 1) {
      // Sequential reading
      for (let i = 0; i < this.tracks.length; i++) {
        if (format === 2) playTime = 0;
        const parser = createEventParser(this.tracks[i].content, 0);
        let event;

        while ((event = parser.next())) {
          playTime += event.delta ? (event.delta * tickResolution) / 1000 : 0;

          if (event.type === MIDIEventTypes.EVENT_META && event.subtype === MIDIEventTypes.META_SET_TEMPO) {
            tickResolution = this.header.getTickResolution(event.tempo);
          }

          if ((!type || event.type === type) && (!subtype || event.subtype === subtype)) {
            event.playTime = playTime;
            events.push(event);
          }
        }
      }
    } else {
      // Concurrent reading (format 1)
      const trackParsers = this.tracks.map(track => ({
        parser: createEventParser(track.content, 0),
        curEvent: null
      }));

      // Initialize
      trackParsers.forEach(tp => {
        tp.curEvent = tp.parser.next();
      });

      while (true) {
        // Find track with smallest delta
        let smallestIdx = -1;
        for (let i = 0; i < trackParsers.length; i++) {
          if (trackParsers[i].curEvent) {
            if (smallestIdx === -1 || trackParsers[i].curEvent.delta < trackParsers[smallestIdx].curEvent.delta) {
              smallestIdx = i;
            }
          }
        }

        if (smallestIdx === -1) break;

        const smallestDelta = trackParsers[smallestIdx].curEvent.delta;

        // Subtract delta from all other tracks
        for (let i = 0; i < trackParsers.length; i++) {
          if (i !== smallestIdx && trackParsers[i].curEvent) {
            trackParsers[i].curEvent.delta -= smallestDelta;
          }
        }

        const event = trackParsers[smallestIdx].curEvent;
        playTime += event.delta ? (event.delta * tickResolution) / 1000 : 0;

        if (event.type === MIDIEventTypes.EVENT_META && event.subtype === MIDIEventTypes.META_SET_TEMPO) {
          tickResolution = this.header.getTickResolution(event.tempo);
        }

        if ((!type || event.type === type) && (!subtype || event.subtype === subtype)) {
          event.playTime = playTime;
          event.track = smallestIdx;
          events.push(event);
        }

        trackParsers[smallestIdx].curEvent = trackParsers[smallestIdx].parser.next();
      }
    }

    return events;
  }

  /**
   * Get only MIDI events (notes, controllers, etc.)
   */
  getMidiEvents() {
    return this.getEvents(MIDIEventTypes.EVENT_MIDI);
  }

  /**
   * Parse the MIDI file into a song structure suitable for playback
   */
  parseSong() {
    const song = {
      duration: 0,
      tracks: [],
      beats: []
    };

    const events = this.getMidiEvents();
    const pitchBendRange = Array(16).fill(2); // Default 2 semitones
    let expectedPBRMessage = 1;
    let expectedPBRChannel = null;

    const takeTrack = (channel) => {
      let track = song.tracks.find(t => t.n === channel);
      if (!track) {
        track = { n: channel, notes: [], volume: 1, program: 0 };
        song.tracks.push(track);
      }
      return track;
    };

    const takeBeat = (n) => {
      let beat = song.beats.find(b => b.n === n);
      if (!beat) {
        beat = { n, notes: [], volume: 1 };
        song.beats.push(beat);
      }
      return beat;
    };

    for (const event of events) {
      const oldExpectedPBRMessage = expectedPBRMessage;

      if (event.playTime / 1000 > song.duration) {
        song.duration = event.playTime / 1000;
      }

      switch (event.subtype) {
        case MIDIEventTypes.MIDI_NOTE_ON:
          if (event.channel === 9) {
            // Drums
            if (event.param1 >= 35 && event.param1 <= 81) {
              takeBeat(event.param1).notes.push({ when: event.playTime / 1000 });
            }
          } else {
            if (event.param1 >= 0 && event.param1 <= 127) {
              takeTrack(event.channel).notes.push({
                when: event.playTime / 1000,
                pitch: event.param1,
                duration: 0.0000001,
                slides: []
              });
            }
          }
          break;

        case MIDIEventTypes.MIDI_NOTE_OFF:
          if (event.channel !== 9) {
            const track = takeTrack(event.channel);
            for (const note of track.notes) {
              if (note.duration === 0.0000001 && note.pitch === event.param1 && note.when < event.playTime / 1000) {
                note.duration = event.playTime / 1000 - note.when;
                break;
              }
            }
          }
          break;

        case MIDIEventTypes.MIDI_PROGRAM_CHANGE:
          if (event.channel !== 9) {
            takeTrack(event.channel).program = event.param1;
          }
          break;

        case MIDIEventTypes.MIDI_CONTROLLER:
          if (event.param1 === 7 && event.channel !== 9) {
            takeTrack(event.channel).volume = event.param2 / 127 || 0.000001;
          } else if (
            (expectedPBRMessage === 1 && event.param1 === 0x65 && event.param2 === 0x00) ||
            (expectedPBRMessage === 2 && event.param1 === 0x64 && event.param2 === 0x00) ||
            (expectedPBRMessage === 3 && event.param1 === 0x06) ||
            (expectedPBRMessage === 4 && event.param1 === 0x26)
          ) {
            expectedPBRChannel = event.channel;
            if (expectedPBRMessage === 3) {
              pitchBendRange[event.channel] = event.param2;
            }
            if (expectedPBRMessage === 4) {
              pitchBendRange[event.channel] += event.param2 / 100;
            }
            expectedPBRMessage++;
            if (expectedPBRMessage === 5) expectedPBRMessage = 1;
          }
          break;

        case MIDIEventTypes.MIDI_PITCH_BEND:
          const track = takeTrack(event.channel);
          for (const note of track.notes) {
            if (note.duration === 0.0000001 && note.when < event.playTime / 1000) {
              note.slides.push({
                delta: (event.param2 - 64) / 64 * pitchBendRange[event.channel],
                when: event.playTime / 1000 - note.when
              });
            }
          }
          break;
      }

      // Reset pitch bend range message tracking if not a pitch bend range message
      if (oldExpectedPBRMessage === expectedPBRMessage) {
        if (expectedPBRMessage === 4) expectedPBRMessage = 1;
      }
    }

    return song;
  }

  /**
   * Get lyrics from the MIDI file
   */
  getLyrics() {
    const events = this.getEvents(MIDIEventTypes.EVENT_META);
    let texts = [];
    let lyrics = [];

    for (const event of events) {
      if (event.subtype === MIDIEventTypes.META_LYRICS) {
        lyrics.push(event);
      } else if (event.subtype === MIDIEventTypes.META_TEXT) {
        const firstChar = String.fromCharCode(event.data[0]);
        if (firstChar !== '@' && event.playTime !== 0) {
          const text = String.fromCharCode.apply(String, event.data);
          if (text.indexOf('words') !== 0) {
            texts.push(event);
          } else {
            texts = [];
          }
        }
      }
    }

    const result = lyrics.length > 2 ? lyrics : texts;

    // Convert to text
    try {
      result.forEach(event => {
        event.text = UTF8.getStringFromBytes(event.data, 0, event.length, true);
      });
    } catch (e) {
      result.forEach(event => {
        event.text = event.data.map(c => String.fromCharCode(c)).join('');
      });
    }

    return result;
  }
}

export default MIDIParser;
