"use strict";

let child_process = require('child_process');
let fs = require('fs');
let path = require('path');

let files = fs.readdirSync('in');

for (let file of files) {
	if (file.endsWith('.glsl')) {
		let outfile = path.join('out', file.substr(0, file.lastIndexOf('.')));
		console.log('Compiling ' + file + " to " + outfile);
		child_process.execFileSync(path.normalize('../build/Debug/krafix.exe'), ['glsl', path.join('in', file), outfile, 'temp', 'windows']);
		try {
			child_process.execFileSync(path.normalize('../glslang/Install/Windows/glslangValidator.exe'), [outfile]);
		}
		catch (error) {
			console.log(error.stdout.toString().trim());
		}
	}
}
