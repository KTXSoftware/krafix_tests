"use strict";

let child_process = require('child_process');
let fs = require('fs');
let os = require('os');
let path = require('path');

let files = fs.readdirSync('in');

if (!fs.existsSync('out')) fs.mkdirSync('out');
if (!fs.existsSync('temp')) fs.mkdirSync('temp');

for (let file of files) {
	if (file.endsWith('.glsl')) {
		console.log('Compiling ' + file);
		let targets = ['glsl'];
		if (os.platform() === 'win32') {
			targets.push('d3d9');
		}
		for (let target of targets) {
			if (!fs.existsSync(path.join('out', target))) fs.mkdirSync(path.join('out', target));
			let outfile = path.join('out', target, file.substr(0, file.lastIndexOf('.')));
			if (target !== 'glsl') {
				outfile = path.join('out', target, file.substr(0, file.lastIndexOf('.')) + '.' + target);
			}
			try {
				child_process.execFileSync(path.normalize('../build/Debug/krafix'), [target, path.join('in', file), outfile, 'temp', 'windows']);
				if (target === 'glsl' && os.platform() === 'win32') {
					child_process.execFileSync(path.normalize('../glslang/Install/Windows/glslangValidator.exe'), [outfile]);
				}
			}
			catch (error) {
				console.log('Error in ' + target + ' target.');
				let errorstring = error.stdout.toString().trim();
				if (errorstring.length > 0) console.log(errorstring);
			}
		}
	}
}
