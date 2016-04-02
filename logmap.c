#include "csdl.h"
#include "opcode_utils.h"

#define OPCODE_NAME "logmap"
#define OPCODE_MULTICORE_FLAGS 0
#define OPCODE_ACTIVE OPCODE_ITIME | OPCODE_KTIME
#define OPCODE_INTYPE "ki"
#define OPCODE_OUTTYPE "k"

typedef 
struct logmap {
  OPDS h;
  MYFLT *out;
  MYFLT *trig, *x0;
  MYFLT r, x, xm1;
} logmap;

static 
int op_init(CSOUND *csnd, logmap *l)
{
  l->x = (*(l->x0) < (MYFLT)1.0 && *(l->x0) > (MYFLT)0.0) ? *(l->x0) : (MYFLT)0.01;
  l->r = (MYFLT)4.0;
  return OK;
}

static inline 
MYFLT lgmp(logmap *l)
{
    l->xm1 = l->x;
    l->x = l->r * l->xm1 * ((MYFLT)1.0 - l->xm1);
    return l->x;
}

static 
int op_k(CSOUND *csnd, logmap *l)
{
  if (*(l->trig)) {
    l->x = lgmp(l);
    *(l->out) = (MYFLT)l->x;
  }
  return OK;
}

static 
OENTRY localops[] = {
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
