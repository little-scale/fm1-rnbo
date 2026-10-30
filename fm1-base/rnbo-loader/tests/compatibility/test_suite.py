# SPDX-License-Identifier: MIT
"""Harness tests only. Synthetic modules below are explicitly NOT RNBO evidence."""
import ast,collections,importlib.util,json,os,re,subprocess,sys,tempfile,unittest
from pathlib import Path
HERE=Path(__file__).resolve().parent;APP=HERE.parents[1]
sys.path.insert(0,str(HERE));sys.path.insert(0,str(APP/'tools'))
from fixtures import make_cases,slug,validate,Graph
probe_spec=importlib.util.spec_from_file_location('compat_probe',HERE/'probe.py');probe=importlib.util.module_from_spec(probe_spec);probe_spec.loader.exec_module(probe);run=probe.run
spec=importlib.util.spec_from_file_location('compat_runner',APP/'tools/compatibility.py');runner=importlib.util.module_from_spec(spec);spec.loader.exec_module(runner)

C_SOURCE=r'''
#include <stdint.h>
#ifndef BAD
#define BAD 0
#endif
static unsigned muted;
static struct {unsigned used,capacity,allocations,late,errors,blocks,bad;} stats;
static int init(void){muted=0;stats.used=16;stats.capacity=1024;stats.allocations=1;stats.late=stats.errors=stats.blocks=stats.bad=0;return 1;}
static void render(int *lr,unsigned n,unsigned gain){(void)gain;stats.blocks++;for(unsigned i=0;i<n*2;i++)lr[i]=(BAD==3||muted)?0:BAD==2?8388608:1000;if(BAD==1)stats.late=1;}
static void midi(unsigned a,unsigned b,unsigned c){(void)a;(void)b;(void)c;}
static void panic(void){if(BAD!=4)muted=1;}
static unsigned count(void){return 1;}
static const char *name(unsigned i){(void)i;return "synthetic harness fixture";}
static float value(unsigned i){(void)i;return .5f;}
static void set(unsigned i,float v){(void)i;(void)v;}
static void get(void *out){__builtin_memcpy(out,&stats,sizeof stats);}
struct Api {unsigned magic,abi,bytes,id;char title[32];int(*init)(void);void(*render)(int*,unsigned,unsigned);void(*midi)(unsigned,unsigned,unsigned);void(*panic)(void);unsigned(*count)(void);const char*(*name)(unsigned);float(*value)(unsigned);void(*set)(unsigned,float);void(*stats)(void*);};
const struct Api rnbo_module={0x31495041,1,sizeof(struct Api),123,"HARNESS NOT RNBO",init,render,midi,panic,count,name,value,set,get};
'''

class Suite(unittest.TestCase):
    def test_audit_getters_do_not_hide_unknown_double_calls(self):
        tree=ast.parse((APP.parent/'rnbo/tools/audit.py').read_text())
        node=next(n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name=='unknown_double_call')
        namespace=dict(re=re,functions={'getter':'return stored data'},call=re.compile(r'\bcall\b[^@\n]*@([^\s(]+)'))
        exec(compile(ast.Module(body=[node],type_ignores=[]),'<audit test>','exec'),namespace)
        check=namespace['unknown_double_call']
        self.assertFalse(check('%x = call double @getter(ptr %p)'))
        self.assertTrue(check('%x = call double @pow(double %a, double %b)'))
        self.assertTrue(check('%x = call double %unknown(ptr %p)'))
    def test_every_case_connected_and_unique(self):
        cases=make_cases();self.assertGreaterEqual(len(cases),200)
        self.assertEqual(len({slug(c.name) for c in cases}),len(cases))
        for c in cases:
            self.assertLessEqual(len(slug(c.name)),24);self.assertTrue(validate(c));self.assertIn(c.expectation,['pass','reject'])
        self.assertGreaterEqual(len({c.family for c in cases}),12)
    def test_disconnect_is_not_coverage(self):
        c=make_cases()[0];c.patch['patcher']['lines']=[]
        with self.assertRaises(ValueError):validate(c)
    def test_classification_preserves_uncertainty(self):
        self.assertEqual(runner.classify(1,False,'FM1_STAGE exporting\nunknown operator')[0],'fixture_or_export_failure')
        self.assertEqual(runner.classify(1,False,'FM1_STAGE checking\ndouble arithmetic')[0],'portability_audit_failure')
        self.assertEqual(runner.classify(1,False,'FM1_STAGE compiling\npool exhausted')[0],'resource_limit')
        self.assertEqual(runner.classify(1,False,'FM1_STAGE compiling\npermission denied')[0],'blocked_environment')
        self.assertEqual(runner.classify(1,False,'unrelated compile error','reject')[0],'compile_or_validation_failure')
        self.assertEqual(runner.classify(1,False,'Patch initialization/channel/parameter check failed','reject')[0],'expected_reject')
        self.assertEqual(runner.classify(0,False,'','reject')[0],'unexpected_accept')
        self.assertEqual(runner.classify(1,True,'')[0],'timeout')
    def test_source_parameters_are_not_mutated(self):
        cases=make_cases();a=cases[0].config.copy();cases[1].config['pool_bytes']=1
        self.assertEqual(cases[0].config,a)
    def test_report_cannot_call_generation_a_pass(self):
        with tempfile.TemporaryDirectory(dir=APP/'build') as path:
            out=Path(path);rc=runner.main(['--generate-only','--out',str(out),'--limit','3'])
            self.assertEqual(rc,0);report=json.loads((out/'report.json').read_text())
            self.assertEqual({c['status'] for c in report['cases']},{'generated_not_compiled'})
            self.assertFalse(report['hardware_test'])
    def test_real_native_process_probe_rejects_bad_contracts(self):
        # Real compilation and execution of controlled C fixtures exercise the
        # tester itself, not RNBO's generator, runtime or device compatibility.
        with tempfile.TemporaryDirectory() as directory:
            root=Path(directory);source=root/'fixture.c';source.write_text(C_SOURCE)
            for bad in range(5):
                lib=root/f'fixture{bad}.so'
                subprocess.run([os.environ.get('CC_TEST','gcc'),'-dynamiclib' if sys.platform=='darwin' else '-shared','-fPIC','-O1',f'-DBAD={bad}',str(source),'-o',str(lib)],check=True)
                if bad==0:self.assertFalse(run(lib,'audible')['hardware_test'])
                else:
                    with self.assertRaises(AssertionError):run(lib,'audible')

if __name__=='__main__':
    (APP/'build').mkdir(exist_ok=True);unittest.main()
