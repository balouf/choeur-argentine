<html>

<head>
	<meta charset="utf-8">
	<script src='https://surikov.github.io/webaudiofont/npm/dist/WebAudioFontPlayer.js'></script>
	<script src='MIDIFile.js'></script>
</head>

<body>
	<div id='choice'>
	</div>
	<div id="player">
			<p>
				<button  id="play" onclick="startPlay();" style="width: 100px;">Play</button>
				<input id="position" type="range" min="0" max="100" value="0" step="1" />
				<output id="tmr"></output></p>
		<p>Vitesse: <input type="range" value="1.0" min=".5" max="2.0" step="0.05" id="speed" oninput="this.nextElementSibling.value = 'X' + this.value"><output>X1.0</output></p>

		</table>
	</div>
	<div id='cntls'>
	</div>
	<div id="downloads">
	</div>
	<div>
		<h3>
			Conseils d'utilisation du mixer:
		</h3>
		<ul>
			<li>Au début, ne pas hésiter à mettre sa voix à volume maximal pour bien l'entendre.</li>
			<li>Baisser progressivement au fur et à mesure que vous connaissez mieux votre partie.</li>
			<li>Vous pouvez jouer avec les instruments midi selon vos goûts !</li>
		</ul>
	</div>
    <div>
        <a href="https://github.com/balouf/choeur-argentine" target="_blank">Code source</a>
    </div>
	<script>
		console.log('start');
		var audioContext = null;
		var player = null;
		var reverberator = null;
		var equalizer = null;
		var input = null;
		var currentSongTime = 0;
		var nextStepTime = 0;
		var nextPositionTime = 0;
		var loadedsong = null;
		var stepDuration = 44 / 1000;
		var intervalId = 0;

		var tracks = $tracks;

		var downloads = {
			'pdf': [{'name': 'Choeurs', 'suffix': ''}],
				// {'name': 'Piano', 'suffix': '-piano'},
				// {'name': 'Conducteur', 'suffix': '-full'}],
			'mp3': [{'name': 'Complet', 'suffix': ''}],
		}

		var voix = ['Soprano', 'Alto', 'Tenor', 'Basse', 'Main droite', 'Main gauche']
		// var voix = ['Voix I', 'Voix II', 'Voix III', 'Voix IV', 'Voix V']
		var song_id = 0;

		chooserTrack();

		function chooserTrack() {
			var html = '<select id="tracks">';
			for (var i = 0; i < tracks.length; i++) {
				html = html + '<option value="' + i + '">' + tracks[i].name + '</option>';
			}
			html = html + '</select>';
			document.getElementById('choice').innerHTML = html;
			var track = document.getElementById('tracks');
			track.onchange = function (e) {
				selectTrack(track.value);
			};
			selectTrack(0);
		}

		function selectTrack(i) {
		        song_id = i;
				var path = tracks[i].path + '/' + tracks[i].path;
				var html = '<h3>Partitions</h3> <ul>';
				for (var j = 0; j < downloads.pdf.length; j++) {
					html += '<li><a href="' + path + downloads.pdf[j].suffix + '.pdf" target="_blank">' + tracks[i].name
							+ ' (' + downloads.pdf[j].name + ')</a></li>'
				}
				html += '</ul><h3>MP3</h3> <ul>';
				for (var j = 0; j < downloads.mp3.length; j++) {
					html += '<li><a href="' + path + downloads.mp3[j].suffix + '.mp3" target="_blank">' + tracks[i].name
							+ ' (' + downloads.pdf[j].name + ')</a></li>'
				}
				html += '</ul>';
				document.getElementById('downloads').innerHTML = html;
				handleExample(path+'.midi');
				document.getElementById('position').value = 0;
				document.getElementById('tmr').innerHTML = '';
				document.getElementById('play').innerHTML = 'Play';
				document.getElementById('play').setAttribute("onclick", "startPlay();");
				if (player && audioContext) {
					player.cancelQueue(audioContext);
				}
				if (intervalId != 0) {clearInterval(intervalId)}

		}

		function pausePlay() {
			clearInterval(intervalId)
			player.cancelQueue(audioContext);
			document.getElementById('play').innerHTML = 'Play';
			document.getElementById('play').setAttribute("onclick", "resumePlay();");

		}

		function startPlay() {
			var pos = document.getElementById('position');
			currentSongTime = loadedsong.duration * pos.value / 100;
			// songStart = audioContext.currentTime - currentSongTime;

			// currentSongTime = 0;
			// songStart = audioContext.currentTime;
			audioContext.resume();
			nextStepTime = audioContext.currentTime;
			intervalId = setInterval(() => {tick()}, 40);
			document.getElementById('play').innerHTML = 'Pause';
			document.getElementById('play').setAttribute("onclick", "pausePlay();");
		}

		function resumePlay() {
			// songStart = audioContext.currentTime - currentSongTime;
			nextStepTime = audioContext.currentTime;
			intervalId = setInterval(() => {tick()}, 40)
			document.getElementById('play').innerHTML = 'Pause';
			document.getElementById('play').setAttribute("onclick", "pausePlay();");
		}

		function tick() {
			var now = audioContext.currentTime;
			var speed = document.getElementById('speed').value;
			if (now > nextStepTime - stepDuration) {
				sendNotes(now, speed);
				currentSongTime = currentSongTime + (stepDuration * speed);
				nextStepTime = nextStepTime + stepDuration;
			}
			if (now > nextPositionTime) {
				var o = document.getElementById('position');
				o.value = 100 * currentSongTime / loadedsong.duration;
				document.getElementById('tmr').innerHTML = '' + Math.round(100 * currentSongTime / loadedsong.duration) + '%';
				nextPositionTime = audioContext.currentTime + 3;
			}
			if (currentSongTime > loadedsong.duration) {
				clearInterval(intervalId);
				document.getElementById('tmr').innerHTML = '';
				document.getElementById('position').value = 0;
				document.getElementById('play').innerHTML = 'Play';
				document.getElementById('play').setAttribute("onclick", "startPlay();");
			}
		}

		function sendNotes(now, speed) {
			var start = currentSongTime;
			var end = currentSongTime + stepDuration * speed;
			for (var t = 0; t < loadedsong.tracks.length; t++) {
				var track = loadedsong.tracks[t];
				for (var i = 0; i < track.notes.length; i++) {
					if (track.notes[i].when >= start && track.notes[i].when < end) {
						var when = now + ( (track.notes[i].when - currentSongTime) / speed );
						var duration = track.notes[i].duration / speed;
						if (duration > 3) {
							duration = 3;
						}
						var instr = track.info.variable;
						var v = track.volume / 7;
						player.queueWaveTable(audioContext, input, window[instr], when, track.notes[i].pitch, duration, v, track.notes[i].slides);
					}
				}
			}
		}
		function startLoad(song) {
			console.log(song);
			var AudioContextFunc = window.AudioContext || window.webkitAudioContext;
			audioContext = new AudioContextFunc();
			player = new WebAudioFontPlayer();

			equalizer = player.createChannel(audioContext);
			reverberator = player.createReverberator(audioContext);
			//input = reverberator.input;
			input = equalizer.input;
			equalizer.output.connect(reverberator.input);
			reverberator.output.connect(audioContext.destination);

			for (var i = 0; i < song.tracks.length; i++) {
				var nn = player.loader.findInstrument(song.tracks[i].program);
				var info = player.loader.instrumentInfo(nn);
				song.tracks[i].info = info;
				song.tracks[i].id = nn;
				song.tracks[i].volume = 0.1;
				player.loader.startLoad(audioContext, info.url, info.variable);
			}
			player.loader.waitLoad(function () {
				console.log('buildControls');
				buildControls(song);
				resetEqlualizer();
			});
		}
		function resetEqlualizer(){
			equalizer.band32.gain.setTargetAtTime(2,0,0.0001);
			equalizer.band64.gain.setTargetAtTime(2,0,0.0001);
			equalizer.band128.gain.setTargetAtTime(1,0,0.0001);
			equalizer.band256.gain.setTargetAtTime(0,0,0.0001);
			equalizer.band512.gain.setTargetAtTime(-1,0,0.0001);
			equalizer.band1k.gain.setTargetAtTime(5,0,0.0001);
			equalizer.band2k.gain.setTargetAtTime(4,0,0.0001);
			equalizer.band4k.gain.setTargetAtTime(3,0,0.0001);
			equalizer.band8k.gain.setTargetAtTime(-2,0,0.0001);
			equalizer.band16k.gain.setTargetAtTime(2,0,0.0001);
		}
		function buildControls(song) {
			// audioContext.resume();
			var o = document.getElementById('cntls');
			var html = '<h3>Mixer</h3><table><tr><th>Voix</th><th>Instrument midi</th><th>Volume</th></tr>';
			for (var i = 0; i < song.tracks.length; i++) {
				var v = 100 * song.tracks[i].volume;
				html = html + '<tr><td>' + tracks[song_id].voix[i] + '</td><td>' + chooserIns(song.tracks[i].id, i)
						+ '</td><td><input id="channel' + i + '" type="range" min="0" max="100" value="' + v + '" step="1" /></td></tr>';
			}
			o.innerHTML = html + '</table>';
			console.log('Loaded');
			var pos = document.getElementById('position');
			pos.oninput = function (e) {
				if (loadedsong) {
					player.cancelQueue(audioContext);
					var next = song.duration * pos.value / 100;
					// songStart = songStart - (next - currentSongTime);
					currentSongTime = next;
				}
			};
			console.log('Tracks');
			for (var i = 0; i < song.tracks.length; i++) {
				setVolumeAction(i, song);
			}
			loadedsong = song;
		}
		function setVolumeAction(i, song) {
			var vlm = document.getElementById('channel' + i);
			vlm.oninput = function (e) {
				player.cancelQueue(audioContext);
				var v = vlm.value / 100;
				if (v < 0.000001) {
					v = 0.000001;
				}
				song.tracks[i].volume = v;
			};
			var sl = document.getElementById('selins' + i);
			sl.onchange = function (e) {
				var nn = sl.value;
				var info = player.loader.instrumentInfo(nn);
				player.loader.startLoad(audioContext, info.url, info.variable);
				player.loader.waitLoad(function () {
					console.log('loaded');
					song.tracks[i].info = info;
					song.tracks[i].id = nn;
				});
			};
		}
		function chooserIns(n, track) {
			var html = '<select id="selins' + track + '">';
			var instru = ''
			for (var i = 0; i < player.loader.instrumentKeys().length; i++) {
				var sel = '';
				if (i == n) {
					sel = ' selected';
				}
				if (instru != player.loader.instrumentInfo(i).title) {
				instru = player.loader.instrumentInfo(i).title
				html = html + '<option value="' + i + '"' + sel + '>' + player.loader.instrumentInfo(i).title + '</option>';
				}
			}
			html = html + '</select>';
			return html;
		}

		function handleExample(path) {
			console.log(path);
			var xmlHttpRequest = new XMLHttpRequest();
			xmlHttpRequest.open("GET", path, true);
			xmlHttpRequest.responseType = "arraybuffer";
			xmlHttpRequest.onload = function (e) {
				var arrayBuffer = xmlHttpRequest.response;
				var midiFile = new MIDIFile(arrayBuffer);
				var song = midiFile.parseSong();
				startLoad(song);
			};
			xmlHttpRequest.send(null);
		}
	</script>
</body>

</html>
