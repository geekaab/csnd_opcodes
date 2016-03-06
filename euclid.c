#include "csdl.h"
#include "opcode_utils.h"

#define OPCODE_NAME "euclid"
#define OPCODE_MULTICORE_FLAGS 0
#define OPCODE_ACTIVE OPCODE_ITIME | OPCODE_KTIME
#define OPCODE_INTYPE "kkkk"
#define OPCODE_OUTTYPE "k"

typedef struct _euclid {
  OPDS h;
  /* outputs: */
  MYFLT *bang;
  /* inputs: */
  MYFLT *trig;
  MYFLT *nhits;
  MYFLT *nsteps;
  MYFLT *rot;
  /* local state: */
  unsigned int cnt;
} euclid;

static int op_init(CSOUND *csnd, euclid *e)
{
  *(e->bang) = (MYFLT)0;
  e->cnt = 0;
  return OK;
}

static int op_k(CSOUND *csnd, euclid *e)
{
  int n = (int)floor(*(e->nhits));
  int N = (int)floor(*(e->nsteps));
  int r = (int)floor(*(e->rot));
  if (*(e->trig)) {
    if (((e->cnt + r) * n) % N < n)
      *(e->bang) = (MYFLT)1;
    e->cnt = (e->cnt + 1) & 0xffffffff;
  } else *(e->bang) = (MYFLT)0;
  return OK;
}

static OENTRY localops[] = {
  { 
    OPCODE_NAME, 
    sizeof(euclid), 
    OPCODE_MULTICORE_FLAGS, 
    OPCODE_ACTIVE, 
    OPCODE_OUTTYPE, 
    OPCODE_INTYPE, 
    (SUBR)op_init, 
    (SUBR)op_k,
    NULL
  }
};

LINKAGE
