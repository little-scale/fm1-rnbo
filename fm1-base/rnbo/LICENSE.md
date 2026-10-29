# Licences

The original adapter, tools, tests and example patch in this directory are MIT licensed:

Copyright (c) 2026 Sebastian Tomczak

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

This does not relicense third-party material:

- `export/rnbo_source.raw.h` and the adapted `export/rnbo_source.h` retain Cycling '74's generated-code licence notice and its dual-licensing terms.
- `export/common/` is copied from the installed RNBO package. `RNBO_Std.h` has a recorded compiler-ABI adaptation; its original is retained in `export/originals/`. Preserve `export/RNBO-runtime-LICENSE` and notices embedded in those files, including the third-party maths notices.
- The surrounding fm1-base platform and its BSP retain their MPL-2.0 licences.
- Packaging files and any future compiler/math libraries retain their existing notices. Generated device images are local build outputs and are not included in this source repository.
