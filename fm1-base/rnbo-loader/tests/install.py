"""Player installation checks must work without unrelated example modules."""
import hashlib
import json
from pathlib import Path
import runpy
import shutil
import tempfile
from unittest.mock import patch

APP=Path(__file__).resolve().parents[1]
with tempfile.TemporaryDirectory() as directory:
    app=Path(directory)/'rnbo-loader';(app/'tools').mkdir(parents=True);(app/'build').mkdir()
    script=app/'tools/install.py';shutil.copy2(APP/'tools/install.py',script)
    data=b'installer wrapper fixture; the real installer validates package content'
    (app/'build/rnbo-player.fwsc').write_bytes(data)
    review={'module_pc_guard_extension':True,'raw_midi_abi2':True,'patch_slots':3,'presets_patch_selection':True,'identity':'FM-1_9400','sha256':hashlib.sha256(data).hexdigest()}
    path=app/'build/player-review.json';path.write_text(json.dumps(review))
    assert not (app/'modules').exists()
    with patch('subprocess.call',return_value=0) as install:
        try:runpy.run_path(str(script),run_name='__main__')
        except SystemExit as result:assert result.code==0
        assert install.call_count==1
        assert Path(install.call_args.args[0][-1]).resolve()==(app/'build/rnbo-player.fwsc').resolve()
    review['sha256']='wrong';path.write_text(json.dumps(review))
    with patch('subprocess.call') as install:
        try:runpy.run_path(str(script),run_name='__main__')
        except SystemExit as result:assert 'differs from reviewed build' in str(result.code)
        else:raise AssertionError('Unreviewed firmware accepted')
        install.assert_not_called()
print('PASS fresh player-only install without example modules; changed firmware rejected before hardware access')
