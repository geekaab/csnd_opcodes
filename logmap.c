#include "csdl.h"
#include "opcode_utils.h"

#define OPCODE_NAME "logmap"
#define OPCODE_MULTICORE_FLAGS 0
#define OPCODE_ACTIVE OPCODE_ITIME | OPCODE_KTIME
#define OPCODE_INTYPE "ki"
#define OPCODE_OUTTYPE "k"

typedef struct _logmap {
  OPDS h;
  /* outputs: */
  MYFLT *out;
  /* inputs: */
  MYFLT *trig;
  MYFLT *x0;
  double r, x, xm1;
} logmap;

static int op_init(CSOUND *csnd, logmap *l)
{
  l->x = *(l->x0);
  l->r = (MYFLT)4.0;
  return OK;
}

static int op_k(CSOUND *csnd, logmap *l)
{
  if (*(l->trig)) {
    l->xm1 = l->x;
    l->x = l->r * l->xm1 * ((MYFLT)1.0 - l->xm1);
    *(l->out) = (MYFLT)l->x;
  }
  return OK;
}

static OENTRY localops[] = {
  { 
    OPCODE_NAME, 
    sizeof(logmap), 
    OPCODE_MULTICORE_FLAGS, 
    OPCODE_ACTIVE, 
    OPCODE_OUTTYPE, 
    OPCODE_INTYPE, 
    (SUBR)op_init, 
    (SUBR)op_k ,
    NULL
  }
};

LINKAGE
