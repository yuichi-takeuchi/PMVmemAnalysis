# PMVmemAnalysis
Matlab codes for neuronal membrane potential analyses typically recorded with the PatchMaster software of HEKA.

## Getting Started

### Prerequisites
* Matlab (https://www.mathworks.com/products/matlab.html)
* APDetector Matlab GUI (https://github.com/yuichi-takeuchi/APDetector)

The code has been tested with Matlab ver 8.6 (R2015b) for Windows.

### Installing
* Install Matlab.
* Give your Matlab pass to m files in the lib folder.

### Concept
1. Load membrane potential traces into Matlab exported as a mat file from PatchMaster software with an analysis script (e.g. PM_160421_exp2_analysis.m).
2. Analyses physiological paremeters from the recordings (e.g. firing rate) with the same script.
3. Export the results as a mat file.
4. Collect the results and put together into a single mat file and make a population statistics with the Fg_561.m script.

## DOI
[![DOI](https://zenodo.org/badge/124748872.svg)](https://zenodo.org/badge/latestdoi/124748872)

## Versioning
We use [SemVer](http://semver.org/) for versioning.

## Releases
* Ver 1.0.0, 2018/04/18: The first release.
* Prerelease, 2018/03/11

## Authors
* **Yuichi Takeuchi PhD** - *Initial work* - [GitHub](https://github.com/yuichi-takeuchi)
* Affiliation: Department of Physiology, University of Szeged, Hungary
* E-mail: yuichi-takeuchi@umin.net

## License
This project is licensed under the MIT License.

## Acknowledgments
* The Uehara Memorial Foundation
* Department of Physiology, University of Szeged, Hungary

## References
PMVmemAnalysis has been used for the following work:
* Vöröslakos M, Takeuchi Y, Brinyiczki K, Zombori T, Oliva A, Fernández-Ruiz A, Kozák G, Kincses ZT, Iványi B, Buzsáki G, Berényi A (2018) Direct effects of transcranial electric stimulation on brain circuits in rats and humans. Nat Commun 9: 483.
